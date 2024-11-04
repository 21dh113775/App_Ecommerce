import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Data/Model/product.dart';
import '../../../presentation/blocs/Product_Bloc/product_bloc.dart';
import '../../../presentation/blocs/Product_Bloc/product_event.dart';
import '../../../presentation/blocs/Product_Bloc/product_state.dart';
import 'flash_sale.dart';
import 'product_grid.dart';

class ProductContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is ProductError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Đã có lỗi xảy ra: ${state.error}'),
                ElevatedButton(
                  onPressed: () {
                    context.read<ProductBloc>().add(LoadProducts());
                  },
                  child: Text('Thử lại'),
                ),
              ],
            ),
          );
        }

        if (state is ProductLoaded) {
          if (state.products.isEmpty) {
            return Center(child: Text('Không có sản phẩm'));
          }
        }

        return SizedBox.shrink();
      },
    );
  }
}
