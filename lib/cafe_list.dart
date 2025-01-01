import 'package:flutter/material.dart';
import 'package:phone_demo/helpers/database_helper.dart';
import 'package:phone_demo/helpers/popup_helper.dart';

class CafeListScreen extends StatefulWidget {
  const CafeListScreen({Key? key}) : super(key: key);

  @override
  _CafeListScreenState createState() => _CafeListScreenState();
}

class _CafeListScreenState extends State<CafeListScreen> {
  late Future<List<Map<String, dynamic>>> _topCafes;
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  List<Map<String, dynamic>> _searchResults = [];

  Future<void> _searchCafes(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }
    final results = await DatabaseHelper.instance.searchCafes(query);
    setState(() {
      _searchResults = results;
      _isSearching = true;
    });
  }

  final List<Map<String, String>> categories = [
    {'image': 'assets/vibey.png', 'label': '분좋카'},
    {'image': 'assets/afternoon.png', 'label': '나른한 오후'},
    {'image': 'assets/cagong.png', 'label': '카공'},
    {'image': 'assets/dessert.png', 'label': '디저트 맛집'},
    {'image': 'assets/coffee.png', 'label': '커피 전문'},
    {'image': 'assets/pet.png', 'label': '반려견 동반'},
    {'image': 'assets/late-hours.png', 'label': '늦게까지 하는'},
    {'image': 'assets/space.png', 'label': '대형카페'},
  ];

  @override
  void initState() {
    super.initState();
    _topCafes = DatabaseHelper.instance.getTopCafesByVibeyScore();
  }

  String? _getFieldNameByCategoryLabel(String label) {
    switch (label) {
      case '분좋카':
        return 'vibey';
      case '나른한 오후':
        return 'afternoon';
      case '카공':
        return 'study';
      case '디저트 맛집':
        return 'dessert';
      case '커피 전문':
        return 'coffee';
      case '반려견 동반':
        return 'pet';
      case '늦게까지 하는':
        return 'time';
      case '대형카페':
        return 'space';
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: _isSearching
            ? Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      _isSearching = false;
                      _searchController.clear();
                    });
                  },
                ),
              )
            : const Text(
                '카페 찾기',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: '오늘 내가 가고 싶은 카페는?',
                      hintStyle: const TextStyle(color: Colors.grey),
                      suffixIcon: IconButton(
                        onPressed: () {
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
                ),
                Expanded(
                  child: _isSearching
                      ? (_searchResults.isEmpty
                          ? const Center(
                              child: Text(
                                '검색 결과가 없습니다',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: _searchResults.length,
                              itemBuilder: (context, index) {
                                final cafe = _searchResults[index];
                                return ListTile(
                                  title: Text(cafe['name']),
                                  onTap: () {
                                    showCafeInfoPopup(context, cafe);
                                  },
                                );
                              },
                            ))
                      : Stack(
                          children: [
                            SizedBox(
                              child: GridView.builder(
                                padding: const EdgeInsets.all(8.0),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  mainAxisExtent: screenHeight / 10,
                                  crossAxisSpacing: 8.0,
                                  mainAxisSpacing: 8.0,
                                ),
                                itemCount: categories.length,
                                itemBuilder: (context, index) {
                                  final category = categories[index];
                                  return GestureDetector(
                                    onTap: () async {
                                      final fieldName =
                                          _getFieldNameByCategoryLabel(
                                              category['label']!);
                                      if (fieldName != null) {
                                        await DatabaseHelper.instance
                                            .incrementUserCount(
                                                '${fieldName}_cnt');
                                        final userInfo = await DatabaseHelper
                                            .instance
                                            .fetchUserInfo(1);
                                        if (userInfo != null) {
                                          final userCntField =
                                              '${fieldName}_cnt';
                                          final userCnt =
                                              userInfo[userCntField] ?? 1;
                                          setState(() {
                                            _topCafes = DatabaseHelper.instance
                                                .getTopCafesByCategory(
                                                    fieldName, userCnt);
                                          });
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    '${category['label']} 기준으로 카페를 정렬합니다.')),
                                          );
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text('잘못된 카테고리 선택입니다.')),
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
                                          style:
                                              const TextStyle(fontSize: 14.0),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              top: screenHeight * 0.27,
                              left: 16.0,
                              right: 16.0,
                              child: Container(
                                height: screenHeight * 0.3,
                                decoration: BoxDecoration(
                                  color: Colors.white38,
                                  borderRadius: BorderRadius.circular(12.0),
                                  border: Border.all(
                                      color: Colors.grey, width: 1.0),
                                ),
                                padding: const EdgeInsets.only(
                                    left: 4.0,
                                    right: 4.0,
                                    top: 0.0,
                                    bottom: 0.0),
                                child:
                                    FutureBuilder<List<Map<String, dynamic>>>(
                                  future: _topCafes,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else if (snapshot.hasError) {
                                      return Center(
                                        child: Text('Error: ${snapshot.error}'),
                                      );
                                    } else if (!snapshot.hasData ||
                                        snapshot.data!.isEmpty) {
                                      return const Center(
                                        child: Text(
                                          '아직 해당 카테고리에 등록된 카페가 없어요',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.grey),
                                        ),
                                      );
                                    } else {
                                      final cafes = snapshot.data!;
                                      return ListView.builder(
                                        itemCount: cafes.length,
                                        itemBuilder: (context, index) {
                                          final cafe = cafes[index];
                                          return ListTile(
                                            dense: true,
                                            leading: Container(
                                              width: 32.0,
                                              height: 32.0,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                                shape: BoxShape.circle,
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                '${index + 1}',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14.0,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            title: Text(
                                              cafe['name'],
                                              style: const TextStyle(
                                                  fontSize: 16.0),
                                            ),
                                            onTap: () {
                                              showCafeInfoPopup(context, cafe);
                                            },
                                          );
                                        },
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
