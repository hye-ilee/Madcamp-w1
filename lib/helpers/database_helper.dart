import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('cafes.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
      CREATE TABLE cafes (
        id $idType,
        name $textType,
        menus $textType,
        images $textType,
        kakao_id $textType,
        phone $textType,
        location $textType,
        music $integerType,
        study $integerType,
        dessert $integerType,
        pet $integerType,
        space $integerType,
        time $integerType
      )
    ''');
  }

  Future<void> close() async {
    final db = await database;
    db.close();
  }

  Future<int> insertCafe(Map<String, dynamic> cafe) async {
    final db = await database;
    return await db.insert('cafes', cafe);
  }

  Future<List<Map<String, dynamic>>> fetchAllCafes() async {
    final db = await database;
    return await db.query('cafes');
  }

  Future<int> deleteCafe(int id) async {
    final db = await database;
    return await db.delete(
      'cafes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> fetchCafesByScore(
      String scoreType, int minScore) async {
    final db = await database;
    return await db.query(
      'cafes',
      where: '$scoreType >= ?',
      whereArgs: [minScore],
    );
  }

  Future<List<Map<String, dynamic>>> getTopCafesByMusicScore() async {
    final db = await instance.database;
    final result = await db.query(
      'cafes',
      orderBy: 'music DESC',
      limit: 1,
    );
    return result;
  }

  Future<List<Map<String, dynamic>>> searchCafes(String query) async {
    final db = await instance.database;
    final result = await db.query(
      'cafes',
      where: 'name LIKE ? OR menus LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
    );
    return result;
  }
}
