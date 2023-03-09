package domisol.domain.member.controller;

import domisol.domain.member.dto.response.MemberInfoResponse;
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
    public void test() {
        System.out.println("test");
    }

    @ResponseBody
    @GetMapping("info")
    public BaseResponse<MemberInfoResponse> login(@RequestParam("code") String code) {
        return new BaseResponse<>(memberService.login(code));
    }

}
