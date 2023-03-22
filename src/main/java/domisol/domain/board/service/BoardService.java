package domisol.domain.board.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import domisol.domain.board.dto.request.BoardRequest;
import domisol.domain.board.dto.request.WordRequest;
import domisol.domain.board.dto.response.BoardCompactResponse;
import domisol.domain.board.dto.response.BoardDetailResponse;
import domisol.domain.board.dto.response.BoardResponse;
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
import java.util.List;

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

    public void getResult(List<WordRequest> request) {
        try {
            List<Word> words = serializeRequest(request);
            Board board = boardRepository.findByIdAndStatus(request.get(0).getBoardId(), ACTIVE).orElseThrow(() -> new BaseException(BOARD_NOT_FOUND));
            for (Word v : words) {
                Word newWord = new Word(v.getWord(), v.getFrequency());
                newWord.setBoard(board);
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
