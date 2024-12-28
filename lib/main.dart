import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:phone_demo/database/database_initializer.dart';
import 'package:sqflite/sqflite.dart';
import 'cafe_list.dart';
import 'contacts.dart';
import 'my_gallery.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Delete the existing database
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, 'cafes.db');
  await deleteDatabase(path); // Delete the existing database file

  // Initialize the database with the correct schema
  await DatabaseInitializer.initializeDatabase();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
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
    const ContactPickerPage(),
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
