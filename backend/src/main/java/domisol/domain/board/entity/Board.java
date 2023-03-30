package domisol.domain.board.entity;

import domisol.domain.member.entity.Member;
import domisol.global.common.Status;
import lombok.Builder;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import javax.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;


@EntityListeners(AuditingEntityListener.class)
@RequiredArgsConstructor
@Getter
@Entity
public class Board {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;

    private String location;

    @CreatedDate
    private LocalDateTime startTime;

    @LastModifiedDate
    private LocalDateTime endTime;

    private String memo;

    @Enumerated(EnumType.STRING)
    private Status status;

    @ManyToOne
    private Member member;

    public void set(String title, String location, String memo) {
        this.title = title;
        this.location = location;
        this.memo = memo;
    }

    public void setEndTime(LocalDateTime endTime) {
        this.endTime = endTime;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public void setMember(Member member) {
        this.member = member;
    }

    @Builder
    public Board(String title, String location, String memo, Status status, LocalDateTime startTime) {
        this.title = title;
        this.location = location;
        this.memo = memo;
        this.status = status;
        this.startTime = startTime;
    }

}
