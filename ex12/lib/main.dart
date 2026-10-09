import 'package:flutter/material.dart';

/// 应用程序的主入口点。
void main() {
  runApp(const MyApp());
}

/// 应用程序的主界面。
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NCUT Flutter 课程',
      theme: ThemeData(
        sliderTheme: const SliderThemeData(
          trackHeight: 8,
          showValueIndicator: ShowValueIndicator.always,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

/// 主页面的状态类，用于管理颜色变化。
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/// 管理主页面状态的类。
class _MyHomePageState extends State<MyHomePage> {
  // 用于存储 RGB 颜色分量的值。
  final List<double> _sliderValues = [255, 0, 0];
  // 用于存储颜色名称。
  final List<String> _colorNames = ['红色', '绿色', '蓝色'];
  // 用于存储对应 RGB 颜色的 Color 对象。
  final List<Color> _colors = [Colors.red, Colors.green, Colors.blue];
  double _opacity = 0.5; // 用于存储颜色的不透明度
  Color _currentColor = const Color(0x7fff0000); // 用于存储当前综合颜色。
  /// 更新综合颜色值，并刷新界面。
  void _updateColor() {
    try {
      // 确保 RGB 值在 0-255 之间
      final List<int> colorValues =
          _sliderValues.map((value) => value.clamp(0, 255).toInt()).toList();
      _currentColor = Color.fromRGBO(
        colorValues[0],
        colorValues[1],
        colorValues[2],
        _opacity,
      );
      setState(() {});
    } catch (e) {
      debugPrint('更新颜色失败：$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('颜色混合器--大数据(中外)24-1班金朗原'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        titleTextStyle: const TextStyle(fontSize: 20),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("请调节下方滑块改变颜色和透明度："),
            Container(
              width: 300,
              height: 200,
              color: _currentColor,
              alignment: Alignment.center,
              child: Text(
                // 社会主义核心价值观 24 字
                "富强、民主、文明、和谐，\n 自由、平等、公正、法治，\n 爱国、敬业、诚信、友善。",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255,(255-_currentColor.r).toInt(),
                  (255*(1-_currentColor.g)).toInt(),(255-_currentColor.b).toInt(),)
                ),
              ),
            ),
            const SizedBox(height: 30),
            ...showColorSliders(),
            showOpacitySlider(),
          ],
        ),
      ),
    );
  }

  /// 创建并返回一个滑块控件，用于调整颜色的 opacity 值。
  Slider showOpacitySlider() {
    return Slider(
      min: 0,
      max: 1,
      value: _opacity,
      label: '不透明度: ${_opacity.toStringAsFixed(2)}',
      activeColor: Colors.black54,
      inactiveColor: Colors.black26,
      onChanged: (newValue) {
        // 直接在回调中限制值的范围并更新
        _opacity = newValue.clamp(0, 1);
        _updateColor(); // 更新颜色并触发界面刷新
      },
    );
  }

  /// 创建并返回一个滑块组件列表，用于调整颜色分量的值。
  List<Slider> showColorSliders() {
    List<Slider> sliders = [];
    for (int i = 0; i < 3; i++) {
      sliders.add(
        Slider(
          min: 0,
          max: 255,
          value: _sliderValues[i],
          label: '${_colorNames[i]}: ${_sliderValues[i].toStringAsFixed(2)}',
          activeColor: _colors[i],
          inactiveColor: Colors.grey,
          onChanged: (newValue) {
            // 直接在回调中限制值的范围并更新
            _sliderValues[i] = newValue.clamp(0, 255);
            _updateColor(); // 更新颜色并触发界面刷新
          },
        ),
      );
    }
    return sliders;
  }
}
