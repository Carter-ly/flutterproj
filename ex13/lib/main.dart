import 'dart:ui';
import 'package:flutter/material.dart';

// 主函数，应用的入口点
void main() {
  runApp(const MyApp());
}

// 应用程序的主要组件类，负责初始化和构建整个应用程序
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // 返回MaterialApp实例，配置应用程序的基本属性，如标题和主页
    return const MaterialApp(
      title: 'NCUT Flutter课程',
      home: MyHomePage(),
    );
  }
}

// 主页类，是无状态的widget类
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 构建页面的布局，包括appBar和body两部分
    return Scaffold(
      appBar: AppBar(
        title: const Text('基础画图--大数据(中外)24-1班金朗原'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        titleTextStyle: const TextStyle(fontSize: 20),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: CustomPaint(
          // 使用自定义的画家类MyPainter来绘制页面
          painter: MyPainter(),
        ),
      ),
    );
  }
}

// 自定义的画家类，继承自CustomPainter，实现画布的绘制逻辑
class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2, centerY = size.height / 2;
    Paint paintStyle = Paint();

    // 绘制画布边框
    canvas.drawRect(
        Rect.fromLTWH(0, 0, size.width, size.height),
        paintStyle
          ..color = Colors.yellow
          ..style = PaintingStyle.stroke
          ..strokeWidth = 20);

    // 设置画笔样式并绘制点
    paintStyle.color = Colors.purple;
    paintStyle.strokeWidth = 30;
    canvas.drawPoints(
        PointMode.points,
        [
          Offset(centerX - 100, centerY),
          Offset(centerX, centerY - 100),
          Offset(centerX + 100, centerY),
        ],
        paintStyle);
    canvas.drawPoints(
        PointMode.points,
        [Offset(centerX, centerY)],
        paintStyle
          ..strokeCap = StrokeCap.round
          ..color = Colors.red);

    // 绘制线
    paintStyle.color = Colors.blue;
    paintStyle.strokeWidth = 8;
    canvas.drawLine(const Offset(50, 150), const Offset(350, 150), paintStyle);

    // 绘制圆
    paintStyle.color = Colors.orange;
    paintStyle.style = PaintingStyle.stroke;
    paintStyle.strokeWidth = 4;
    canvas.drawCircle(Offset(centerX, centerY), 50, paintStyle);

    // 绘制矩形
    paintStyle.color = Colors.green;
    paintStyle.style = PaintingStyle.fill;
    canvas.drawRect(
        Rect.fromLTWH(centerX - 40, centerY + 110, 80, 80), paintStyle);

    paintStyle.color = Colors.orange;
    paintStyle.style = PaintingStyle.stroke;
    paintStyle.strokeWidth = 4;
    canvas.drawRect(
        Rect.fromCenter(
            center: Offset(centerX, centerY + 50), width: 270, height: 360),
        paintStyle);
      paintStyle.color = Colors.blue;
    paintStyle.style = PaintingStyle.stroke;
    paintStyle.strokeWidth = 4;
    canvas.drawRect(
        Rect.fromCenter(
            center: Offset(centerX, centerY + 150), width: 250, height: 120),
        paintStyle);

    // 绘制文本
    const textSpan = TextSpan(
      text: 'Hello flutter',
      style: TextStyle(color: Colors.orange, fontSize: 28),
    );
    final textPainter =
        TextPainter(text: textSpan, textDirection: TextDirection.ltr);
    textPainter.layout(minWidth: 0, maxWidth: 150);
    textPainter.paint(canvas, Offset(centerX - 70, centerY - 230));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
// 控制是否重新绘制，这里始终返回false，意味着不重新绘制
    return false;
  }
}
