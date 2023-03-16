package domisol.domain.board.controller;

import domisol.domain.board.dto.VoiceResponse;
import domisol.global.BaseResponse;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/boards")
public class BoardController {

    @GetMapping("/test")
    public BaseResponse<VoiceResponse> getJson(@RequestBody VoiceResponse response) {
        return new BaseResponse<>(response);
    }



}
