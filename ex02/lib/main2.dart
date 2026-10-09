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
          title: const Text('我的图标展示页面'),
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          titleTextStyle: const TextStyle(fontSize: 25),
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
        SizedBox(height: 110),
        Icon(Icons.star, size: 30, color: Colors.orange),
        Center(
          child: Stack(
            children: [
              Icon(Icons.house_outlined, size: 150, color: Colors.black),
              Icon(Icons.house, size: 150, color: Colors.green),
            ],
          ),
        ),
        IconTheme(
          data: IconThemeData(color: Colors.red, size: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  '金朗原 伦敦布鲁内尔学院',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 30,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: 90),
                    Icon(Icons.favorite, size: 60, color: Colors.red),
                    Icon(Icons.search, size: 60, color: Colors.yellow),
                    Icon(Icons.add, size: 60, color: Colors.black),
                    Icon(Icons.settings, size: 60, color: Colors.blue),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
