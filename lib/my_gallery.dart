import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:phone_demo/helpers/database_helper.dart';
import 'package:phone_demo/helpers/popup_helper.dart';

class PinterestUI extends StatefulWidget {
  const PinterestUI({Key? key}) : super(key: key);

  @override
  _PinterestUIState createState() => _PinterestUIState();
}

class _PinterestUIState extends State<PinterestUI> {
  late Future<List<Map<String, dynamic>>> _topCafes;

  @override
  void initState() {
    super.initState();
    _topCafes = _fetchTopCafes();
  }

  Future<List<Map<String, dynamic>>> _fetchTopCafes() async {
    final db = await DatabaseHelper.instance.database;
    return db.rawQuery('''
      SELECT *, 
             (music * music_cnt + study * study_cnt + dessert * dessert_cnt + 
              pet * pet_cnt + space * space_cnt + time * time_cnt) AS weighted_score
      FROM cafes, user_info
      WHERE user_info.id = 1
      ORDER BY weighted_score DESC
      LIMIT 20;
    ''');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          backgroundColor: Colors.white,
          flexibleSpace: const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '추천하는 카페',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  '좋아하실 만한 카페 사진을 모아봤어요.',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                SizedBox(height: 2),
                Text(
                  '가고 싶은 카페가 있는지 둘러볼까요?',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _topCafes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No cafes found.'));
          } else {
            final cafes = snapshot.data!;
            return Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MasonryGridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 32,
                  crossAxisSpacing: 8,
                  itemCount: cafes.length,
                  itemBuilder: (context, index) {
                    final cafe = cafes[index];
                    return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: GestureDetector(
                          child: Image.asset(
                            cafe['images']
                                .split(',')
                                .first
                                .trim(), // Split and use the first image path
                            fit: BoxFit.cover,
                          ),
                          onTap: () {
                            showCafeInfoPopup(context, cafe);
                          },
                        ));
                  },
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
