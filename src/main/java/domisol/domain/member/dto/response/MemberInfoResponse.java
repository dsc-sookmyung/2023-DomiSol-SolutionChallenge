package domisol.domain.member.dto.response;

import domisol.domain.member.entity.Member;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public class MemberInfoResponse {
    private String socialId;
    private String email;
    private String nickname;

    public static MemberInfoResponse of(Member member) {
        return new MemberInfoResponse(member.getSocialId(), member.getEmail(), member.getNickname());
    }

}
