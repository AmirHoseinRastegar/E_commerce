import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/cart/cart_bloc.dart';

class CartScreen extends StatefulWidget {
  static const screenRout = '/';

  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
@override
  void initState() {
    super.initState();
    context.read<CartBloc>().add(LoadCartItems(userId: FirebaseAuth.instance.currentUser!.uid));
  }

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    print(FirebaseAuth.instance.currentUser?.uid);

    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is CartSuccess) {
          final cartItems = state.cartItems;
          return ListView.builder(
            itemCount: state.cartItems.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: Container(
                  width: 100,
                  height: 250,
                  margin: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(2, 0),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      fit: BoxFit.fitHeight,
                      imageUrl: cartItems[index].imageUrl,
                    ),
                  ),
                ),
              );
              ;
            },
          );
        }
        return Container();
      },
    );
  }
}
