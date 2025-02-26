
import 'package:firebase_e_commerce/presentation/blocs/product_details/product_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/product_details_widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const screenRout = '/product_details_screen';
  final String id;

  const ProductDetailsScreen({super.key, required this.id});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductDetailsBloc>().add(FetchProductDetails(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Product Details'),
          ),
          body: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
            builder: (context, state) {
              if (state is ProductDetailsLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is ProductDetailsError) {
                return Center(child: Text(state.message));
              }

              if (state is ProductDetailsSuccess) {
                final product = state.product;
                return Padding(
                  padding: const EdgeInsets.all(16.0).copyWith(bottom: 0),
                  child: ProductDetailsWidget(product: product, widget: widget),
                );
              }

              return Container();
            },
          ),
        );
      },
    );
  }
}

