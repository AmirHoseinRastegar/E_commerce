import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/cart_model.dart';
import '../../../data/model/receipt_model.dart';
import '../../blocs/cart/cart_bloc.dart';
import '../../blocs/receipt/receipt_bloc.dart';
import '../../widgets/cart_items.dart';
import '../receipt/receipt_screen.dart';

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
    context
        .read<CartBloc>()
        .add(LoadCartItems(userId: FirebaseAuth.instance.currentUser!.uid));
  }

  void _createReceipt(List<CartModel> cartItems) {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final receiptItems = cartItems
        .map((item) => ReceiptItemModel(
              productId: item.productId!,
              name: item.name!,
              imageUrl: item.imageUrl!,
              price: item.price!,
              quantity: item.quantity!,
            ))
        .toList();

    final totalAmount = cartItems.fold<double>(
      0,
      (sum, item) => sum + (item.price! * item.quantity!),
    );

    final receipt = ReceiptModel(
      id: '', // Will be set by Firestore
      userId: userId,
      items: receiptItems,
      totalAmount: totalAmount,
      date: DateTime.now(),
      status: 'pending',
    );

    context.read<ReceiptBloc>().add(CreateReceipt(receipt));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReceiptBloc, ReceiptState>(
      listener: (context, state) {
        if (state is ReceiptCreated) {
          // Clear cart after successful receipt creation
          context.read<CartBloc>().add(
                ClearCart(userId: FirebaseAuth.instance.currentUser!.uid),
              );
          // Navigate to receipt screen
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ReceiptScreen(receiptId: state.receipt.id),
            ),
          );
        }
      },
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is CartSuccess) {
            final cartItems = state.cartItems;
            return cartItems.isEmpty
                ? const Center(
                    child: Text(
                      'No Products in Your Cart',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.cartItems.length,
                          itemBuilder: (context, index) {
                            return CartItem(
                              cartItem: cartItems[index],
                              callback: () {
                                context.read<CartBloc>().add(
                                      RemoveCartItems(
                                        userId: FirebaseAuth
                                            .instance.currentUser!.uid,
                                        productId: cartItems[index].productId,
                                      ),
                                    );
                              },
                              onDecreaseClicked: () {
                                if (cartItems[index].quantity > 1) {
                                  context.read<CartBloc>().add(
                                        UpdateCartItems(
                                          userId: FirebaseAuth
                                              .instance.currentUser!.uid,
                                          productId: cartItems[index].productId,
                                          newQuantity:
                                              cartItems[index].quantity - 1,
                                        ),
                                      );
                                } else if (cartItems[index].quantity == 1) {
                                  context.read<CartBloc>().add(RemoveCartItems(
                                      userId: FirebaseAuth
                                          .instance.currentUser!.uid,
                                      productId: cartItems[index].productId));
                                }
                              },
                              onIncreaseClicked: () {
                                context.read<CartBloc>().add(
                                      UpdateCartItems(
                                        userId: FirebaseAuth
                                            .instance.currentUser!.uid,
                                        productId: cartItems[index].productId,
                                        newQuantity:
                                            cartItems[index].quantity + 1,
                                      ),
                                    );
                              },
                            );
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, -2),
                            ),
                          ],
                        ),
                        child: SafeArea(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Total:',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '\$${cartItems.fold<double>(0, (sum, item) => sum + (item.price! * item.quantity!)).toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () => _createReceipt(cartItems),
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    foregroundColor: Colors.white,
                                  ),
                                  child: const Text(
                                    'Checkout',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
          }
          return Container();
        },
      ),
    );
  }
}
