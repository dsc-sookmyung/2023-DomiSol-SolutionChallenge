package domisol.domain.member.controller;

import domisol.domain.member.dto.request.MemberLoginRequest;
import domisol.domain.member.dto.request.SignUpRequest;
import domisol.domain.member.dto.response.MemberInfoResponse;
import domisol.domain.member.dto.response.MemberLoginResponse;
import domisol.domain.member.entity.Member;
import domisol.domain.member.service.MemberService;
import domisol.global.BaseResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/members")
public class MemberController {

    private final MemberService memberService;

    @ResponseBody
    @GetMapping("/login")
    public BaseResponse<MemberLoginResponse> login(@RequestBody MemberLoginRequest request) {
        return new BaseResponse<>(memberService.login(request));
    }

}
