import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PinterestUI extends StatelessWidget {
  final List<String> assetImages = [
    'assets/12o1.jpg',
    'assets/aight1.jpeg',
    'assets/aight2.jpg',
    'assets/cafe nuovo1.jpg',
    'assets/cafe nuovo2.jpg',
    'assets/friand1.jpg',
    'assets/friand2.jpg',
    'assets/gabae1.jpeg',
    'assets/gabae2.jpg',
    'assets/glory days1.jpg',
    'assets/oasis1.jpg',
    'assets/oasis2.jpg',
    'assets/ooo1.jpg',
    'assets/ooo2.jpeg',
    'assets/ooo3.jpg',
    'assets/ravic1.jpg',
    'assets/sosin1.jpg',
    'assets/sosin2.jpeg',
    'assets/yusungstar1.jpg',
    'assets/yusungstar2.jpg',
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(preferredSize: const Size.fromHeight(100),
        child: AppBar(
          backgroundColor: Colors.white,
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('추천하는 카페',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                const Text( '좋아하실 만한 카페 사진을 모아봤어요.',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 2),
                const Text( '가고 싶은 카페가 있는지 둘러볼까요?',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 32,
            crossAxisSpacing: 8,
            itemCount: assetImages.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  assetImages[index],
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}