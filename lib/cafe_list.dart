import 'package:flutter/material.dart';
import 'package:phone_demo/helpers/database_helper.dart';

class CafeListScreen extends StatefulWidget {
  const CafeListScreen({Key? key}) : super(key: key);

  @override
  _CafeListScreenState createState() => _CafeListScreenState();
}

class _CafeListScreenState extends State<CafeListScreen> {
  late Future<List<Map<String, dynamic>>> _topCafes;

  final List<Map<String, String>> categories = [
    {'image': 'assets/music.png', 'label': '음악이 좋은'},
    {'image': 'assets/study.png', 'label': '공부하기 좋은'},
    {'image': 'assets/dessert.png', 'label': '디저트 맛집'},
    {'image': 'assets/pet-friendly.png', 'label': '반려견 동반'},
    {'image': 'assets/late hours.png', 'label': '늦게까지 하는'},
    {'image': 'assets/spacious.png', 'label': '공간이 넓은'},
  ];

  @override
  void initState() {
    super.initState();
    _topCafes =
        DatabaseHelper.instance.getTopCafesByMusicScore(); // Default sort
  }

  String? _getFieldNameByCategoryLabel(String label) {
    switch (label) {
      case '음악이 좋은':
        return 'music';
      case '공부하기 좋은':
        return 'study';
      case '디저트 맛집':
        return 'dessert';
      case '반려견 동반':
        return 'pet';
      case '늦게까지 하는':
        return 'time';
      case '공간이 넓은':
        return 'space';
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text(
                    '카페 찾기',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  decoration: InputDecoration(
                    hintText: '오늘 내가 가고 싶은 카페는?',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                    ),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return GestureDetector(
                        onTap: () async {
                          final fieldName =
                              _getFieldNameByCategoryLabel(category['label']!);
                          if (fieldName != null) {
                            await DatabaseHelper.instance.incrementUserCount(
                                '${fieldName}_cnt'); // Increment user's category count

                            final userInfo = await DatabaseHelper.instance
                                .fetchUserInfo(1); // Ensure user info exists
                            if (userInfo != null) {
                              final userCntField = '${fieldName}_cnt';
                              final userCnt = userInfo[userCntField] ??
                                  1; // Default to 1 if null

                              setState(() {
                                _topCafes = DatabaseHelper.instance
                                    .getTopCafesByCategory(fieldName, userCnt);
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        '${category['label']} 기준으로 카페를 정렬합니다.')),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('잘못된 카테고리 선택입니다.')),
                            );
                          }
                        },
                        child: Column(
                          children: [
                            Expanded(
                              child: Image.asset(
                                category['image']!,
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              category['label']!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 14.0),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                FutureBuilder<List<Map<String, dynamic>>>(
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
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cafes.length,
                        itemBuilder: (context, index) {
                          final cafe = cafes[index];
                          return ListTile(
                            title: Text(cafe['name']),
                            trailing: Text('Location: ${cafe['location']}'),
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
