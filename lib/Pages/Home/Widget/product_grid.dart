import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Data/Model/product.dart';
import '../../../presentation/blocs/Product_Bloc/product_bloc.dart';
import '../../../presentation/blocs/Product_Bloc/product_state.dart';

class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ProductLoaded) {
          return GridView.builder(
            padding: EdgeInsets.all(10),
            physics:
                NeverScrollableScrollPhysics(), // Giữ lưới cuộn trong `CustomScrollView`
            shrinkWrap: true, // Để lưới không chiếm toàn bộ không gian
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Số cột trong lưới
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.7, // Tỉ lệ giữa chiều cao và chiều rộng
            ),
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              final product = state.products[index];
              return ProductGridItem(product: product);
            },
          );
        } else if (state is ProductError) {
          return Center(child: Text('Đã xảy ra lỗi khi tải sản phẩm'));
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}

class ProductGridItem extends StatelessWidget {
  final Product product;

  const ProductGridItem({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Hành động khi người dùng nhấn vào sản phẩm
        // Ví dụ: chuyển hướng đến trang chi tiết sản phẩm
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                child: Image.network(
                  product.imageUrl ?? 'assets/placeholder.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: Icon(Icons.image, color: Colors.grey[500]),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${product.price.toStringAsFixed(0)}đ',
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
