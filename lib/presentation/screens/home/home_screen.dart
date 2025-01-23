import 'package:firebase_e_commerce/presentation/widgets/carousel_slider_widget.dart';
import 'package:firebase_e_commerce/presentation/widgets/products_list.dart';
import 'package:firebase_e_commerce/presentation/widgets/shimmer_loading_widget.dart';
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
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
      child: CustomScrollView(slivers: [
        SliverAppBar(
          pinned: false,
          floating: true,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          forceElevated: true,
          toolbarHeight: 65,
          flexibleSpace: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear, color: Colors.grey),
                      onPressed: () {
                        // Clear the search text
                      },
                    ),
                  ),
                  onChanged: (value) {
                    // Handle search input changes
                  },
                ),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate.fixed([
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const ShimmerLoading();
                }
                if (state is ProductSuccess) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      CarouselSliderWidget(carousel: state.carouselModel),
                      const SizedBox(
                        height: 12,
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
                      ProductsList(productModel: state.discountedProducts),
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
          ]),
        ),
        SliverFillRemaining()
      ]),
    );
  }
}
