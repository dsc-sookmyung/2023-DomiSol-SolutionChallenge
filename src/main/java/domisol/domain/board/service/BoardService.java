package domisol.domain.board.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import domisol.domain.board.dto.request.BoardRequest;
import domisol.domain.board.dto.request.WordRequest;
import domisol.domain.board.dto.response.*;
import domisol.domain.board.entity.Board;
import domisol.domain.board.entity.BoardRepository;
import domisol.domain.board.entity.Word;
import domisol.domain.board.entity.WordRepository;
import domisol.domain.member.entity.Member;
import domisol.domain.member.entity.MemberRepository;
import domisol.global.BaseException;
import domisol.global.util.MemberFacade;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import static domisol.global.StatusCode.BOARD_NOT_FOUND;
import static domisol.global.StatusCode.MEMBER_NOT_FOUND;
import static domisol.global.common.Status.ACTIVE;
import static domisol.global.common.Status.DELETE;

@RequiredArgsConstructor
@Service
public class BoardService {

    private final MemberRepository memberRepository;
    private final BoardRepository boardRepository;
    private final WordRepository wordRepository;
    private final MemberFacade memberFacade;

    @Transactional
    public BoardResponse create(BoardRequest request) {
        Board board = boardRepository.save(request.toEntity());
        board.setMember(memberFacade.getCurrentMember());
        return BoardResponse.of(board);
    }

    @Transactional
    public BoardDetailResponse finish(Long id) {
        Board board = boardRepository.findByIdAndStatus(id, ACTIVE).orElseThrow(() -> new BaseException(BOARD_NOT_FOUND));
        board.setEndTime(LocalDateTime.now());
        return BoardDetailResponse.of(board);
    }

    @Transactional
    public BoardResponse update(Long id, BoardRequest request) {
        Board board = boardRepository.findByIdAndStatus(id, ACTIVE).orElseThrow(() -> new BaseException(BOARD_NOT_FOUND));
        board.set(request.getTitle(), request.getLocation(), request.getMemo());
        return BoardResponse.of(board);
    }

    @Transactional
    public BoardCompactResponse delete(Long id) {
        Board board = boardRepository.findByIdAndStatus(id, ACTIVE).orElseThrow(() -> new BaseException(BOARD_NOT_FOUND));
        board.setStatus(DELETE);
        return BoardCompactResponse.of(board);
    }

    public List<BoardDetailResponse> findAll() {
        Member member = memberRepository.findById(memberFacade.getCurrentMember().getId()).orElseThrow(() -> new BaseException(MEMBER_NOT_FOUND));
        List<Board> boards = boardRepository.findByMemberIdAndStatus(member.getId(), ACTIVE).orElseThrow(() -> new BaseException(BOARD_NOT_FOUND));
        return BoardDetailResponse.of(boards);
    }

    @Transactional
    public void saveResult(List<WordRequest> request) {
        try {
            Board board = boardRepository.findByIdAndStatus(request.get(0).getBoardId(), ACTIVE).orElseThrow(() -> new BaseException(BOARD_NOT_FOUND));
            List<Word> words = serializeRequest(request, board);
            for (Word w : words) {
                wordRepository.save(w);
            }
        } catch (JsonProcessingException e) {
            e.getMessage();
        }
    }

    private List<Word> serializeRequest(List<WordRequest> request, Board board) throws JsonProcessingException {
        ObjectMapper objectMapper = new ObjectMapper();
        String serializedResponse = objectMapper.writeValueAsString(request);
        JsonNode jsonNode = objectMapper.readTree(serializedResponse);
        List<Word> words = new ArrayList<>();
        if (jsonNode.isArray()) {
            for (JsonNode node : jsonNode) {
                Long id = node.get("boardId").asLong();
                String word = node.get("word").asText();
                int frequency = node.get("frequency").asInt();
                Word newWord = new Word(word, frequency);
                newWord.setBoard(board);
                words.add(newWord);
            }
        }
        return words;
    }

    @Transactional
    public WordResponse getResult(Long id) {
        Board board = boardRepository.findByIdAndStatus(id, ACTIVE).orElseThrow(() -> new BaseException(BOARD_NOT_FOUND));
        List<Word> words = wordRepository.findByBoardId(id);
        List<WordDetailResponse> wordDetail = WordDetailResponse.of(words);
        return WordResponse.of(board, wordDetail);
    }
}
