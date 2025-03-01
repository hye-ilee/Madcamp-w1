import 'package:flutter/material.dart';
import 'package:phone_demo/helpers/database_helper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

class JjimListPage extends StatefulWidget {
  const JjimListPage({Key? key}) : super(key: key);

  @override
  _JjimListPageState createState() => _JjimListPageState();
}

class _JjimListPageState extends State<JjimListPage> {
  List<Map<String, dynamic>> _cafes = [];
  List<String> _jjimList = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchJjimList();
  }

  Future<void> _fetchJjimList() async {
    try {
      final userInfo = await DatabaseHelper.instance.fetchUserInfo(1);
      if (userInfo != null) {
        final String? jjimListString = userInfo['jjim_list'];
        if (jjimListString != null && jjimListString.isNotEmpty) {
          _jjimList = List<String>.from(jsonDecode(jjimListString));

          final List<Map<String, dynamic>> fetchedCafes = [];
          for (String kakaoId in _jjimList) {
            final cafe =
                await DatabaseHelper.instance.getCafeByKakaoId(kakaoId);
            if (cafe != null) {
              fetchedCafes.add(cafe);
            }
          }
          setState(() {
            _cafes = fetchedCafes;
          });
        }
      }
    } catch (e) {
      print('Error fetching jjim list: $e');
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  void _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not make the call.')),
      );
    }
  }

  Future<void> _toggleFavorite(String kakaoId) async {
    try {
      setState(() {
        if (_jjimList.contains(kakaoId)) {
          _jjimList.remove(kakaoId);
        } else {
          _jjimList.add(kakaoId);
        }
      });

      final userInfo = await DatabaseHelper.instance.fetchUserInfo(1);
      if (userInfo != null) {
        userInfo['jjim_list'] = jsonEncode(_jjimList);
        await DatabaseHelper.instance.updateUserInfo(userInfo);
      }
    } catch (e) {
      print('Error updating favorite list: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_cafes.isEmpty) {
      return const Center(
        child: Text(
          'No cafes found in your Jjim list.',
          textAlign: TextAlign.center,
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          '찜한 카페 목록',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: _cafes.length,
        itemBuilder: (context, index) {
          final cafe = _cafes[index];
          final bool isFavorite = _jjimList.contains(cafe['kakao_id']);
          return ListTile(
            title: Text(cafe['name'] ?? 'Unnamed Cafe'),
            subtitle: Text(cafe['phone'] ?? 'No Phone Number'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.star : Icons.star_border,
                    color: isFavorite ? Colors.yellow : null,
                  ),
                  onPressed: () async {
                    await _toggleFavorite(cafe['kakao_id']);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.phone, color: Colors.green),
                  onPressed: () {
                    if (cafe['phone'] != null) {
                      _makePhoneCall(cafe['phone']);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('No phone number available.')),
                      );
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
