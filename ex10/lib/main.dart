import 'package:flutter/material.dart';

/// 定义文本样式选项类
class TextStyleOptions {
  final String _label; // 样式名称
  final TextStyle _textStyle; // 文本样式
  TextStyleOptions(this._label, this._textStyle); // 构造函数
}

List<TextStyleOptions> textStyleOptions = [
  // 定义可用的文本样式选项列表
  TextStyleOptions("常规 Normal", const TextStyle()),
  TextStyleOptions("加粗 Bold", const TextStyle(fontWeight: FontWeight.bold)),
  TextStyleOptions("倾斜 Italic", const TextStyle(fontStyle: FontStyle.italic)),
  TextStyleOptions(
    "加粗倾斜 Bold Italic",
    const TextStyle(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
  ),
];

/// 定义文本样式控制器类
class TextStyleController {
  bool _isBold = false; // 是否粗体
  bool _isItalic = false; // 是否斜体
  bool _hasUnderline = false; // 是否下划线
  /// 切换粗体状态
  void toggleBold(bool? value) {
    _isBold = value ?? false;
  }

  /// 切换斜体状态
  void toggleItalic(bool? value) {
    _isItalic = value ?? false;
  }

  /// 切换下划线状态
  void toggleUnderline(bool? value) {
    _hasUnderline = value ?? false;
  }

  /// 获取当前是否粗体的状态
  bool get isBold => _isBold;

  /// 获取当前是否斜体的状态
  bool get isItalic => _isItalic;

  /// 获取当前是否有下划线的状态
  bool get hasUnderline => _hasUnderline;
}

void main() {
  // 运行应用程序
  runApp(const MyApp());
}

/// 应用程序类
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // 创建 MaterialApp 作为应用的根组件
    return MaterialApp(
      title: 'NCUT Flutter 课程',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

/// 主页面的有状态组件类
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  MyHomePageState createState() => MyHomePageState();
}

/// 主页面的有状态组件状态类
class MyHomePageState extends State<MyHomePage> {
  TextStyleOptions _selectedTextStyleOption =
      textStyleOptions.first; // 当前选中的文本样式选项
  final TextStyleController _styleController =
      TextStyleController(); // 文本样式控制器实例
  @override
  Widget build(BuildContext context) {
    // 构建页面的 UI
    return Scaffold(
      appBar: AppBar(
        title: const Text('改变字体样式--大数据(中外)24-1班金朗原'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        titleTextStyle: const TextStyle(fontSize: 20),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("文本样式预览："),
            // 显示当前文本样式的效果
            showPrevText(),
            const SizedBox(height: 20),
            Text(
              "文本样式单选项:",
              style: TextStyle(
                color: Colors.red,
                backgroundColor: Colors.yellow[200],
              ),
            ),
            // 列表形式展示可选择的文本样式
            showStyleRadio(context),
            const SizedBox(height: 16),
            Text(
              "文本样式多选项:",
              style: TextStyle(
                color: Colors.red,
                backgroundColor: Colors.yellow[200],
              ),
            ),
            // 通过复选框列表项提供粗体、斜体、下划线的开关控制
            showStyleCheck(const Text("加粗 Bold"), _styleController.isBold, (v) {
              _styleController.toggleBold(v);
              setState(() {});
            }),
            showStyleCheck(const Text("倾斜 Italic"), _styleController.isItalic, (
              v,
            ) {
              _styleController.toggleItalic(v);
              setState(() {});
            }),
            showStyleCheck(
              const Text("下划线 Underline"),
              _styleController.hasUnderline,
              (v) {
                _styleController.toggleUnderline(v);
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }

  Container showStyleCheck(
    Text label,
    bool value,
    void Function(bool?)? onChanged,
  ) {
    return Container(
      width: 260,
      height: 30,
      padding: const EdgeInsets.only(left: 20),
      child: CheckboxListTile(title: label, value: value, onChanged: onChanged),
    );
  }

  Column showStyleRadio(BuildContext context) {
    return Column(
      children:
          textStyleOptions
              .map(
                (option) => ListTile(
                  title: Text(option._label),
                  leading: Radio(
                    value: option,
                    groupValue: _selectedTextStyleOption,
                    onChanged:
                        (option) => setState(() {
                          // 更新当前选中的文本样式选项
                          _selectedTextStyleOption = option!;
                        }),
                  ),
                  minTileHeight: 10,
                  minVerticalPadding: 1,
                ),
              )
              .toList(),
    );
  }

  Text showPrevText() {
    return Text(
      "文本样式叠加效果",
      style: _selectedTextStyleOption._textStyle.copyWith(
        fontSize: 26,
        color: Colors.green.shade700,
        fontWeight:
            _styleController.isBold
                ? FontWeight.bold
                : _selectedTextStyleOption._textStyle.fontWeight,
        fontStyle:
            _styleController.isItalic
                ? FontStyle.italic
                : _selectedTextStyleOption._textStyle.fontStyle,
        decoration:
            _styleController.hasUnderline
                ? TextDecoration.underline
                : TextDecoration.none,
      ),
    );
  }
}
