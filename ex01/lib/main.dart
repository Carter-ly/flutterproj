import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar:AppBar(
          title:Text("我的个人介绍"),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(fontSize:30),
        ),
        body:Center(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("大数据(中外)24-1班 金朗原",
              style:TextStyle(
                fontSize:33,
                color:Colors.blue,
                fontWeight:FontWeight.w800
              ),),
              Image.network(
                "https://pics0.baidu.com/feed/5fdf8db1cb1349547f62e810eb84aa55d0094a99.jpeg?token=62674bdead42b9eae3baaa45b05312b8",
                width: 150,
                ),
              Text("我是金朗原\n我喜欢听音乐,看电影",
              style: TextStyle(
                fontSize: 35,
                color:Colors.black,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                wordSpacing: 4.5),
              ),
              const Text(
                "NCUT",
                style: TextStyle(
                  fontSize: 32,
                  color: Color.fromARGB(230, 100, 142, 2),
                  backgroundColor: Color.fromARGB(255, 59, 255, 235),
                  fontStyle: FontStyle.italic,
                ),
              )
            ],    
          ),
        )
      ));}}