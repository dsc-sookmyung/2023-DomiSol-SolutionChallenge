package domisol.global;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum StatusCode {

    SUCCESS(true, 200, "요청에 성공하였습니다."),

    EMAIL_NOT_FOUND(true, 400, "해당 이메일을 찾을 수 없습니다."),

    DATABASE_ERROR(false, 500, "데이터베이스 오류입니다.");

    private final boolean isSuccess;
    private final int code;
    private final String message;
}
