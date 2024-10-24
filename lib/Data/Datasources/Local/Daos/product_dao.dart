import 'package:ecommerce/Data/Datasources/Local/app_database.dart';
import 'package:sqflite/sqflite.dart';
import '../../../Model/product.dart';

class ProductDao {
  final dbProvider = AppDatabase.instance;

  Future<int> insertProduct(Product product) async {
    final db = await dbProvider.database;
    return await db.insert('products', product.toMap());
  }

  Future<int> updateProduct(Product product) async {
    final db = await dbProvider.database;
    return await db.update(
      'products',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  Future<int> deleteProduct(int id) async {
    final db = await dbProvider.database;
    return await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Product>> getAllProducts() async {
    final db = await dbProvider.database;
    final List<Map<String, dynamic>> result = await db.query('products');
    return result.map((map) => Product.fromMap(map)).toList();
  }

  Future<Product?> getProductById(int id) async {
    final db = await dbProvider.database;
    final result = await db.query(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return Product.fromMap(result.first);
    }
    return null;
  }
}
