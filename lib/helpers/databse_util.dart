import 'package:phone_demo/database/database_initializer.dart';
import 'package:phone_demo/helpers/database_helper.dart';
import 'package:sqflite/sqflite.dart';

Future<void> initializeDatabaseIfNeeded() async {
  final db = await DatabaseHelper.instance.database;

  final result = await db.rawQuery('SELECT COUNT(*) as count FROM cafes');
  final count = Sqflite.firstIntValue(result) ?? 0;

  if (count == 0) {
    print('Database is empty. Initializing...');
    await DatabaseInitializer.initializeDatabase();
  } else {
    print('Database already initialized.');
  }
}
