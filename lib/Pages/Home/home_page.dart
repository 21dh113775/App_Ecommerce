import 'package:ecommerce/Pages/Home/Widget/app_bar.dart';
import 'package:ecommerce/Pages/Home/Widget/banner_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Data/Model/Repositories/product_repository.dart';
import '../../Data/Model/category_list.dart';
import '../../presentation/blocs/Product_Bloc/product_bloc.dart';
import '../../presentation/blocs/Product_Bloc/product_event.dart';
import 'Widget/product_content.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(
        RepositoryProvider.of<ProductRepository>(context),
      )..add(LoadProducts()),
      child: HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<ProductBloc>().add(LoadProducts());
          },
          child: CustomScrollView(
            slivers: [
              HomeAppBar(),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    BannerSlider(),
                    Categories(),
                    ProductContent(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
