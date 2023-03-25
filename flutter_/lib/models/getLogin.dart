class GetLogin {
  final isSuccess;
  final String code;
  final message;
  final result;

  GetLogin({
    required this.isSuccess,
    required this.code,
    required this.message,
    required this.result,
  });

  factory GetLogin.fromJson(Map<String, dynamic> json) => GetLogin(
        isSuccess: json['is_success'],
        code: json['code'],
        message: json['message'],
        result: json['result'],
      );

  Map<String, dynamic> toJson() => {
        'isSuccess': isSuccess,
        'code': code,
        'message': message,
        'result': result,
      };
}
