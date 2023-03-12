package domisol.domain.member.dto.response;

import domisol.domain.member.entity.Member;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class MemberLoginResponse {
    private Long userId;
    private String accessToken;
    private String refreshToken;


    public static MemberLoginResponse of(Member member, TokenResponse token) {
        return new MemberLoginResponse(member.getId(), token.getAccessToken(), token.getRefreshToken());
    }
}
