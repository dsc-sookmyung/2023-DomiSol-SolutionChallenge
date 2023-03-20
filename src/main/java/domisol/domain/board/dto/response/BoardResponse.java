package domisol.domain.board.dto.response;

import domisol.domain.board.entity.Board;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

import java.util.List;
import java.util.stream.Collectors;

@Getter
@AllArgsConstructor
@RequiredArgsConstructor
@Builder
public class BoardResponse {
    private Long boardId;
    private String title;
    private String location;
    private String memo;

    public static BoardResponse of(Board board) {
        return new BoardResponse(board.getId(), board.getTitle(), board.getLocation(), board.getMemo());
    }

    public static List<BoardResponse> of (List<Board> boards) {
        return boards.stream().map(BoardResponse::of).collect(Collectors.toList());
    }
}
