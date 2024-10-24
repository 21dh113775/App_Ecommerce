import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  static final AppDatabase instance = AppDatabase._init();
  static Database? _database;

  AppDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('app_database.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
      path,
      version:
          2, // Version updated to 2 for adding firebaseId in the users table
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    // Tạo bảng users
    await db.execute('''
      CREATE TABLE users (
         id INTEGER PRIMARY KEY AUTOINCREMENT,
      firebaseId TEXT NOT NULL,
      username TEXT NOT NULL,
      email TEXT NOT NULL,
      password_hash TEXT NOT NULL,
      full_name TEXT NOT NULL,
      phone_number TEXT NOT NULL,
      address TEXT NOT NULL,
      created_at TEXT NOT NULL,
      updated_at TEXT NOT NULL
      )
    ''');

    // Tạo bảng products
    await db.execute('''
      CREATE TABLE products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT,
        price REAL NOT NULL,
        image_url TEXT,
        category_id INTEGER NOT NULL,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL,
        FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE CASCADE
      )
    ''');
  }

  // Hàm nâng cấp cơ sở dữ liệu (nếu có phiên bản mới)
  Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Thêm cột firebaseId vào bảng users nếu phiên bản cơ sở dữ liệu là 1
      await db.execute('ALTER TABLE users ADD COLUMN firebaseId TEXT');
    }
  }

  // Hàm để xóa database (trong trường hợp cần phát triển lại)
  Future<void> deleteDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_database.db');
    await databaseFactory.deleteDatabase(path);
  }
}
