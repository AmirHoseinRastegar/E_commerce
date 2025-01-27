import 'package:firebase_e_commerce/presentation/screens/home/prdocut_details_screen.dart';
import 'package:firebase_e_commerce/presentation/widgets/loading_screen.dart';
import 'package:firebase_e_commerce/presentation/widgets/shimmer_loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/categories/categories_bloc.dart';

class CategoriesView extends StatefulWidget {
  static const String screenRout = 'categories_rout';

  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  bool _isInit = false;

  @override
  void didChangeDependencies() {
    ///because context does not get build before full loaded screen we do not use init state
    ///instead we use didChangeDependencies
    super.didChangeDependencies();
    if (!_isInit) {
      context.read<CategoriesBloc>().add(ResetCategoriesEvent());

      context.read<CategoriesBloc>().add(GetProductCategory(
          category: ModalRoute.of(context)!.settings.arguments as String));
      _isInit = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    // final category = ModalRoute.of(context)!.settings.arguments as String;
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesLoading) {
          return const Center(child: ShimmerLoading());
        }
        if (state is CategoriesSuccess) {
          final products = state.loadedRelatedProducts;

          return Scaffold(
              body: products.isEmpty
                  ? const Center(
                      child: Text('No products found in this category...'),
                    )
                  : ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return ListTile(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return ProductDetailsScreen(id: product.id);
                              },
                            ));
                          },
                          title: Text(product.name),
                          subtitle: Text('\$${product.price}'),
                          leading: Image.network(product.imageUrl),
                        );
                      },
                    ));
        }
        if (state is CategoriesError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox();
      },
    );
  }
}
