import 'package:flutter/material.dart';
import 'package:phone_demo/my_gallery.dart';
import 'package:phone_demo/contacts.dart';

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
                icon: Icon(Icons.person,
                    color: _currentIndex == 0
                        ? Colors.deepPurple
                        : Colors.grey), // 색상 변경
                label: 'Contacts',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.photo_album,
                    color: _currentIndex == 1
                        ? Colors.deepPurple
                        : Colors.grey), // 색상 변경
                label: 'My gallery',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.thumb_up,
                    color: _currentIndex == 2
                        ? Colors.deepPurple
                        : Colors.grey), // 색상 변경
                label: 'Free topic',
              ),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });

              if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactPickerPage()),
                );
              } else if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PinterestUI()),
                );
              } else if (index == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PinterestUI()),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
