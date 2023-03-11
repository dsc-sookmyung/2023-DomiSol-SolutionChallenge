package domisol.domain.member.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Entity
public class Member {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String email;

    private String nickname;

    private String socialId; // 소셜아이디로

    private String status;

    @Enumerated(EnumType.STRING)
    private Authority authority;



    @Builder
    public Member(String email, String nickname, String socialId, String status, Authority authority) {
        this.email = email;
        this.nickname = nickname;
        this.socialId = socialId;
        this.status = status;
        this.authority = authority;
    }
}
