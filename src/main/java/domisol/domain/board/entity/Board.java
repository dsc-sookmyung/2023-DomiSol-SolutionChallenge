package domisol.domain.board.entity;

import domisol.domain.member.entity.Member;
import domisol.global.common.Status;
import lombok.Builder;
import lombok.Getter;
import lombok.RequiredArgsConstructor;

import javax.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Getter
@RequiredArgsConstructor
@Entity
public class Board {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String location;

    private LocalDateTime startTime;

    private LocalDateTime endTime;

    private String description;

    @Enumerated(EnumType.STRING)
    private Status status;

    @ManyToOne
    private Member member;

    public void setDescription(String description) {
        this.description = description;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    @Builder
    public Board(String location, LocalDateTime startTime, String description) {
        this.location = location;
        this.startTime = startTime;
        this.description = description;
    }

}
