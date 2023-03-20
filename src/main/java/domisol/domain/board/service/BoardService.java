package domisol.domain.board.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import domisol.domain.board.dto.request.BoardRequest;
import domisol.domain.board.dto.request.WordRequest;
import domisol.domain.board.dto.response.BoardResponse;
import domisol.domain.board.entity.Board;
import domisol.domain.board.entity.BoardRepository;
import domisol.domain.board.entity.Word;
import domisol.domain.board.entity.WordRepository;
import domisol.global.BaseException;
import domisol.global.StatusCode;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

import static domisol.global.StatusCode.BOARD_NOT_FOUND;
import static domisol.global.common.Status.DELETE;

@RequiredArgsConstructor
@Service
public class BoardService {

    private final BoardRepository boardRepository;
    private final WordRepository wordRepository;

    public BoardResponse create(BoardRequest request) {
        return BoardResponse.of(boardRepository.save(request.toEntity()));
    }

    public BoardResponse update(Long id, BoardRequest request) {
        Board board = boardRepository.findById(id).orElseThrow(() -> new BaseException(BOARD_NOT_FOUND));
        board.setDescription(request.getDescription());
        board.setLocation(request.getLocation());
        return BoardResponse.of(board);
    }

    public Long delete(Long id) {
        Board board = boardRepository.findById(id).orElseThrow(() -> new BaseException(BOARD_NOT_FOUND));
        board.setStatus(DELETE);
        return board.getId();
    }


    public void getResult(List<WordRequest> request) {
        try {
            List<Word> words = serializeRequest(request);
            Board board = boardRepository.findById(request.getBoardId());

            for (Word v : words) {
                Word newWord = new Word(v.getWord(), v.getFrequency());
                newWord.setBoard(baord);
                wordRepository.save(newWord);
            }

        } catch (JsonProcessingException e) {
            e.getMessage();
        }
    }

    private List<Word> serializeRequest(List<WordRequest> request) throws JsonProcessingException {
        ObjectMapper objectMapper = new ObjectMapper();
        String serializedResponse = objectMapper.writeValueAsString(request);
        List<Word> word = objectMapper.readValue(serializedResponse, new TypeReference<>(){});
        return word;
    }
}
