package domisol.domain.board.dto.request;

import domisol.domain.board.entity.Board;
import lombok.Builder;
import lombok.Getter;

@Getter
public class BoardRequest {
    private String title;
    private String location;
    private String memo;

    @Builder
    public Board toEntity() {
        return Board.builder()
                .title(title)
                .location(location)
                .memo(memo)
                .build();
    }
}
