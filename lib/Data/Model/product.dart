class Product {
  final int? id;
  final String name;
  final String? description;
  final double price;
  final String? imageUrl;
  final int categoryId;
  final String createdAt;
  final String updatedAt;

  Product({
    this.id,
    required this.name,
    this.description,
    required this.price,
    this.imageUrl,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
  });

  // Chuyển Product thành Map để lưu trữ trong database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image_url': imageUrl,
      'category_id': categoryId,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  // Tạo Product từ Map lấy từ database
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      price: map['price'],
      imageUrl: map['image_url'],
      categoryId: map['category_id'],
      createdAt: map['created_at'],
      updatedAt: map['updated_at'],
    );
  }
}
