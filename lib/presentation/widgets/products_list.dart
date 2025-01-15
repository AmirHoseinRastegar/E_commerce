import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../data/model/product_model.dart';
import '../blocs/product/product_bloc.dart';

class ProductsList extends StatefulWidget {
  final List<ProductModel> productModel;
  const ProductsList({super.key,required this.productModel});

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {


  @override
  Widget build(BuildContext context) {



          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: GridView.builder(
                shrinkWrap: true,
                  itemCount: widget.productModel.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    final product = widget.productModel[index];
                    return Container(
                      width: 100,
                      height: 100,
                      margin: const EdgeInsets.all(25),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(product.imageUrl),
                          fit: BoxFit.cover,
                        ),
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
                    );
                  }),
            ),
          );
        }



  }

