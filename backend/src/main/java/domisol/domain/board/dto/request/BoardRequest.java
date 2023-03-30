package domisol.domain.board.dto.request;

import domisol.domain.board.entity.Board;
import domisol.global.common.Status;
import lombok.Builder;
import lombok.Getter;

import static domisol.global.common.Status.ACTIVE;

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
                .status(ACTIVE)
                .build();
    }
}
