import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phone_demo/helpers/databse_util.dart';
import 'cafe_list.dart';
import 'contacts.dart';
import 'my_gallery.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 필요할 때만 데이터베이스 초기화
  await initializeDatabaseIfNeeded();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cafe-in App',
      theme: ThemeData(primarySwatch: Colors.brown),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 1;

  final List<Widget> _pages = [
    const JjimListPage(),
    const CafeListScreen(),
    PinterestUI(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_cafe),
            label: 'Cafes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo),
            label: 'Gallery',
          ),
        ],
      ),
    );
  }
}
