package domisol.domain.member.dto.request;

import domisol.domain.member.entity.Member;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;

import static domisol.domain.member.entity.Authority.ROLE_USER;
import static domisol.global.common.Status.ACTIVE;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class SignUpRequest {
    private String socialId;
    private String email;
    private String nickname;
    private String profileImage;

    @Builder
    public Member toEntity(PasswordEncoder passwordEncoder) {
        return Member.builder()
                .email(email)
                .nickname(nickname)
                .socialId(passwordEncoder.encode(socialId))
                .profileImage(profileImage)
                .status(ACTIVE)
                .authority(ROLE_USER)
                .build();
    }
}
