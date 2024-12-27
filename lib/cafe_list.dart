import 'package:flutter/material.dart';
import 'package:phone_demo/helpers/database_helper.dart';

class TopCafesScreen extends StatefulWidget {
  const TopCafesScreen({Key? key}) : super(key: key);

  @override
  _TopCafesScreenState createState() => _TopCafesScreenState();
}

class _TopCafesScreenState extends State<TopCafesScreen> {
  late Future<List<Map<String, dynamic>>> _topCafes;

  @override
  void initState() {
    super.initState();
    _topCafes = DatabaseHelper.instance.getTopCafesByMusicScore();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
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
    );
  }
}
