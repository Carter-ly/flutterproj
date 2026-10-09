import 'dart:math';
import 'package:flutter/material.dart';

/// 应用程序的入口点。
void main() {
  runApp(const MyApp());
}

/// 应用程序的根组件。
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// 构建方法，返回整个应用的 widget 树。
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'NCUT Flutter 课程', home: MyHomePage());
  }
}

/// 代表主页面的有状态 widget。
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  /// 创建此页面状态的实例。
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/// `_MyHomePageState` 是 `MyHomePage` 的状态类，管理页面的内部状态和构建逻辑。
class _MyHomePageState extends State<MyHomePage> {
  num _xValue = 0; // 用户输入的自变量 x 的值。
  num _result = 0; // 计算得到的因变量 y 的值。
  /// 根据输入的自变量 x 计算对应的因变量 y 的值。
  void calculateResult() {
    if (_xValue < -5) {
      _result = pow(_xValue, 3); // x < -5
    } else if (_xValue < 0) {
      _result = _xValue * 2; // -5 <= x < 0
    } else if (_xValue <= 5) {
      _result = cos(_xValue); // 0 <= x <= 5
    } else {
      _result = sqrt(_xValue); // x > 5
    }
    setState(() {});
  }

  /// 构建方法，返回页面的 widget 树。
  @override
  Widget build(BuildContext context) {
    double? myFontSize = 20;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('分段函数计算--大数据(中外)24-1班金朗原'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        titleTextStyle: const TextStyle(fontSize: 20),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: <Widget>[
            Image.asset(
              'image/function.png',
              width: 220,
              height: 150,
              fit: BoxFit.contain,
            ),
            TextField(
              // 文本输入框，用于接收用户输入的自变量 x。
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: '输入自变量 x 的值'),
              style: TextStyle(fontSize: myFontSize),
              onChanged: (value) {
                // 当用户输入变化时更新 _xValue。
                _xValue = double.tryParse(value) ?? 0;
              },
            ),
            const SizedBox(height: 30),
            FilledButton(
              // 提供计算功能的按钮。
              onPressed: calculateResult,
              child: Text(
                '计算分段函数',
                style: TextStyle(fontSize: myFontSize, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            // 显示计算结果。
            Text(
              'f($_xValue) = ${_result.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: myFontSize,
                color: Colors.blue.withGreen(0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
