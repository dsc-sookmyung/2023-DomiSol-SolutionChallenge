package domisol.domain.board.controller;

import domisol.domain.board.dto.VoiceResponse;
import domisol.global.BaseResponse;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/boards")
public class BoardController {

    @GetMapping("/test")
    public BaseResponse<List<VoiceResponse>> getJson(@RequestBody List<VoiceResponse> response) {
        return new BaseResponse<>(response);
    }



}
