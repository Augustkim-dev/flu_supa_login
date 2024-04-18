import 'dart:io';

import 'package:flu_supa_login/src/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwdTextController = TextEditingController();

  final supabase = Supabase.instance.client;
  bool isLogin = false;
  bool _auth = false;

  @override
  void initState() {
    checkLoginState();

    super.initState();
  }

  void checkLoginState() {
    supabase.auth.onAuthStateChange.listen((data) {
      // final event = data.event;
      // if (event == AuthChangeEvent.signedIn) {
      //   Navigator.of(context).pushNamed('/main');
      // }
      if (_auth) return;
      final session = data.session;
      if (session != null) {
        _auth = true;
        print('session id is alive : email : ${data.session!.user.email}');
        Navigator.of(context).popAndPushNamed('/main');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('로그인')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            junTextFormField(
              text: '이메일',
              editingController: _emailTextController,
            ),
            SizedBox(height: 4),
            junTextFormField(
              text: '비밀번호',
              editingController: _passwdTextController,
            ),
            SizedBox(height: 4),
            SizedBox(height: 16),
            Container(
              width: double.infinity,
              height: 69,
              child: JunElevatedButton(
                title: '로그인',
                onPressed: () async {
                  await loginWithEmail(_emailTextController.text.trim(),
                      _passwdTextController.text.trim());

                  if (isLogin) {
                    Navigator.of(context).popAndPushNamed('/main');
                  }
                },
              ),
            ),
            SizedBox(height: 8),
            Container(
                width: double.infinity,
                height: 69,
                child: JunElevatedButton(
                    title: 'Kakao 로그인',
                    svgPath: 'assets/kakao_logo.svg',
                    widthImg: 15,
                    heightImg: 15,
                    fontColor: Colors.black,
                    backgroundColor: Colors.yellow,
                    onPressed: () {})),
            SizedBox(height: 8),
            Container(
                width: double.infinity,
                height: 69,
                child: JunElevatedButton(
                    title: 'Google 로그인',
                    svgPath: 'assets/google_logo.svg',
                    widthImg: 30,
                    heightImg: 30,
                    fontColor: Colors.black,
                    backgroundColor: Colors.white,
                    onPressed: () async {
                      try {
                        await supabase.auth
                            .signInWithOAuth(OAuthProvider.google);
                      } catch (error) {
                        print('$error');
                      }
                    })),
            SizedBox(height: 8),
            Container(
                width: double.infinity,
                height: 69,
                child: JunElevatedButton(
                    title: 'Apple 로그인',
                    svgPath: 'assets/apple_logo.svg',
                    widthImg: 30,
                    heightImg: 30,
                    fontColor: Colors.white,
                    backgroundColor: Colors.black,
                    onPressed: () {})),
          ],
        ),
      ),
    );
  }

  Future loginWithEmail(String emailText, String passwdText) async {
    late AuthResponse response = AuthResponse();
    try {
      response = await supabase.auth
          .signInWithPassword(email: emailText, password: passwdText);
    } on AuthApiException catch (error) {
      if (error.statusCode == '400') {
        showSnackBar(context, '${error.message} - 아이디 / 비밀번호 확인필요');
      }
    } catch (error) {
      showSnackBar(context, '기타 로그인 오류');
    }

    final User? user = response.user;

    if (user?.id != null) {
      setState(() {
        isLogin = true;
      });
    }
  }
}
