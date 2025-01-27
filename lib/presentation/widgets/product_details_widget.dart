import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_e_commerce/core/media_query.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/product_model.dart';
import '../blocs/product_details/product_details_bloc.dart';
import '../screens/home/prdocut_details_screen.dart';

class ProductDetailsWidget extends StatelessWidget {
  const ProductDetailsWidget({
    super.key,
    required this.product,
    required this.widget,
  });

  final ProductModel product;
  final ProductDetailsScreen widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CachedNetworkImage(
          imageUrl: product.imageUrl,
          placeholder: (context, url) =>
          const CircularProgressIndicator(),
          errorWidget: (context, url, error) => IconButton(
              onPressed: () => context
                  .read<ProductDetailsBloc>()
                  .add(FetchProductDetails(id: widget.id)),
              icon: const Icon(Icons.refresh)),
        ),
        const SizedBox(height: 16),
        Text(
          product.name,
          style: const TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          '\$${product.price}',
          style:
          const TextStyle(fontSize: 20, color: Colors.green),
        ),
        const SizedBox(height: 16),
        Text(
          product.description,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 16),
        Text(
          'Category: ${product.category}',
          style: const TextStyle(fontSize: 16),
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(getWidth(context, 0.8), 50)
            ),
            onPressed: (){}, child: const Text(
          'Add to cart',
        )),
      ],
    );
  }
}
