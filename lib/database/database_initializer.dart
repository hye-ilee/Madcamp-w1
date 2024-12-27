import 'package:phone_demo/helpers/database_helper.dart';

class DatabaseInitializer {
  static Future<void> initializeDatabase() async {
    final sampleCafes = [
      {
        'name': 'Cafe 1',
        'menus': 'Latte, Espresso, Tiramisu',
        'images': 'image1.jpg,image2.jpg',
        'kakao_id': '123456',
        'phone': '010-1234-5678',
        'location': 'Seoul, Korea',
        'music': 8,
        'study': 9,
        'dessert': 10,
        'pet': 6,
        'space': 7,
        'time': 5,
      },
      {
        'name': 'Cafe 2',
        'menus': 'Cappuccino, Mocha, Latte',
        'images': 'image3.jpg,image4.jpg',
        'kakao_id': '654321',
        'phone': '010-8765-4321',
        'location': 'Busan, Korea',
        'music': 7,
        'study': 8,
        'dessert': 9,
        'pet': 5,
        'space': 6,
        'time': 7,
      },
      {
        'name': 'Cafe 3',
        'menus': 'Americano, Black Coffee',
        'images': 'image5.jpg,image6.jpg',
        'kakao_id': '987654',
        'phone': '010-3456-7890',
        'location': 'Incheon, Korea',
        'music': 9,
        'study': 7,
        'dessert': 8,
        'pet': 8,
        'space': 6,
        'time': 9,
      },
    ];

    // Insert sample cafes into the database
    for (var cafe in sampleCafes) {
      await DatabaseHelper.instance.insertCafe(cafe);
    }
  }
}
