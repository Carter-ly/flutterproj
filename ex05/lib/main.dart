import 'package:flutter/material.dart';

// 主函数，应用的入口点
void main() {
  runApp(const MyApp());
}

/// MyApp 类继承自 StatelessWidget，是 Flutter 应用的主组件
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // 构建方法，返回应用的 MaterialApp 实例
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'NCUT Flutter 课程', home: MyHomePage());
  }
}

/// MyHomePage 类继承自 StatefulWidget，是应用的主页面
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // 初始化 TextField 的控制器
  late TextEditingController _textEditingController;
  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  // 构建方法，返回页面的布局
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('文字输入及对话框'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        titleTextStyle: const TextStyle(fontSize: 20),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(labelText: '大数据 (中外) 24-1班金朗原'),
            ),
            const SizedBox(height: 16.0),
            MyButton(textEditingController: _textEditingController),
          ],
        ),
      ),
    );
  }
}

/// MyButton 类继承自 StatelessWidget，用于创建一个带有点按事件的按钮
class MyButton extends StatelessWidget {
  const MyButton({super.key, required this.textEditingController});
  // 保存 TextField 的控制器
  final TextEditingController textEditingController;
  // 构建方法，返回按钮的视图
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {
        // 弹出对话框，显示 TextField 中输入的文字
        String text = textEditingController.text;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('提示'),
              content: Text('您输入的文字是：$text'),
              actions: [
                TextButton(
                  onPressed: () {
                    // 关闭对话框
                    Navigator.pop(context);
                  },
                  child: const Text('确定'),
                ),
              ],
            );
          },
        );
      },
      child: const Text('显示已输入的文字'),
    );
  }
}
