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
    print('Executing _createDB...');

    await db.execute('''
    CREATE TABLE cafes (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      menus TEXT NOT NULL,
      images TEXT NOT NULL,
      kakao_id TEXT NOT NULL,
      phone TEXT NOT NULL,
      location TEXT NOT NULL,
      music INTEGER NOT NULL,
      study INTEGER NOT NULL,
      dessert INTEGER NOT NULL,
      pet INTEGER NOT NULL,
      space INTEGER NOT NULL,
      time INTEGER NOT NULL
    )
  ''');
    print('Created cafes table.');

    await db.execute('''
    CREATE TABLE user_info (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      user_name TEXT NOT NULL,
      music_cnt INTEGER NOT NULL,
      study_cnt INTEGER NOT NULL,
      dessert_cnt INTEGER NOT NULL,
      pet_cnt INTEGER NOT NULL,
      space_cnt INTEGER NOT NULL,
      time_cnt INTEGER NOT NULL,
      profile_img TEXT NOT NULL,
      jjim_list TEXT NOT NULL
    )
  ''');
    print('Created user_info table.');
  }

  Future<void> debugTables() async {
    final db = await DatabaseHelper.instance.database;
    final result =
        await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table'");
    print('Tables: $result');
  }

  Future<void> close() async {
    final db = await database;
    db.close();
  }

  Future<void> debugDatabase() async {
    final db = await database;

    // 테이블 목록 확인
    final tables =
        await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table'");
    print('Tables: $tables');

    // cafes 테이블 내용 확인
    final cafes = await db.query('cafes');
    print('Cafes data: $cafes');
  }

  Future<int> updateUserInfo(Map<String, dynamic> userInfo) async {
    final db = await database;
    return await db.update(
      'user_info',
      userInfo,
      where: 'id = ?',
      whereArgs: [userInfo['id']],
    );
  }

  Future<Map<String, dynamic>?> getCafeByKakaoId(String kakaoId) async {
    final db = await database;
    final result = await db.query(
      'cafes',
      where: 'kakao_id = ?',
      whereArgs: [kakaoId],
      limit: 1,
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<Map<String, dynamic>?> fetchUserInfo(int id) async {
    final db = await database;
    final result = await db.query(
      'user_info',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty ? Map<String, dynamic>.from(result.first) : null;
  }

  Future<int> insertUserInfo(Map<String, dynamic> userInfo) async {
    final db = await database;
    return await db.insert('user_info', userInfo);
  }

  Future<void> incrementUserCount(String countField) async {
    final db = await database;

    // Ensure the field exists in the user_info table
    await db.rawUpdate('''
    UPDATE user_info
    SET $countField = $countField + 1
    WHERE id = 1
  '''); // Assuming user ID is 1 for now.
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
      where: 'id = 1',
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
      limit: 5,
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

  Future<List<Map<String, dynamic>>> getTopCafesByCategory(
      String scoreField, int userCnt) async {
    final db = await database;

    final result = await db.rawQuery('''
    SELECT *,
          ($scoreField * $userCnt) AS weighted_score
    FROM cafes
    ORDER BY weighted_score DESC
    LIMIT 5
  ''');

    return result;
  }
}
