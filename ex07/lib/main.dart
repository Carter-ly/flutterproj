import 'package:flutter/material.dart';

// 页面数据类，用于存储每个页面的标题、名称、图标和内容
class PageData {
  final String title;
  final String name;
  final IconData icon;
  final String content;
  // 构造函数，初始化页面数据类的属性
  PageData({
    required this.title,
    required this.name,
    required this.icon,
    required this.content,
  });
}

// 存储所有页面数据的列表
List<PageData> myPages = [
  // 初始化第一个页面数据
  PageData(
    title: 'NCUT布院专业介绍\n--数据科学与大数据技术',
    name: '大数据',
    icon: Icons.analytics,
    content:
        ' 数据科学与大数据技术专业以统计学、数学和计算机科学为基础，以“新工科”教育理念为指导，瞄准国家大数据战略需求和国际数据科学学术前沿。本专业依托并结合北方工业大学和英国伦敦布鲁内尔大学在数据科学与大数据领域的办学实力，通过引进伦敦布鲁内尔大学先进的教育理念、教学方法、课程体系，在两校高水平教师共同努力下，为学生提供多样化的学习形式和多选择性学习内容。本专业配有先进的大数据实验、实训和科研平台，实验设施完备，实验条件优越，教师科研实力雄厚，为学生培养提供了优良的教学环境。专业通过教学与科研互动，多学科融合，积极举办学科竞赛，专业建设与技术发展保持同步等方式与手段，发掘学生的创造力和潜能，注重培养学生大数据应用开发与分析,利用大数据思维解决问题的能力。',
  ),
  // 初始化第二个页面数据
  PageData(
    title: 'NCUT布院专业介绍\n--机械制造及其自动化',
    name: '机械',
    icon: Icons.construction,
    content:
        ' 本专业依托北方工业大学和英国伦敦布鲁内尔大学在机械工程领域的办学实力，结合并辅以双方在该领域的优势课程，创新课程体系和教学模式。本专业以注重学生工程实践能力、应用研究能力和创新能力的培养为特色，引进布鲁内尔大学专业核心课程体系，聚集两校顶尖教师授课，融合北方工业大学国家级实验教学示范中心、北京市高等学校示范性校内创新实践基地等优质实践教学资源，实验室开放程度高。项目学生实行双注册制，享受中英双方学校教育资源及所有学生权益和政策。学生培养严格按照中英双方大学联合制定的培养方案和质量控制体系开展，教学内容强调专业知识体系，突出两校在机械工程技术领域的优势特色学科基础，在专业建设上与经济社会发展保持同步，不断适应社会及行业对国际化高素质复合型人才需求的变化。',
  ),
  // 初始化第三个页面数据
  PageData(
    title: 'NCUT布院专业介绍\n--土木工程',
    name: '土木',
    icon: Icons.engineering,
    content:
        ' 本专业依托并结合北方工业大学和英国伦敦布鲁内尔大学在土木工程领域的办学实力，整合了双方在该领域的优势课程，创新了课程体系，突出两校在土木工程技术领域的优势特色与学科基础。学生将获得土木工程结构设计、施工、管理等职业工程师的基本训练，学习全新的“数字化设计、工业化生产、装配式施工、信息化管理、智能化应用”的智能建造理念，通过学习运用数学、力学等专业知识来规划和设计与未来社会经济相适应的基础设施，学生还有机会到拥有全球领先的建筑工业化装备研发-制造-生产等能力的企业实践基地进行工程实践训练。本专业学位课程将会在英方专业工程师协会注册申请认证，毕业生在积累足够专业知识和工作经验后可申请英国注册工程师资质。',
  ),
];

void main() {
  runApp(const MyApp());
}

// 应用程序的主类
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // 构建方法，返回 MaterialApp 作为应用程序的根组件
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'NCUT Flutter 课程', home: MyHomePage());
  }
}

// 主页类，继承自 StatefulWidget
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  // 创建状态类
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// 主页状态类，继承自 State
class _MyHomePageState extends State<MyHomePage> {
  // 存储底部导航栏项目的列表
  final List<BottomNavigationBarItem> _myNaviBarItems =
      myPages
          .map(
            (e) => BottomNavigationBarItem(icon: Icon(e.icon), label: e.name),
          )
          .toList();
  // 当前选中的页面索引
  int _currentIndex = 0;
  // 构建方法，返回当前页面的 UI 结构
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 设置应用的主界面
      home: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60.0,
          title: Transform.translate(
            offset: const Offset(0, -3),
            child: Text(
              '页面导航栏:${myPages[_currentIndex].name}\n--大数据 (中外) 24-1班金朗原',
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          foregroundColor: Colors.white,
          titleTextStyle: const TextStyle(
            fontSize: 23,
            color: Color.fromARGB(255, 233, 88, 30),
            fontWeight: FontWeight.bold,
          ),
        ),
        // 设置应用的主体内容
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            children: [
              // 显示当前页面的标题文字
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
              // 显示当前页面的内容
              Text(
                myPages[_currentIndex].content,
                style: const TextStyle(fontSize: 18, color: Colors.blueGrey),
              ),
            ],
          ),
        ),
        // 设置应用的底部导航栏
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.red.shade600,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          currentIndex: _currentIndex,
          onTap: (index) {
            // 当底部导航栏项目被点击时，更新当前选中的页面索引
            setState(() {
              _currentIndex = index;
            });
          },
          items: _myNaviBarItems,
        ),
      ),
    );
  }
}
