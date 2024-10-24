import '../../Datasources/Local/Daos/product_dao.dart';
import '../product.dart';

class ProductRepository {
  final ProductDao productDao = ProductDao();

  Future<int> addProduct(Product product) {
    return productDao.insertProduct(product);
  }

  Future<int> updateProduct(Product product) {
    return productDao.updateProduct(product);
  }

  Future<int> deleteProduct(int id) {
    return productDao.deleteProduct(id);
  }

  Future<List<Product>> getAllProducts() {
    return productDao.getAllProducts();
  }

  Future<Product?> getProductById(int id) {
    return productDao.getProductById(id);
  }
}
