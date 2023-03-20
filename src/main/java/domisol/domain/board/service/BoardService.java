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
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@RequiredArgsConstructor
@Service
public class BoardService {

    private final BoardRepository boardRepository;
    private final WordRepository wordRepository;

    public Object crateBoard(BoardRequest request) {
        return BoardResponse.of(boardRepository.save(request.toEntity()));
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
