package domisol.domain.board.controller;

import domisol.domain.board.dto.request.BoardRequest;
import domisol.domain.board.dto.request.WordRequest;
import domisol.domain.board.dto.response.BoardResponse;
import domisol.domain.board.service.BoardService;
import domisol.global.BaseResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/boards")
public class BoardController {

    private final BoardService boardService;

    @PostMapping("")
    public BaseResponse<BoardResponse> createBoard(@RequestBody BoardRequest request) {
        return new BaseResponse(boardService.crateBoard(request));
    }

    @GetMapping("/test")
    public void getResult(@RequestBody List<WordRequest> request) {
        boardService.getResult(request);
    }

}
