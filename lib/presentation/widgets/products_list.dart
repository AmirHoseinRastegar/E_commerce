import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_e_commerce/presentation/screens/home/prdocut_details_screen.dart';
import 'package:flutter/material.dart';
import '../../data/model/product_model.dart';

class ProductsList extends StatefulWidget {
  final List<ProductModel> productModel;

  const ProductsList({super.key, required this.productModel});

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: widget.productModel.length,
        itemBuilder: (context, index) {
          final product = widget.productModel[index];
          return ProductCard(product: product);
        },
      ),
    );
  }

}

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ProductDetailsScreen.screenRout,
            arguments: product.id);
      },
      child: Container(
        width: 100,
        height: 100,
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
            fit: BoxFit.fill,
            imageUrl: product.imageUrl,
          ),
        ),
      ),
    );
  }
}
