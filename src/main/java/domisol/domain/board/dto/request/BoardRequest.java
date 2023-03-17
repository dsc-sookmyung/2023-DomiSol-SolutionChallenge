package domisol.domain.board.dto.request;

import domisol.domain.board.entity.Board;
import lombok.Builder;
import lombok.Getter;

@Getter
public class BoardRequest {
    private String location;
    private String description;

    @Builder
    public Board toEntity() {
        return Board.builder()
                .location(location)
                .description(description)
                .build();
    }
}
