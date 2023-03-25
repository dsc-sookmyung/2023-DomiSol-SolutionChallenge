import 'goolge_login_response.dart';
import 'package:flutter_/api/dio_setting.dart';
import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginController {
  final storage = const FlutterSecureStorage();

  Dio dio = createDioClient();

  Future<googleLoginResponse?> googleLogin(GoogleSignInAccount user) async {
    Map<String, String> userInfo = {
      'email': user.email,
      'socialId': user.id,
      'nickname': user.displayName ?? user.email,
      'profileImage' : user.photoUrl?? '',
    };

    try {
      print(userInfo);
      var response = await dio.get(
        '/api/members/login',
        data: userInfo,
        options: Options(contentType: Headers.jsonContentType),
        
      );
      print(response.statusCode);
      
      await storage.write(key: 'accessToken', value: response.data['result']['accessToken']);

      return googleLoginResponse(token: response.data['accessToken']);
    } catch (e) {
      print(e);
    }
    return null;
  }
}
