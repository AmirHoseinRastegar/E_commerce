import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_e_commerce/core/media_query.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/cart_model.dart';
import '../../data/model/product_model.dart';
import '../blocs/cart/cart_bloc.dart';
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
        Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 15,
              offset: const Offset(5, 5),
            ),
          ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
              imageUrl: product.imageUrl,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => IconButton(
                  onPressed: () => context
                      .read<ProductDetailsBloc>()
                      .add(FetchProductDetails(id: widget.id)),
                  icon: const Icon(Icons.refresh)),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          product.name,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          '\$${product.price}',
          style: const TextStyle(fontSize: 20, color: Colors.green),
        ),
        const SizedBox(height: 16),
        Text(
          product.description,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 30),
        Text(
          'Category: ${product.category}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(20),
          child: BlocConsumer<CartBloc, CartState>(
            listener: (context, state) {
              if (state is AddToCartButtonSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Added to cart')));
              }
            },
            builder: (context, state) {
              if (state is CartLoading) {
                return const CupertinoActivityIndicator();
              }

              return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                    shadowColor: Colors.red.shade700,
                    backgroundColor: Colors.red.shade700,
                    minimumSize: Size(getWidth(context, 0.8), 50),
                  ),
                  onPressed: () {
                    final cartItem = CartModel(
                      productId: product.id,
                      quantity: 1,
                      name: product.name,
                      price: product.price.toDouble(),
                      imageUrl: product.imageUrl,
                    );
                    context.read<CartBloc>().add(AddCartItems(
                        cartItem: cartItem,
                        userId: FirebaseAuth.instance.currentUser!.uid));
                  },
                  child: const Text(
                    'Add to cart',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  ));
            },
          ),
        ),
      ],
    );
  }
}
