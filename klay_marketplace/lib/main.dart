import 'package:flutter/material.dart';
import 'package:klaymarket/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

/* 
Stateless는 상태가 변해도 화면이 변하지 않는 위젯

Key는 
1. 위젯의 상태를 보존(체크박스의 상태, 텍스트 필드의 문자들이 입력되는지)
2. 위젯의 요소들을 유니크하게 식별


*/


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NFTs',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}
