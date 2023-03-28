package domisol.domain.board.service;

import com.fasterxml.jackson.core.JsonProcessingException;
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

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import static domisol.global.StatusCode.BOARD_NOT_FOUND;
import static domisol.global.StatusCode.MEMBER_NOT_FOUND;
import static domisol.global.common.Status.ACTIVE;
import static domisol.global.common.Status.DELETE;
import static java.time.DayOfWeek.*;

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
                if (wordRepository.existsByWord(w.getWord())) {
                    Word exists = wordRepository.findByWord(w.getWord());
                    exists.setFrequency(exists.getFrequency() + w.getFrequency());
                } else {
                    wordRepository.save(w);
                }
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

    @Transactional
    public List<WordDetailResponse> getDaily() {
        Member member = memberRepository.findById(memberFacade.getCurrentMember().getId()).orElseThrow(() -> new BaseException(MEMBER_NOT_FOUND));

        LocalDateTime startDatetime = LocalDateTime.of(LocalDate.now().minusDays(1), LocalTime.of(0,0,0)); //어제 00:00:00
        LocalDateTime endDatetime = LocalDateTime.of(LocalDate.now(), LocalTime.of(23,59,59));

        List<Board> boards = boardRepository.findAllByMemberIdAndStartTimeBetween(member.getId(), startDatetime, endDatetime);
        List<Word> list = new ArrayList<>();
        for (Board b : boards) {
            List<Word> words = wordRepository.findByBoardId(b.getId());
            for (Word w : words) {
                list.add(w);
            }
        }
        return WordDetailResponse.of(list);
    }

    @Transactional
    public BoardWeeklyResponse getWeekly() {
        Member member = memberRepository.findById(memberFacade.getCurrentMember().getId()).orElseThrow(() -> new BaseException(MEMBER_NOT_FOUND));
        WeekResponse week = setDay();
        List<Board> boards = boardRepository.findAllByMemberIdAndStartTimeBetween(member.getId(), week.getStart(), week.getEnd());

        int monday_cnt = 0;
        int tuesday_cnt = 0;
        int wednesday_cnt = 0;
        int thursday_cnt = 0;
        int friday_cnt = 0;
        int saturday_cnt = 0;
        int sunday_cnt = 0;

        for (Board b : boards) {
            DayOfWeek day = b.getStartTime().getDayOfWeek();


            System.out.println("===== day : " + day);

            if (day.equals(MONDAY)) {
                List<Word> words = wordRepository.findByBoardId(b.getId());
                for (Word w : words) {
                    monday_cnt += w.getFrequency();
                }
            }
            if (day.equals(TUESDAY)) {
                List<Word> words = wordRepository.findByBoardId(b.getId());
                for (Word w : words) {
                    tuesday_cnt += w.getFrequency();
                }
            }
            if (day.equals(WEDNESDAY)) {
                List<Word> words = wordRepository.findByBoardId(b.getId());
                for (Word w : words) {
                    wednesday_cnt += w.getFrequency();
                    System.out.println("======== " + w + "==== " +  day);

                }
            }
            if (day.equals(THURSDAY)) {
                List<Word> words = wordRepository.findByBoardId(b.getId());
                for (Word w : words) {
                    thursday_cnt += w.getFrequency();
                }
            }
            if (day.equals(FRIDAY)) {
                List<Word> words = wordRepository.findByBoardId(b.getId());
                for (Word w : words) {
                    friday_cnt += w.getFrequency();
                }
            }
            if (day.equals(SATURDAY)) {
                List<Word> words = wordRepository.findByBoardId(b.getId());
                for (Word w : words) {
                    saturday_cnt += w.getFrequency();;
                }
            }
            if (day.equals(SUNDAY)) {
                List<Word> words = wordRepository.findByBoardId(b.getId());
                for (Word w : words) {
                    sunday_cnt += w.getFrequency();;
                }
            }
        }

        return new BoardWeeklyResponse(monday_cnt, tuesday_cnt, wednesday_cnt, thursday_cnt, friday_cnt, saturday_cnt, sunday_cnt);
    }

    private WeekResponse setDay() {
        LocalDateTime now = LocalDateTime.now();
        int day = now.getDayOfWeek().getValue();
        LocalDateTime startDatetime = null;
        LocalDateTime endDatetime = null;
        switch (day) {
            case 0 : { // 월요일
                startDatetime = LocalDateTime.of(LocalDate.now(), LocalTime.of(0,0,0)); //어제 00:00:00
                endDatetime = LocalDateTime.of(LocalDate.now().plusDays(6), LocalTime.of(23,59,59));
                System.out.println("s : " + startDatetime);
                System.out.println("e : " + endDatetime);
            }
            case 1 : {
                startDatetime = LocalDateTime.of(LocalDate.now().minusDays(1), LocalTime.of(0,0,0)); //어제 00:00:00
                endDatetime = LocalDateTime.of(LocalDate.now().plusDays(5), LocalTime.of(23,59,59));
            }
            case 2 : {
                startDatetime = LocalDateTime.of(LocalDate.now().minusDays(2), LocalTime.of(0,0,0)); //어제 00:00:00
                endDatetime = LocalDateTime.of(LocalDate.now().plusDays(4), LocalTime.of(23,59,59));
            }
            case 3 : {
                startDatetime = LocalDateTime.of(LocalDate.now().minusDays(3), LocalTime.of(0,0,0)); //어제 00:00:00
                endDatetime = LocalDateTime.of(LocalDate.now().plusDays(3), LocalTime.of(23,59,59));
            }
            case 4  : {
                startDatetime = LocalDateTime.of(LocalDate.now().minusDays(4), LocalTime.of(0,0,0)); //어제 00:00:00
                endDatetime = LocalDateTime.of(LocalDate.now().plusDays(2), LocalTime.of(23,59,59));
            }
            case 5 : {
                startDatetime = LocalDateTime.of(LocalDate.now().minusDays(5), LocalTime.of(0,0,0)); //어제 00:00:00
                endDatetime = LocalDateTime.of(LocalDate.now().plusDays(1), LocalTime.of(23,59,59));
            }
            case 6 : {
                startDatetime = LocalDateTime.of(LocalDate.now().minusDays(6), LocalTime.of(0,0,0)); //어제 00:00:00
                endDatetime = LocalDateTime.of(LocalDate.now().plusDays(0), LocalTime.of(23,59,59));
            }
        }
        return new WeekResponse(startDatetime, endDatetime);
    }

}
