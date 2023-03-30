package domisol.domain.board.entity;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface WordRepository extends JpaRepository<Word, Long> {
    List<Word> findByBoardId(Long boardId);
    boolean existsByBoardIdAndWord(Long boardId, String word);
    Word findByBoardIdAndWord(Long boardId, String word);
}
