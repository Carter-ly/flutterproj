import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter/services.dart'; // 添加 SystemChrome
import 'package:sensors_plus/sensors_plus.dart'; // 添加加速度计支持

// 页面数据类
class Page010103 {
  final String title;
  final String name;
  final IconData icon;
  final Widget content;

  Page010103({
    required this.title,
    required this.name,
    required this.icon,
    required this.content,
  });
}

// 自定义组件：带图标的文本按钮
class IconTextButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final void Function()? onPressed;
  final double iconSize;
  final Color iconColor;
  final TextStyle textStyle;

  const IconTextButton({
    super.key,
    required this.label,
    required this.icon,
    this.onPressed,
    this.iconSize = 24.0,
    this.iconColor = Colors.black,
    this.textStyle = const TextStyle(fontSize: 16.0),
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(label, style: textStyle),
            Icon(icon, size: iconSize, color: iconColor),
          ],
        ),
      ),
    );
  }
}

// 自定义组件：数值调节输入框
class SpinnerInput extends StatefulWidget {
  final double spinnerValue;
  final ValueChanged<double> onChange;
  final double minValue;
  final double maxValue;
  final TextStyle? middleNumberStyle;

  const SpinnerInput({
    super.key,
    required this.spinnerValue,
    required this.onChange,
    required this.minValue,
    required this.maxValue,
    this.middleNumberStyle,
  });

  @override
  State<SpinnerInput> createState() => _SpinnerInputState();
}

class _SpinnerInputState extends State<SpinnerInput> {
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.spinnerValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () {
            if (_currentValue > widget.minValue) {
              setState(() {
                _currentValue--;
                widget.onChange(_currentValue);
              });
            }
          },
        ),
        Text(
          '${_currentValue.toInt()}',
          style: widget.middleNumberStyle ??
              const TextStyle(
                color: Colors.black,
                backgroundColor: Colors.white,
                fontSize: 18,
              ),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            if (_currentValue < widget.maxValue) {
              setState(() {
                _currentValue++;
                widget.onChange(_currentValue);
              });
            }
          },
        ),
      ],
    );
  }
}

// 涂鸦路径类
class DrawingPath {
  final List<Offset> points;
  final double strokeWidth;
  final Color strokeColor;

  DrawingPath(this.points, this.strokeWidth, this.strokeColor);
}

// 涂鸦画板
class FreeDrawPainter extends CustomPainter {
  final List<DrawingPath> paths;

  FreeDrawPainter(this.paths);

  @override
  void paint(Canvas canvas, Size size) {
    for (var path in paths) {
      Paint paintStyle = Paint()
        ..strokeWidth = path.strokeWidth
        ..color = path.strokeColor
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      for (int i = 1; i < path.points.length; i++) {
        canvas.drawLine(path.points[i - 1], path.points[i], paintStyle);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// 自由绘画页面
class FreeDrawPage extends StatefulWidget {
  @override
  _FreeDrawPageState createState() => _FreeDrawPageState();
}

class _FreeDrawPageState extends State<FreeDrawPage> {
  List<DrawingPath> paths = [];
  Color _selectedColor = Colors.black;
  double _strokeWidth = 8.0;

  @override
  Widget build(BuildContext context) {
    var settingButtons = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            const Text('线宽：\n[1~50]'),
            SpinnerInput(
              spinnerValue: _strokeWidth,
              onChange: (newValue) {
                setState(() {
                  _strokeWidth = newValue;
                });
              },
              minValue: 1,
              maxValue: 50,
              middleNumberStyle: const TextStyle(
                color: Colors.deepPurple,
                backgroundColor: Colors.white,
                fontSize: 18,
              ),
            )
          ],
        ),
        IconTextButton(
          label: '颜色：',
          icon: Icons.palette,
          textStyle: const TextStyle(fontSize: 16),
          iconColor: Colors.deepPurple,
          iconSize: 32,
          onPressed: selectColor,
        ),
        IconTextButton(
          label: '清空：',
          icon: Icons.cleaning_services,
          iconColor: Colors.red,
          iconSize: 32,
          onPressed: () => setState(() {
            paths.clear();
          }),
        )
      ],
    );

    return Scaffold(
      body: Column(children: [
        Container(
          color: Colors.yellow[100],
          padding: const EdgeInsets.all(10),
          child: settingButtons,
        ),
        const Divider(height: 1),
        Expanded(
          child: GestureDetector(
            onPanDown: (details) {
              paths.add(DrawingPath(
                  [details.localPosition], _strokeWidth, _selectedColor));
              setState(() {});
            },
            onPanUpdate: (details) {
              paths.last.points.add(details.localPosition);
              setState(() {});
            },
            child: CustomPaint(
              size: Size.infinite,
              painter: FreeDrawPainter(paths),
            ),
          ),
        )
      ]),
    );
  }

  /// 选择画笔颜色
  void selectColor() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('选择画笔颜色'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _selectedColor,
              onColorChanged: (color) {
                setState(() {
                  _selectedColor = color;
                });
              },
            ),
          ),
          actions: [
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('确定'),
            ),
          ],
        );
      },
    );
  }
}

// 滚动球游戏画板
class BallPainter extends CustomPainter {
  final double posX;
  final double posY;
  final double radius;

  BallPainter(this.posX, this.posY, this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(posX, posY), radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// 滚动球游戏页面
class RollingBallGame extends StatefulWidget {
  const RollingBallGame({super.key});

  @override
  State<RollingBallGame> createState() => _RollingBallGameState();
}

class _RollingBallGameState extends State<RollingBallGame> {
  static const double _sideLength = 320;
  double _positionX = _sideLength / 2;
  double _positionY = _sideLength / 2;
  double _radius = 10;
  double _accelFactor = 5;
  late StreamSubscription<AccelerometerEvent> _listener;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    // 初始化时设置竖屏方向
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  void dispose() {
    _listener.cancel();
    // 恢复默认方向设置
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var radiusSpinner = Column(
      children: [
        const Text('圆球半径[6~16]:'),
        SpinnerInput(
          spinnerValue: _radius,
          onChange: (newValue) {
            setState(() {
              _radius = newValue;
            });
          },
          minValue: 6,
          maxValue: 16,
        ),
      ],
    );

    var factorSpinner = Column(
      children: [
        const Text('加速系数[1~16]:'),
        SpinnerInput(
          spinnerValue: _accelFactor,
          onChange: (newValue) {
            setState(() {
              _accelFactor = newValue;
            });
          },
          minValue: 1,
          maxValue: 16,
        ),
      ],
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              '触摸或拖动屏幕，球会跟随手指移动；启动加速度传感器后倾斜手机，球会向倾斜方向滚动。',
              style: TextStyle(color: Color(0xffff0000)),
            ),
            SizedBox(
              width: _sideLength,
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [radiusSpinner, factorSpinner],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 1),
              width: _sideLength,
              height: _sideLength*0.7,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.green, width: 2),
              ),
              child: GestureDetector(
                onPanDown: setPosition,
                onPanUpdate: setPosition,
                child: CustomPaint(
                  painter: BallPainter(_positionX, _positionY, _radius),
                ),
              ),
            ),
            FilledButton(
              onPressed: () {
                _isListening ? stopListener() : startListener();
                setState(() {
                  _isListening = !_isListening;
                });
              },
              child: _isListening
                  ? const Text('停止加速度传感器')
                  : const Text('启动加速度传感器'),
            ),
          ],
        ),
      ),
    );
  }

  void setPosition(detail) => setState(() {
        double limit = _sideLength - _radius;
        _positionX = detail.localPosition.dx.clamp(_radius, limit);
        _positionY = detail.localPosition.dy.clamp(_radius, limit);
      });

  void startListener() {
    _listener = accelerometerEvents.listen((event) {
      setState(() {
        double limit = _sideLength - _radius;
        // 修正方向：符合物理直觉（球向低处滚）
        _positionX = (_positionX + event.x * _accelFactor).clamp(_radius, limit);
        _positionY = (_positionY - event.y * _accelFactor).clamp(_radius, limit);
      });
    }, cancelOnError: true);
  }

  void stopListener() {
    _listener.cancel();
  }
}

// 页面列表
List<Page010103> myPages = [
  // 首页
  Page010103(
    title: '金朗原的个人展示',
    name: '首页',
    icon: Icons.home,
    content: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "大数据(中外)24-1班 金朗原",
            style: TextStyle(
              fontSize: 32,
              color: Colors.blue,
              fontWeight: FontWeight.w800,
            ),
          ),
          Image.asset(
            'image/photo.jpg',
            width: 150,
          ),
          Text(
            "我是金朗原\n我喜欢听音乐,看电影",
            style: TextStyle(
              fontSize: 35,
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              wordSpacing: 4.5,
            ),
          ),
          const Text(
            "NCUT",
            style: TextStyle(
              fontSize: 32,
              color: Color.fromARGB(230, 100, 142, 2),
              backgroundColor: Color.fromARGB(255, 59, 255, 235),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    ),
  ),

  // 第二页：涂鸦板
  Page010103(
    title: '自由涂鸦游戏\n--大数据(中外)24-1班金朗原',
    name: '画板',
    icon: Icons.palette,
    content: FreeDrawPage(),
  ),

  // 第三页：滚动球游戏
  Page010103(
    title: '滚动球游戏\n--大数据(中外)24-1班金朗原',
    name: '滚动球',
    icon: Icons.brightness_1,
    content: const RollingBallGame(),
  ),
];

// 主应用
void main() {
  // 确保 Flutter 绑定初始化
  WidgetsFlutterBinding.ensureInitialized();
  
  // 设置竖屏方向
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NCUT Flutter 课程',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(myPages[_currentIndex].name),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        titleTextStyle: const TextStyle(fontSize: 20),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          children: [
            Text(
              myPages[_currentIndex].title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                color: Colors.red.shade600,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(child: myPages[_currentIndex].content),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red.shade600,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: myPages
            .map((e) => BottomNavigationBarItem(
                  icon: Icon(e.icon),
                  label: e.name,
                ))
            .toList(),
      ),
    );
  }
}