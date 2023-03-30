package domisol.domain.board.dto.response;

import domisol.domain.board.entity.Board;
import domisol.domain.board.entity.Word;
import domisol.domain.board.entity.WordRepository;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class WordResponse {
    // 시간도 추가되어야할듯..?
    private Long boardId;
    private String title;
    private String location;
    private LocalDateTime startTime;
    private LocalDateTime endTime;
    private String memo;
    private List<WordDetailResponse> statistic;

    public static WordResponse of(Board board, List<WordDetailResponse> words) {
        return new WordResponse(board.getId(), board.getTitle(), board.getLocation(), board.getStartTime(),
                board.getEndTime(), board.getMemo(), words);
    }

}
