package domisol.domain.board.controller;

import domisol.domain.board.dto.request.BoardRequest;
import domisol.domain.board.dto.request.WordRequest;
import domisol.domain.board.dto.response.BoardDetailResponse;
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

    /* 측정 생성하기 */
    @ResponseBody
    @PostMapping("")
    public BaseResponse<BoardResponse> create(@RequestBody BoardRequest request) {
        return new BaseResponse(boardService.create(request));
    }

    /* 측정 수정하기 */
    @ResponseBody
    @PatchMapping("/{id}")
    public BaseResponse<BoardResponse> update(@PathVariable Long id, @RequestBody BoardRequest request) {
        return new BaseResponse<>(boardService.update(id, request));
    }

    /* 측정 삭제하기 */
    @ResponseBody
    @DeleteMapping("/{id}")
    public BaseResponse<Long> delete(@PathVariable Long id) {
        return new BaseResponse<>(boardService.delete(id));
    }

    /* 측정 데이터 모두 조회하기 */
    @ResponseBody
    @GetMapping("")
    public BaseResponse<List<BoardDetailResponse>> findAll() {
        return new BaseResponse<>(boardService.findAll());
    }

    /* 전달 받은 데이터 저장 */
    @GetMapping("/test")
    public void getResult(@RequestBody List<WordRequest> request) {
        boardService.getResult(request);
    }

}
