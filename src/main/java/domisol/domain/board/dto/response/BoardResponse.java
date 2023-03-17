package domisol.domain.board.dto.response;

import domisol.domain.board.entity.Board;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@AllArgsConstructor
@RequiredArgsConstructor
@Builder
public class BoardResponse {
    private Long boardId;
    private String location;
    private String description;

    public static BoardResponse of(Board board) {
        return new BoardResponse(board.getId(), board.getLocation(), board.getDescription());
    }
}
