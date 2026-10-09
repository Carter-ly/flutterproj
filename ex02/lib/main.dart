import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('图标展示页面'),
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          titleTextStyle: const TextStyle(fontSize: 20),
        ),
        body: const HomePageBody(),
      ),
    );
  }
}

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 60),
        Icon(Icons.star, size: 30, color: Colors.orange),
        Icon(Icons.house_outlined, size: 150),
        IconTheme(
          data: IconThemeData(color: Colors.red, size: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.favorite),
              SizedBox(width: 30),
              Icon(
                Icons.food_bank,
                color: Color.fromRGBO(70, 180, 40, 3),
                size: 60,
              ),
              SizedBox(width: 30),
              Icon(Icons.favorite),
            ],
          ),
        ),
      ],
    );
  }
}
