package domisol.domain.member.service;

import domisol.domain.member.dto.response.MemberInfoResponse;
import domisol.domain.member.entity.GoogleOAuth;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;


@RequiredArgsConstructor
@Service
public class MemberService {

    private final GoogleOAuth google;

    public MemberInfoResponse login(String code) {
        String accessToken = google.getAccessToken(code);
        MemberInfoResponse userInfo = google.getUserInfo(accessToken);


        return userInfo;
    }


}
