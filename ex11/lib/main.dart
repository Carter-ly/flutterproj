import 'dart:async';
import 'package:flutter/material.dart';

/// 应用程序的主入口点。
void main() {
  runApp(const MyApp());
}

/// 应用程序的主要界面。
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'NCUT Flutter 课程', home: MyHomePage());
  }
}

/// 主页面的状态类，管理倒计时逻辑。
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/// 主页面的状态类实现。
class _MyHomePageState extends State<MyHomePage> {
  /// 倒计时是否显示的标志。
  bool _showCountdown = false;

  /// 倒计时的总时间。
  int _totalTime = 10;

  /// 剩余的倒计时时间。
  int _remainingTime = 10;

  /// 用于时间显示的 Timer 对象。
  late Timer _timerNow, _timerCountDown;

  /// 显示当前时间的字符串。
  String _timeString = '';

  /// 文本输入控制器，用于输入倒计时时间。
  final TextEditingController _textEditingController = TextEditingController();

  /// 初始化状态，设置初始的 Timer。
  @override
  void initState() {
    super.initState();
    _timerCountDown = Timer(const Duration(), () {});
    _timerNow = Timer.periodic(const Duration(seconds: 1), (timer) {
      DateTime dt = DateTime.now();
      setState(() {
        _timeString =
            '${dt.year}-${dt.month}-${dt.day} ${dt.hour}:${dt.minute}:${dt.second}';
      });
    });
  }

  /// 释放资源，取消 Timer。
  @override
  void dispose() {
    _timerNow.cancel();
    _timerCountDown.cancel();
    _textEditingController.dispose();
    super.dispose();
  }

  /// 构建界面。
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('计时器--大数据(中外)24-1班金朗原'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        titleTextStyle: const TextStyle(fontSize: 20),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 20),
              alignment: Alignment.center,
              color: Colors.yellow,
              child: Text(_timeString),
            ),
            const SizedBox(height: 50),
            _showCountdown
                ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '倒计时: $_remainingTime 秒',
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FilledButton(
                          onPressed: stopCountdown,
                          child: const Text('停止倒计时'),
                        ),
                        const SizedBox(width: 20),
                        FilledButton(
                          onPressed: resetCountdown,
                          child: const Text('重新倒计时'),
                        ),
                      ],
                    ),
                  ],
                )
                : const SizedBox(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          String inputText = await inputDialog(context);
          int? parsedTime;
          // 对输入进行验证
          if (inputText.isNotEmpty &&
              (parsedTime = int.tryParse(inputText)) != null &&
              parsedTime! > 0) {
            setState(() {
              _totalTime = parsedTime!;
              _remainingTime = _totalTime;
              _showCountdown = true;
            });
            _timerCountDown.cancel();
            if (context.mounted) {
              showDialog(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: const Text('完成设置'),
                      content: Text('已设置倒计时时长为$parsedTime 秒,2 秒钟后即开始倒计时...'),
                    ),
              );
            }
            // 使用 Future.delayed 实现延迟执行，在 2 秒后调用_startCountdown函数
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.pop(context);
              startCountdown();
            });
          } else {
            if (context.mounted) {
              showDialog(
                context: context,
                builder:
                    (context) => AlertDialog(
                      title: const Text('设置失败'),
                      content: const Text('设置倒计时时长失败，请检查输入是否为正整数！'),
                      actions: [
                        OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('确定'),
                        ),
                      ],
                    ),
              );
            }
          }
        },
        label: const Text("设置倒计时时长（秒）"),
        icon: const Icon(Icons.timer_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }

  /// 显示输入对话框，用于输入倒计时时间。
  Future<String> inputDialog(BuildContext context) async {
    _textEditingController.text = '';
    return await showDialog(
      context: context,
      builder:
          (BuildContext context) => AlertDialog(
            title: const Text('请输入一个正整数：'),
            content: TextField(
              controller: _textEditingController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: '输入倒计时时长（秒）'),
              autofocus: true,
            ),
            actions: [
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context, _textEditingController.text);
                },
                child: const Text('确定'),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('取消'),
              ),
            ],
          ),
    );
  }

  /// 开始倒计时。
  void startCountdown() {
    _timerCountDown = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingTime <= 0) {
        _timerCountDown.cancel();
        return;
      }
      setState(() {
        _remainingTime--;
      });
    });
  }

  /// 停止倒计时。
  void stopCountdown() {
    if (_timerCountDown.isActive) {
      _timerCountDown.cancel();
    }
  }

  /// 重置倒计时。
  void resetCountdown() {
    if (_timerCountDown.isActive) {
      _timerCountDown.cancel();
    }
    setState(() {
      _remainingTime = _totalTime;
    });
    startCountdown();
  }
}
