import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

/// 应用程序的主入口点。
void main() {
  runApp(const MyApp());
}

/// 应用程序的主界面。
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// 创建应用程序的主界面。
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'NCUT Flutter 课程', home: MyHomePage());
  }
}

/// 主页面的状态类，包含视频播放和评论功能。
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/// 主页面的状态管理类。
class _MyHomePageState extends State<MyHomePage> {
  late VideoPlayerController _videoController;
  late TextEditingController _commentController;
  late Future<void> _initializeVideoPlayerFuture;
  final List<String> _comments = [];

  /// 初始化视频播放器和评论控制器。
  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();
    _initializeVideoPlayer();
  }

  /// 初始化视频播放器，包括加载视频和设置播放选项。
  void _initializeVideoPlayer() async {
    try {
      _videoController = VideoPlayerController.asset('assets/nezha.mp4');
      // Initialize the controller and store the Future for later use.
      _initializeVideoPlayerFuture = _videoController.initialize();
      await _initializeVideoPlayerFuture; // 等待初始化完成
      _videoController.setLooping(true);
      _videoController.play();
      setState(() {
        _comments.add("欢迎欣赏我的视频:");
      });
    } on Exception catch (e) {
      debugPrint("初始化视频播放器失败: $e"); // 异常处理
    }
  }

  /// 在组件不再使用时释放视频播放器和文本控制器资源。
  @override
  void dispose() {
    _videoController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  /// 构建界面，包含视频播放区域、评论输入和显示区域。
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('视频播放界面'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/background.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        foregroundColor: Colors.white,
        titleTextStyle: const TextStyle(fontSize: 20),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 10),
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // 如果 VideoPlayerController 对象已完成初始化，
                // 则使用原视频宽高比例确定 AspectRatio 组件的显示比例。
                return AspectRatio(
                  aspectRatio: _videoController.value.aspectRatio,
                  // 使用 VideoPlayer 显示视频。
                  child: VideoPlayer(_videoController),
                );
              } else {
                // 如果 VideoPlayerController 对象未完成初始化，
                // 则显示一个 CircularProgressIndicator 进度条。
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.deepOrangeAccent,
                    backgroundColor: Colors.grey,
                  ),
                );
              }
            },
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: '大数据 (中外)24-1班金朗原...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_commentController.text.isNotEmpty) {
                      setState(() {
                        _comments.add(_commentController.text);
                        _commentController.clear();
                      });
                    }
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _comments.length,
              itemBuilder: (context, index) {
                return ListTile(
                  textColor: Colors.blueAccent.shade700,
                  minTileHeight: 10,
                  minVerticalPadding: 1,
                  title: Text(_comments[index]),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_videoController.value.isPlaying) {
              _videoController.pause();
            } else {
              _videoController.play();
            }
          });
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/button.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Icon(
                _videoController.value.isPlaying
                    ? Icons.pause
                    : Icons.play_arrow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
