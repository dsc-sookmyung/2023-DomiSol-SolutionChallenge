package domisol.controller;

import domisol.dto.response.MemberInfoResponse;
import domisol.global.BaseResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/members")
public class MemberController {
    @ResponseBody
    @GetMapping("/info")
    public BaseResponse<MemberInfoResponse> getUserInfo(@RequestParam String code) {
        return new BaseResponse<>(memberService.getUserInfo(code));
    }

    @ResponseBody
    @PostMapping("/login")
    public BaseResponse<MemberLoginResponse> login(@RequestBody MemberLoginRequest request) {
        return new BaseResponse<>(socialService.login(request));
    }
}
