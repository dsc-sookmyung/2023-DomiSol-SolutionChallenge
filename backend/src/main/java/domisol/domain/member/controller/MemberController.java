package domisol.domain.member.controller;

import domisol.domain.member.dto.request.LoginRequest;
import domisol.domain.member.dto.response.LoginResponse;
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
    @GetMapping("/test")
    public String test() {
        return "test";
    }

    @ResponseBody
    @GetMapping("/login")
    public BaseResponse<LoginResponse> login(@RequestBody LoginRequest request) {
        return new BaseResponse<>(memberService.login(request));
    }
}
