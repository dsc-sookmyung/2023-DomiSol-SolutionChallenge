package domisol.domain.board.dto.response;

import domisol.domain.board.entity.Board;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Getter
@NoArgsConstructor
@AllArgsConstructor
public class BoardDetailResponse {
    private Long boardId;
    private String title;
    private String location;
    private LocalDateTime startTime;
    private LocalDateTime endTime;

    public static BoardDetailResponse of(Board board) {
        return new BoardDetailResponse(board.getId(), board.getTitle(), board.getLocation(), board.getStartTime(), board.getEndTime());
    }

    public static List<BoardDetailResponse> of (List<Board> boards) {
        return boards.stream().map(BoardDetailResponse::of).collect(Collectors.toList());
    }
}
