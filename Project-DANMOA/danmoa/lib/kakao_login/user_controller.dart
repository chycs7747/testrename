import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart'; // User, UserApi, isKakaoTalkInstalled
import 'package:flutter/services.dart'; // PlatformException

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Flutter with Kakao login"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _profile(),
              _nickName(),
              _loginButton(),
            ],
          ),
        ));
  }

  Widget _profile() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 100,
          height: 100,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child:
                Consumer<UserController>(builder: (context, controller, child) {
              // 사용자의 프로필 사진 가져오기
              final String? src = controller.user?.properties?["profile_image"];
              if (src != null) {
                return Image.network(src, fit: BoxFit.cover);
              } else {
                return Container(
                  color: Colors.black,
                );
              }
            }),
          ),
        ),
      );

  Widget _nickName() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<UserController>(builder: (context, controller, child) {
          // 사용자의 닉네임 가져오기
          final String? name = controller.user?.properties?["nickname"];
          if (name != null) {
            return Text(name);
          } else {
            return const Text("로그인이 필요합니다");
          }
        }),
      );

  Widget _loginButton() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
        // 카카오 로그인을 위한 메소드
            onTap: context.read<UserController>().kakaoLogin,
            child: Image.asset("assets/images/kakao_login_medium_narrow.png")),
      );
}

class KakaoLoginApi {
  signWithKakao() async {
    final UserApi api = UserApi.instance;
    if (await isKakaoTalkInstalled()) {
      try {
        api.loginWithKakaoTalk().then((_) {
          return api.me();
        });
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          await UserApi.instance.loginWithKakaoAccount();
          return api.me();
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }
    } else {
      try {
        await UserApi.instance.loginWithKakaoAccount();
        return api.me();
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  }
}


class UserController with ChangeNotifier {
  User? _user;
  KakaoLoginApi kakaoLoginApi;
  User? get user => _user;

  UserController({required this.kakaoLoginApi});
  
  
  // 카카오 로그인
  void kakaoLogin() async {
    kakaoLoginApi.signWithKakao().then((user) {
      // 반환된 값이 NULL이 아니라면
      // 정보 전달
      if (user != null) {
        _user = user;
        notifyListeners();
      }
    });
  }
}