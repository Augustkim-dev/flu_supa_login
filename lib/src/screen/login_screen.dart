import 'dart:io';

import 'package:flu_supa_login/src/widget/index.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwdTextController = TextEditingController();

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
                onPressed: () {
                  // Navigator.of(context).pushNamed('/login');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
