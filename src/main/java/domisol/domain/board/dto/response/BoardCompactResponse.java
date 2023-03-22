package domisol.domain.board.dto.response;

import domisol.domain.board.entity.Board;
import domisol.global.common.Status;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class BoardCompactResponse {
    private Long boardId;
    private Status status;

    public static BoardCompactResponse of(Board board) {
        return new BoardCompactResponse(board.getId(), board.getStatus());
    }
}
