package domisol.global.util;

import domisol.domain.member.entity.Member;
import domisol.domain.member.entity.MemberRepository;
import domisol.global.BaseException;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;

import static domisol.global.StatusCode.MEMBER_NOT_FOUND;

@RequiredArgsConstructor
@Component
public class MemberFacade {

    private final MemberRepository memberRepository;

    public Member getCurrentMember() {
        String email = SecurityContextHolder.getContext().getAuthentication().getName();
        if(email.equals("anonymousUser"))
            throw new BaseException(MEMBER_NOT_FOUND);
        return memberRepository.findByEmail(email).orElseThrow(() -> new BaseException(MEMBER_NOT_FOUND));
    }
}
