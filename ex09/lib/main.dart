import 'package:flutter/material.dart';

void main() {
  // 运行应用程序
  runApp(const MyApp());
}

/// 应用程序主入口页面
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// 构建应用程序的根 widget
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'NCUT Flutter 课程', // 应用标题
      home: MyHomePage(), // 主页面
    );
  }
}

/// 主页面，展示温度转换功能
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/// 主页面的状态管理类
class _MyHomePageState extends State<MyHomePage> {
  double _srcValue = 0, _resValue = 32; // 待转换温度值和转换后的温度值
  String _srcName = '°C', _resName = '°F'; // 待转换温度单位和转换后温度单位
  String _selectedString = '摄氏温度转为华氏温度'; // 当前选择的转换类型

  /// 处理温度转换逻辑
  void convertTemp(double value) {
    _srcValue = value;
    if (_selectedString == '摄氏温度转为华氏温度') {
      _srcName = '°C';
      _resName = '°F';
      _resValue = _srcValue * 9 / 5 + 32;
    } else {
      _srcName = '°F';
      _resName = '°C';
      _resValue = (_srcValue - 32) * 5 / 9;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // 创建文本输入组件，用于输入待转换的温度值
    var myTextField = TextField(
      keyboardType: TextInputType.number,
      onChanged: (value) {
        if (value.isEmpty) {
          value = '0';
        }
        convertTemp(double.parse(value));
      },
      style: const TextStyle(fontSize: 24),
      decoration: InputDecoration(
        labelText: '请输入待转换的${_selectedString.substring(0, 4)}值',
        floatingLabelStyle: const TextStyle(color: Colors.red, fontSize: 20),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
      ),
    );
    // 创建下拉菜单按钮组件，用于选择温度转换类型
    var myDropdownButton = DropdownButton<String>(
      value: _selectedString,
      onChanged: (newValue) {
        setState(() {
          _selectedString = newValue!;
          convertTemp(_srcValue);
        });
      },
      items:
          <String>['摄氏温度转为华氏温度', '华氏温度转为摄氏温度'].map<DropdownMenuItem<String>>((
            String value,
          ) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
      style: const TextStyle(
        fontSize: 20,
        color: Colors.green,
        backgroundColor: Colors.yellow,
      ),
    );
    // 构建页面布局
    return Scaffold(
      appBar: AppBar(
        title: const Text('温度转换--大数据 (中外) 24-1班金朗原'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        titleTextStyle: const TextStyle(fontSize: 20),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            myTextField,
            const SizedBox(height: 30),
            myDropdownButton,
            const SizedBox(height: 30),
            // 显示转换结果
            Text(
              '$_srcValue$_srcName = ${_resValue.toStringAsFixed(2)}$_resName',
              style: const TextStyle(fontSize: 24, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
