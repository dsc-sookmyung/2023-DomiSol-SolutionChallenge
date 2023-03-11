package domisol.domain.member.service;

import domisol.domain.member.dto.request.MemberLoginRequest;
import domisol.domain.member.dto.request.SignUpRequest;
import domisol.domain.member.dto.response.MemberInfoResponse;
import domisol.domain.member.dto.response.MemberLoginResponse;
import domisol.domain.member.dto.response.TokenResponse;
import domisol.domain.member.entity.GoogleOAuth;
import domisol.domain.member.entity.Member;
import domisol.domain.member.entity.MemberRepository;
import domisol.global.BaseException;
import domisol.global.jwt.JwtTokenProvider;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import static domisol.domain.member.entity.Authority.ROLE_USER;
import static domisol.global.StatusCode.EMAIL_NOT_FOUND;


@RequiredArgsConstructor
@Service
public class MemberService {

    private final GoogleOAuth google;
    private final MemberRepository memberRepository;
    private final PasswordEncoder passwordEncoder;
    private final AuthenticationManagerBuilder authenticationManagerBuilder;
    private final JwtTokenProvider jwtTokenProvider;

    public MemberLoginResponse login(MemberLoginRequest request) {
        String accessToken = google.getAccessToken(request.getCode());
        MemberInfoResponse userInfo = google.getUserInfo(accessToken);

        Member member;
        if (!memberRepository.existsByEmail(userInfo.getEmail())) {
            member = signup(new SignUpRequest(userInfo.getSocialId(), userInfo.getEmail(), userInfo.getNickname()));
        } else {
            member = memberRepository.findByEmail(userInfo.getEmail()).orElseThrow(() -> new BaseException(EMAIL_NOT_FOUND));
        }
        UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(member.getEmail(), userInfo.getSocialId());
        Authentication authentication = authenticationManagerBuilder.getObject().authenticate(authenticationToken);
        TokenResponse tokenResponse = jwtTokenProvider.createToken(authentication);
        return MemberLoginResponse.of(member, tokenResponse);
    }

    @Transactional
    public Member signup(SignUpRequest request) {
        Member member = request.toEntity(passwordEncoder);
        return memberRepository.save(member);
    }

}
