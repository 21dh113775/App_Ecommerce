import 'package:ecommerce/Data/Datasources/Local/Daos/user_dao.dart';
import 'package:ecommerce/Data/Model/user.dart';

class UserRepository {
  final UserDao _userDao;

  UserRepository(this._userDao);

  // Thêm người dùng vào SQLite
  Future<void> addUser(User user) => _userDao.insertUser(user);

  // Lấy người dùng dựa vào id từ SQLite
  Future<User?> getUser(int id) => _userDao.getUserById(id);

  // Lấy danh sách tất cả người dùng từ SQLite
  Future<List<User>> getAllUsers() => _userDao.getAllUsers();

  // Cập nhật thông tin người dùng trong SQLite
  Future<void> updateUser(User user) => _userDao.updateUser(user);

  // Xóa người dùng dựa vào id từ SQLite
  Future<void> deleteUser(int id) => _userDao.deleteUser(id);

  // Lấy người dùng dựa vào firebaseId (uid của Firebase)
  Future<User?> getUserByFirebaseId(String firebaseId) =>
      _userDao.getUserByFirebaseId(firebaseId);
}
