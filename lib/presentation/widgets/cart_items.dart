import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/model/cart_model.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.callback,
    required this.cartItem,
    required this.onDecreaseClicked,
    required this.onIncreaseClicked,
  });

  final GestureTapCallback onDecreaseClicked;
  final GestureTapCallback onIncreaseClicked;
  final GestureTapCallback callback;
  final CartModel cartItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.07)),
          ]),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: CachedNetworkImage(
                    imageUrl: cartItem.imageUrl,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      cartItem.name,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Quantity'),
                    Row(
                      children: [
                        Row(
                          children: [
                            IconButton(
                                onPressed: onIncreaseClicked,
                                icon: Icon(
                                  CupertinoIcons.plus_rectangle,
                                  color: Colors.black.withOpacity(0.7),
                                )),
                            Text(
                              cartItem.quantity.toString(),
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            IconButton(
                                onPressed: onDecreaseClicked,
                                icon: Icon(
                                  CupertinoIcons.minus_rectangle,
                                  color: Colors.black.withOpacity(0.7),
                                )),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${cartItem.price * cartItem.quantity}',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.titleLarge?.color,
                          fontSize: 15,
                          decorationColor: Colors.black.withOpacity(0.55),
                          decoration: cartItem.discount != 0
                              ? TextDecoration.lineThrough
                              : TextDecoration.none),
                    ),
                    Text(
                      cartItem.discount != 0
                          ? '${(cartItem.price - cartItem.discount) * cartItem.quantity}'
                          : '',
                    ),
                  ],
                )
              ],
            ),
          ),
          Divider(
            color: Colors.grey.withOpacity(0.3),
            height: 1,
          ),
          TextButton(
            onPressed: callback,
            child: const Text('Remove from cart'),
          ),
        ],
      ),
    );
  }
}
