import 'package:flutter/material.dart';

import '../../data/model/product_model.dart';
import '../screens/home/prdocut_details_screen.dart';

class AllSpecialsWidget extends StatelessWidget {
  const AllSpecialsWidget({
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
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: Colors.grey[300], // Light grey background
                          child: Center(
                            child: Container(),
                          ),
                        ),
                        // Network Image
                        Image.network(
                          product.imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child; // Image is fully loaded
                            }
                            return const SizedBox
                                .shrink(); // Hide the image until fully loaded
                          },
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            color: Colors.red,
                            width: double.infinity,
                            height: double.infinity,
                            child: const Icon(Icons.error, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
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
                        '\$${(product.price - product.discount).toStringAsFixed(2)}',
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
