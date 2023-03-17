package domisol.domain.board.service;

import domisol.domain.board.dto.request.BoardRequest;
import domisol.domain.board.dto.response.BoardResponse;
import domisol.domain.board.entity.BoardRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor
@Service
public class BoardService {

    private final BoardRepository boardRepository;

    public Object crateBoard(BoardRequest request) {
        return BoardResponse.of(boardRepository.save(request.toEntity()));
    }
}
