import 'package:flutter/material.dart';
import 'package:phone_demo/helpers/database_helper.dart';
import 'package:phone_demo/helpers/kakao_map_helper.dart';
import 'dart:convert';

void showCafeInfoPopup(BuildContext context, Map<String, dynamic> cafe) async {
  final userInfo = await DatabaseHelper.instance.fetchUserInfo(1);
  List<String> jjims = [];
  if (userInfo != null) {
    jjims = List<String>.from(
      jsonDecode(userInfo['jjim_list']),
    );
  }
  bool isFavorite = jjims.contains(cafe['kakao_id']);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: Text(cafe['name']),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Location: ${cafe['location']}'),
                const SizedBox(height: 8.0),
                Text('Menus: ${cafe['menus']}'),
              ],
            ),
            actions: [
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.star : Icons.star_border,
                  color: isFavorite ? Colors.yellow : null,
                ),
                onPressed: () async {
                  setState(() {
                    isFavorite = jjims.contains(cafe['kakao_id']) ? false : true;
                  });

                  // Update jjim_list in the database
                  if (isFavorite) {
                    jjims.add(cafe['kakao_id']);
                  } else {
                    jjims.remove(cafe['kakao_id']);
                  }

                  // Update user info in the database
                  if(userInfo != null) {
                    userInfo["jjim_list"] = jsonEncode(jjims);
                    await DatabaseHelper.instance.updateUserInfo(userInfo);
                    // print('3 jjim list: ${userInfo["jjim_list"]}');
                  }
                },
              ),

              // 지도 보기 버튼
              TextButton(
                onPressed: () {
                  KakaoMapHelper.openKakaoPlaceWithId(cafe['kakao_id']);
                },
                child: const Text('지도 보기'),
              ),

              // 닫기 버튼
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('닫기'),
              ),
            ],
          );
        },
      );
    },
  );
}