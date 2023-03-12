package domisol.domain.member.service;

import domisol.domain.member.dto.request.LoginRequest;
import domisol.domain.member.dto.request.SignUpRequest;
import domisol.domain.member.dto.response.MemberInfoResponse;
import domisol.domain.member.dto.response.LoginResponse;
import domisol.domain.member.dto.response.TokenResponse;
import domisol.domain.member.entity.GoogleOAuth;
import domisol.domain.member.entity.Member;
import domisol.domain.member.entity.MemberRepository;
import domisol.global.BaseException;
import domisol.global.jwt.JwtTokenProvider;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import static domisol.global.StatusCode.EMAIL_NOT_FOUND;


@RequiredArgsConstructor
@Service
public class MemberService {

    private final GoogleOAuth google;
    private final MemberRepository memberRepository;
    private final PasswordEncoder passwordEncoder;
    private final AuthenticationManagerBuilder authenticationManagerBuilder;
    private final JwtTokenProvider jwtTokenProvider;

    public LoginResponse login(LoginRequest request) {
        MemberInfoResponse memberInfo = getMemberInfoFromGoogle(request);
        Member member = findMemberAndSignUpIfNotExists(memberInfo);
        TokenResponse tokenResponse = createMemberToken(memberInfo);
        return LoginResponse.of(member, tokenResponse);
    }

    private MemberInfoResponse getMemberInfoFromGoogle(LoginRequest request) {
        String accessToken = google.getAccessToken(request.getCode());
        MemberInfoResponse userInfo = google.getUserInfo(accessToken);
        return userInfo;
    }

    private Member findMemberAndSignUpIfNotExists(MemberInfoResponse memberInfo) {
        Member member;
        if (!memberRepository.existsByEmail(memberInfo.getEmail())) {
            member = signup(new SignUpRequest(memberInfo.getSocialId(), memberInfo.getEmail(), memberInfo.getNickname()));
        } else {
            member = memberRepository.findByEmail(memberInfo.getEmail()).orElseThrow(() -> new BaseException(EMAIL_NOT_FOUND));
        }
        return member;
    }

    private TokenResponse createMemberToken(MemberInfoResponse memberInfo) {
        UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(memberInfo.getEmail(), memberInfo.getSocialId());
        Authentication authentication = authenticationManagerBuilder.getObject().authenticate(authenticationToken);
        TokenResponse tokenResponse = jwtTokenProvider.createToken(authentication);
        return tokenResponse;
    }

    private Member signup(SignUpRequest request) {
        Member member = request.toEntity(passwordEncoder);
        return memberRepository.save(member);
    }
}
