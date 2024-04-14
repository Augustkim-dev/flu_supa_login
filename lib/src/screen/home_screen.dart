// import 'package:flu_supa_login/src/widget/common_widget.dart';
import 'package:flu_supa_login/src/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final supabase = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 69,
              child: JunElevatedButton(
                title: '로그인',
                onPressed: () {
                  Navigator.of(context).pushNamed('/login');
                },
              ),
            ),
            SizedBox(height: 16),
            Container(
              height: 69,
              child: JunElevatedButton(
                title: '회원가입',
                onPressed: () {
                  Navigator.of(context).pushNamed('/register');
                },
                fontColor: Colors.black,
                backgroundColor: Colors.white,
              ),
            ),
            SizedBox(height: 16),
            Container(
              height: 69,
              child: JunElevatedButton(
                title: '로그아웃',
                onPressed: () async {
                  await supabase.auth.signOut();
                },
                fontColor: Colors.black,
                backgroundColor: Colors.white,
              ),
            ),
            SizedBox(height: 150),
          ],
        ),
      ),
    );
  }
}
