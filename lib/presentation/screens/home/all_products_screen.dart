import 'package:firebase_e_commerce/presentation/screens/categories_view/category_view.dart';
import 'package:firebase_e_commerce/presentation/widgets/shimmer_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/product/product_bloc.dart';

class AllProductsScreen extends StatefulWidget {
  static const String screenRout = '/all_products_screen';

  const AllProductsScreen({super.key});

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  bool _isInit = false;

  @override
  initState() {
    super.initState();
    if (!_isInit) {
      context.read<ProductBloc>().add(FetchProductEvent());
      _isInit = true;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<ProductBloc, ProductState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ProductLoading) {
          return const Center(child: ShimmerLoading());
        }
        if (state is ProductSuccess) {
          return ListView.builder(
            itemCount: state.productModel.length,
            itemBuilder: (context, index) {
              final product = state.productModel[index];
              return CategoryWidget(product: product,);
            },
          );
        }
        if (state is ProductFailed) {
          return Center(
            child: Text(state.message),
          );
        }
         return const Center(child: CircularProgressIndicator());
      },
    ));
  }
}
