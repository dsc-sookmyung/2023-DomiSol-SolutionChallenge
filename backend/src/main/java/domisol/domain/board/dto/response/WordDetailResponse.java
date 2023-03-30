package domisol.domain.board.dto.response;

import domisol.domain.board.entity.Word;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Getter
@AllArgsConstructor
@NoArgsConstructor
public class WordDetailResponse {
    private String word;
    private int frequency;
    private double ratio;

    public static List<WordDetailResponse> of(List<Word> words) {
        List<WordDetailResponse> list = new ArrayList<>();
        double count = words.stream().mapToDouble(Word::getFrequency).sum();
        for (Word w : words) {
            double ratio = (double)w.getFrequency()/count * 100.0;
            list.add(new WordDetailResponse(w.getWord(), w.getFrequency(), Math.round(ratio)));
        }
        return list;
    }
}
