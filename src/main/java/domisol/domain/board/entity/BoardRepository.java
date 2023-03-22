package domisol.domain.board.entity;

import domisol.global.common.Status;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface BoardRepository extends JpaRepository<Board, Long> {
    List<Board> findByMemberId(Long memberId);
    Optional<Board> findByIdAndStatus(Long id, Status status);
}
