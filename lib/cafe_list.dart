import 'package:flutter/material.dart';
import 'package:phone_demo/helpers/database_helper.dart';

class CafeListScreen extends StatefulWidget {
  const CafeListScreen({Key? key}) : super(key: key);

  @override
  _CafeListScreenState createState() => _CafeListScreenState();
}

class _CafeListScreenState extends State<CafeListScreen> {
  late Future<List<Map<String, dynamic>>> _topCafes;
  final TextEditingController _searchController = TextEditingController();//검색 textfield의 text 가져오기

  List<Map<String, dynamic>> _searchResults = [];
  Future<void> _searchCafes(String query) async {
    if(query.isEmpty){
      setState(() {
        _searchResults = [];
      });
      return;
    }
    final results = await DatabaseHelper.instance.searchCafes(query);
    setState(() {
      _searchResults = results;
    });
    if(results.isNotEmpty){
      _resultsPopup(results);
    }
  }
  
  void _resultsPopup(List<Map<String, dynamic>> cafes) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('검색 결과'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: cafes.length,
                itemBuilder: (context, index) {
                  final cafe = cafes[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(cafe['name']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('메뉴: ${cafe['menus']}'),
                          Text('연락처: ${cafe['phone']}'),
                          Text('위치: ${cafe['location']}'),
                        ],
                      ),
                      isThreeLine: true,
                    ),
                  );
                },
              ),
            ),
          actions: [
            TextButton(onPressed: () {
              Navigator.of(context).pop();
              },
              child: const Text('close')
            ),
          ],
        );
      },
    );
  }
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
    _topCafes = DatabaseHelper.instance.getTopCafesByMusicScore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Categories Section
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
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
                    suffixIcon: IconButton(onPressed: () {
                      _searchCafes(_searchController.text);
                      },
                      icon: const Icon(Icons.search),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                  ),
                ),
                const SizedBox(height: 16.0),
                Expanded(
                  child: ListView.builder(
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      final cafes = _searchResults;
                      return ListTile(
                        title: Text(cafes[index]['name']),
                        onTap: () {
                          _resultsPopup(cafes);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                // Grid of Categories
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    shrinkWrap:
                    true, // Allow GridView to take only necessary space
                    physics:
                    const NeverScrollableScrollPhysics(), // Prevent inner scrolling
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
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                Text('#${category['label']} 카테고리 선택됨!')),
                          );
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
                // Cafes List Section
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
                        shrinkWrap:
                        true, // Allow ListView to take only necessary space
                        physics:
                        const NeverScrollableScrollPhysics(), // Prevent inner scrolling
                        itemCount: cafes.length,
                        itemBuilder: (context, index) {
                          final cafe = cafes[index];
                          return ListTile(
                            title: Text(cafe['name']),
                            subtitle: Text('Music Score: ${cafe['music']}'),
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
