import 'package:sqflite/sqflite.dart';
import 'package:ecommerce/Data/Model/user.dart';
import '../app_database.dart';

class UserDao {
  final dbProvider = AppDatabase.instance;

  // Thêm người dùng vào SQLite
  Future<int> insertUser(User user) async {
    final db = await dbProvider.database;
    return await db.insert('users', user.toJson());
  }

  // Lấy người dùng theo ID
  Future<User?> getUserById(int id) async {
    final db = await dbProvider.database;
    final result = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return User.fromJson(result.first);
    }
    return null;
  }

  // Lấy người dùng dựa vào firebaseId
  Future<User?> getUserByFirebaseId(String firebaseId) async {
    final db = await dbProvider.database;
    final result = await db.query(
      'users',
      where:
          'firebaseId = ?', // Đảm bảo cột firebaseId tồn tại trong bảng users
      whereArgs: [firebaseId],
    );

    if (result.isNotEmpty) {
      return User.fromJson(result.first); // Trả về đối tượng User
    }
    return null; // Trả về null nếu không tìm thấy người dùng
  }

  // Cập nhật người dùng
  Future<int> updateUser(User user) async {
    final db = await dbProvider.database;
    return await db.update(
      'users',
      user.toJson(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  // Xóa người dùng theo ID
  Future<int> deleteUser(int id) async {
    final db = await dbProvider.database;
    return await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Lấy tất cả người dùng
  Future<List<User>> getAllUsers() async {
    final db = await dbProvider.database;
    final result = await db.query('users');
    return result.map((json) => User.fromJson(json)).toList();
  }
}
