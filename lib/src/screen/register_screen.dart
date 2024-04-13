import 'package:flu_supa_login/src/model/user_model.dart';
import 'package:flu_supa_login/src/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _emailEditingController = TextEditingController();
  TextEditingController _nameEditingController = TextEditingController();
  TextEditingController _passwdEditingController = TextEditingController();
  TextEditingController _passwdConfirmEditingController =
      TextEditingController();
  TextEditingController _introEditingController = TextEditingController();

  final supabase = Supabase.instance.client;
  bool isSignup = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('회원가입')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              junTextFormField(
                  text: '이메일', editingController: _emailEditingController),
              SizedBox(height: 4),
              junTextFormField(
                  text: '이름', editingController: _nameEditingController),
              SizedBox(height: 4),
              junTextFormField(
                  text: '비밀번호', editingController: _passwdEditingController),
              SizedBox(height: 4),
              junTextFormField(
                  text: '비밀번호 확인',
                  editingController: _passwdConfirmEditingController),
              SizedBox(height: 4),
              junTextFormField(
                  text: '인사말',
                  maxLine: 6,
                  editingController: _introEditingController),
              SizedBox(height: 4),
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 69,
                child: JunElevatedButton(
                  title: '회원가입',
                  onPressed: () async {
                    await SignUpWithEmail(
                      _emailEditingController.text.trim(),
                      _passwdEditingController.text.trim(),
                      _nameEditingController.text.trim(),
                      _introEditingController.text.trim(),
                    );
                    if (isSignup) {
                      Navigator.of(context).pushNamed('/main');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future SignUpWithEmail(String emailText, String passwdText, String nameText,
      String introText) async {
    late AuthResponse response;
    // 1. 인증 거치기
    try {
      response =
          await supabase.auth.signUp(email: emailText, password: passwdText);
    } on AuthApiException catch (error) {
      if (error.statusCode == '422') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            // content: Text(error.message),
            content: Text('이미 가입된 이메일이 존재합니다'),
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        print('가입 에러발생 $error');
        SnackBar(content: Text('가입에러 발생 : ${error.message}'));
      }
      return;
    } catch (error) {
      print('기타 에러 발생 $error');
      return;
    }

    final Session? session = response.session;
    final User? user = response.user;

    if (user?.id != null) {
      setState(() {
        isSignup = true;
      });

      // 2. User 테이블에 유저정보 추가
      await supabase.from('user').insert({
        'profile_url': null,
        'name': nameText,
        'email': emailText,
        'introduce': introText,
        'uid': response.user!.id,
      });
    } else {
      print('회원가입 에러 : ${response}');
    }
  }
}
