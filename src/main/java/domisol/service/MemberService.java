package domisol.service;

import domisol.dto.request.MemberLoginRequest;
import domisol.dto.response.MemberInfoResponse;
import domisol.dto.response.MemberLoginResponse;
import domisol.dto.response.TokenResponse;
import domisol.entity.GoogleOAuth;
import domisol.entity.Member;
import domisol.global.BaseException;
import domisol.repository.MemberRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import static domisol.global.StatusCode.EMAIL_NOT_FOUND;

@RequiredArgsConstructor
@Service
public class MemberService {

    private final MemberRepository memberRepository;
    private final GoogleOAuth google;

    public MemberInfoResponse getUserInfo(String code) {
        System.out.println("2");

        String accessToken = google.getAccessToken(code);
        System.out.println("3");

        MemberInfoResponse userInfo = google.getUserInfo(accessToken);
        return userInfo;
    }

    /*
    public MemberLoginResponse login(MemberLoginRequest request) {
        Member member = memberRepository.findByEmail(request.getEmail()).orElseThrow(() -> new BaseException(EMAIL_NOT_FOUND));

        UsernamePasswordAuthenticationToken authenticationToken = new UsernamePasswordAuthenticationToken(request.getEmail(), request.getSocialId());
       // Authentication authentication = authenticationManagerBuilder.getObject().authenticate(authenticationToken);
       // TokenResponse tokenResponse = jwtTokenProvider.createToken(authentication);

        // ValueOperations<String, String> valueOperations = redisTemplate.opsForValue();
        // valueOperations.set(member.getEmail(), tokenResponse.getRefreshToken());

        return MemberLoginResponse.of(member, tokenResponse);
    } */

}
