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
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _fetchJjimList();
  }

  Future<void> _fetchJjimList() async {
    try {
      // Assuming user ID is fixed or provided, replace `1` with actual user ID
      final userInfo = await DatabaseHelper.instance.fetchUserInfo(1);
      if (userInfo != null) {
        final String? jjimListString = userInfo['jjim_list'];
        if (jjimListString != null && jjimListString.isNotEmpty) {
          // Deserialize JSON string to a List
          List<dynamic> jjimList = jsonDecode(jjimListString);

          final List<Map<String, dynamic>> fetchedCafes = [];
          for (String kakaoId in jjimList) {
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
      appBar: AppBar(
        title: const Text('My Cafes'),
      ),
      body: ListView.builder(
        itemCount: _cafes.length,
        itemBuilder: (context, index) {
          final cafe = _cafes[index];
          return ListTile(
            title: Text(cafe['name'] ?? 'Unnamed Cafe'),
            subtitle: Text(cafe['phone'] ?? 'No Phone Number'),
            trailing: IconButton(
              icon: const Icon(Icons.phone, color: Colors.green),
              onPressed: () {
                if (cafe['phone'] != null) {
                  _makePhoneCall(cafe['phone']);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No phone number available.')),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
