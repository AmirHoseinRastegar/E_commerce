import 'package:firebase_e_commerce/presentation/widgets/carousel_slider_widget.dart';
import 'package:firebase_e_commerce/presentation/widgets/discounted_products_widget.dart';
import 'package:firebase_e_commerce/presentation/widgets/loading_screen.dart';
import 'package:firebase_e_commerce/presentation/widgets/products_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/product/product_bloc.dart';

class HomeScreen extends StatefulWidget {
  static const screenRout = 'home_screen';

  static rout() => MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(FetchProductEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Scaffold(
        appBar: AppBar(
          title: Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const TextField(
              decoration: InputDecoration(
                hintText: "Search",
              ),
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return const Loader();
              }
              if (state is ProductSuccess) {
                return Column(
                  children: [
                    CarouselSliderWidget(
                      carousel: state.carouselModel,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Special Offers',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('See All'),
                          ),
                        ],
                      ),
                    ),
                    ProductsList(
                        productModel: state.discountedProducts),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Products',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('See All'),
                          ),
                        ],
                      ),
                    ),
                    ProductsList(productModel: state.productModel),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
