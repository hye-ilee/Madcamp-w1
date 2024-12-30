import 'package:flutter/material.dart';

void showCafeInfoPopup(BuildContext context, Map<String, dynamic> cafe) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(cafe['name']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Location: ${cafe['location']}'),
            const SizedBox(height: 8.0),
            Text('Rating: ${cafe['rating']}'), // Adjust fields as per your data
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      );
    },
  );
}
