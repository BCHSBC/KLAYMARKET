import 'package:flutter/material.dart';
import 'dart:js';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff010101),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        title: Text("BCHS MarketPlace",style: TextStyle(fontFamily: 'ONE',fontSize: 30)),
        centerTitle: true,
      ),
    );
  }
}