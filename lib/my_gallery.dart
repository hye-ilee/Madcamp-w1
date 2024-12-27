import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:phone_demo/tab_bar.dart';

class PinterestUI extends StatelessWidget {
  final List<String> images = List.generate(
    20,
    (index) {
      final width = 200 + (index % 5) * 50; // 200~400 사이
      final height = 150 + (index % 12) * 50; // 150~700 사이
      return 'https://picsum.photos/$width/$height';
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('my gallery'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: Stack(
        children: [
          Container(
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 32,
                crossAxisSpacing: 8,
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      images[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom: 1,
            left: 0,
            right: 0,
            child: Center(
              child: TapBar(), // TapBar는 아래에 정의
            ),
          ),
        ],
      ),
    );
  }
}
