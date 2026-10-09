import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Flutter Demo', home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double _mySize = 15;
  final Color _myColor1 = Colors.lightGreen, _myColor2 = Colors.purple;
  Color _myColor = Colors.blueGrey;
  bool _changed = false;
  String _myText = '变小';

  void changeText() {
    setState(() {
      _changed = !_changed;
      _mySize = _changed ? 22 : 15;
      _myColor = _changed ? _myColor2 : _myColor1;
      _myText = _changed ? '变小' : '变大';
    });
    debugPrint('debug: changed = $_changed');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('debug: $_myText');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.text_format, size: 50, color: Colors.lightGreen),
            Container(
              width: 220,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.yellowAccent,
                border: Border(
                  top: BorderSide(color: Colors.green, width: 5),
                  right: BorderSide(color: Colors.blueAccent, width: 5),
                  bottom: BorderSide(color: Colors.red, width: 5),
                  left: BorderSide(color: Colors.orange, width: 5),
                ),
              ),
              child: Text(
                '布院大数据 金朗原',
                style: TextStyle(
                  fontSize: _mySize,
                  fontWeight: FontWeight.w500,
                  color: _myColor,
                ),
              ),
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              style: const ButtonStyle(
                foregroundColor: WidgetStatePropertyAll(Colors.red),
                backgroundColor: WidgetStatePropertyAll(Colors.blue),
              ),
              onPressed: changeText,
              child: Text(_myText),
            ),
          ],
        ),
      ),
    );
  }
}
