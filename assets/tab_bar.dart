import 'package:flutter/material.dart';
import 'package:madcamp_w1/my_gallery.dart';
import 'package:madcamp_w1/contacts.dart';
import 'package:madcamp_w1/cafe_categories.dart';

class TapBar extends StatefulWidget {
  @override
  _TapBarState createState() => _TapBarState();
}

class _TapBarState extends State<TapBar> {
  static int _currentIndex = 0; // 현재 선택된 인덱스

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BottomNavigationBar(
            currentIndex: _currentIndex, // 현재 선택된 인덱스
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.coffee, color: _currentIndex == 0 ? Colors.deepPurple : Colors.grey), // 색상 변경
                label: 'Cafes',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.photo_album, color: _currentIndex == 1 ? Colors.deepPurple : Colors.grey), // 색상 변경
                label: 'My gallery',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, color: _currentIndex == 2 ? Colors.deepPurple : Colors.grey), // 색상 변경
                label: 'Contacts',
              ),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });

              if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CafeFinderUI()),
                );
              } else if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GalleryPage()),
                );
              } else if (index == 2){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactPickerPage()),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
