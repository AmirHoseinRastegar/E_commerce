import 'package:firebase_e_commerce/data/model/product_model.dart';
import 'package:firebase_e_commerce/presentation/screens/home/prdocut_details_screen.dart';
import 'package:firebase_e_commerce/presentation/widgets/shimmer_loading_widget.dart';
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
                  : Padding(
                      padding: const EdgeInsets.only(
                        bottom: 35,
                      ),
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return CategoryWidget(product: product);
                        },
                      ),
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

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return ProductDetailsScreen(id: product.id);
          },
        ));
      },
      child: Padding(
        padding: const EdgeInsets.only(
          top: 15,
          left: 10,
          right: 10,
          bottom: 0,
        ),
        child: Card(
          elevation: 2,
          child: SizedBox(
            height: 150,
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.0),
                    child: Image.network(
                      product.imageUrl,
                      errorBuilder: (context, error, stackTrace) => Container(
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10), // Add some spacing
                // Wrap the Column in an Expanded widget
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '\$${product.price}',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        product.description,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
