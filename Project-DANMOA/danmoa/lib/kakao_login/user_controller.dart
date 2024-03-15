import 'package:flutter/material.dart';
import './kakao_api.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart'; // User, UserApi, isKakaoTalkInstalled


class UserController with ChangeNotifier {
  User? _user;
  KakaoLoginApi kakaoLoginApi;
  User? get user => _user;

  UserController({required this.kakaoLoginApi});
  
  
  // 카카오 로그인
  Future<void> kakaoLogin() async {
    try {
      var user = await kakaoLoginApi.signWithKakao();
      print("정보전달중");
      print(user);
      try {
        User user = await UserApi.instance.me();
        print('사용자 정보 요청 성공'
              '\n회원번호: ${user.id}'
              '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
              '\n이메일: ${user.kakaoAccount?.email}');
      } catch (error) {
        print('사용자 정보 요청 실패 $error');
      }
      if (user != null) {
        _user = user;
        notifyListeners();
      }
    } catch (error) {
      print("로그인 실패: $error");
    }
  }
}