package domisol.domain.member.dto.response;

import domisol.domain.member.entity.Member;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class LoginResponse {
    private Long userId;
    private String accessToken;
    private String refreshToken;

    public static LoginResponse of(Member member, TokenResponse token) {
        return new LoginResponse(member.getId(), token.getAccessToken(), token.getRefreshToken());
    }
}
