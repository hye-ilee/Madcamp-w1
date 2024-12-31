import 'package:flutter/material.dart';
import 'package:phone_demo/cafe_list.dart';

String? _getCategoryLabelByFieldName(String fieldName) {
  switch (fieldName) {
    case 'vibey':
      return '분좋카_사진_잘_나오는';
    case 'afternoon':
      return '나른한_오후에_가고_싶은';
    case 'study':
      return '카공';
    case 'dessert':
      return '디저트_맛집';
    case 'coffee':
      return '커피_잘하는_집';
    case 'pet':
      return '반려견_동반';
    case 'time':
      return '늦게까지_하는';
    case 'space':
      return '대형카페';
    default:
      return null;
  }
}

List<Widget> makeHashtags(BuildContext context, Map<String, dynamic> cafe, int userCnt) {
  final hashtags = <Widget>[];

  cafe.forEach((key, value) {
    if (value is int && value > 8) {
      final label = _getCategoryLabelByFieldName(key);
      hashtags.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CafeListScreen(category: label, usercnt: userCnt),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text('#$label'),
          ),
        ),
      );
    }
  });

  return hashtags;
}
