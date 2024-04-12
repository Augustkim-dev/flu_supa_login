import 'package:flu_supa_login/src/widget/index.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _emailEditingController = TextEditingController();
  TextEditingController _nameEditingController = TextEditingController();
  TextEditingController _passwdEditingController = TextEditingController();
  TextEditingController _passwdConfirmEditingController = TextEditingController();
  TextEditingController _introEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('회원가입')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              junTextFormField(text: '이메일'),
              SizedBox(height: 4),
              junTextFormField(text: '이름'),
              SizedBox(height: 4),
              junTextFormField(text: '비밀번호'),
              SizedBox(height: 4),
              junTextFormField(text: '비밀번호 확인'),
              SizedBox(height: 4),
              junTextFormField(text: '인사말', maxLine: 6),
              SizedBox(height: 4),
              SizedBox(height: 16),
              Container(width: double.infinity, height: 69, child: JunElevatedButton(title: '회원가입', onPressed: () {})),
            ],
          ),
        ),
      ),
    );
  }
}
