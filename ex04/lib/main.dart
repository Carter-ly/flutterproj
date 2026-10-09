import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/rendering.dart';

AudioPlayer audioPlayer = AudioPlayer(); void main() {
  debugPaintSizeEnabled = true; 
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var myStack = Stack(
      clipBehavior: Clip.none,
      children: [
        Image.asset('assets/picture.jpg', width: 300, height: 300,),
        Positioned(
          bottom: -20,
          right: -25,
          child: GestureDetector(
            onTap: () async {
              try {
                await audioPlayer.play(AssetSource('sound.wav'));
              } on AudioPlayerException catch (e) {
                debugPrint("AudioPlayer 播放失败：$e");
              }
            },
            child: Image.asset('assets/playBtn.png'),
          ),
        ),
        const Positioned(
          bottom: -50,
          right: -50,
          child: Text(
            '点击按钮播放音效',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
    return MaterialApp(
      title: 'NCUT Flutter 课程',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('图片和音频'),
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          titleTextStyle: const TextStyle(fontSize: 20),
        ),
        body: Center(
          child: myStack, 
        ),
      ),
    );
  }
}
