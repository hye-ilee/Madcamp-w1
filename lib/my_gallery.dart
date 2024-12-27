import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PinterestUI extends StatelessWidget {
  const PinterestUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> images = List.generate(
      20,
      (index) {
        final width = 200 + (index % 5) * 50;
        final height = 150 + (index % 12) * 50;
        return 'https://picsum.photos/$width/$height';
      },
    );

    return Container(
      color: Colors.black,
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
    );
  }
}
