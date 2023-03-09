package domisol.controller;

import domisol.dto.request.MemberLoginRequest;
import domisol.dto.response.MemberInfoResponse;
import domisol.dto.response.MemberLoginResponse;
import domisol.global.BaseResponse;
import domisol.service.MemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/members")
public class MemberController {

    private final MemberService memberService;

    @ResponseBody
    @GetMapping("/info")
    public BaseResponse<MemberInfoResponse> getUserInfo(@RequestParam String code) {
        return new BaseResponse<>(memberService.getUserInfo(code));
    }
}
