import 'package:firebase_e_commerce/presentation/blocs/product/product_bloc.dart';
import 'package:firebase_e_commerce/presentation/widgets/all_specials_widget.dart';
import 'package:firebase_e_commerce/presentation/widgets/shimmer_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpecialOffersScreen extends StatefulWidget {
  static const screenRout = '/special_offers_screen';
  const SpecialOffersScreen({super.key});

  @override
  State<SpecialOffersScreen> createState() => _SpecialOffersScreenState();
}

class _SpecialOffersScreenState extends State<SpecialOffersScreen> {
  @override
  initState() {
    super.initState();
    context.read<ProductBloc>().add(FetchProductEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<ProductBloc, ProductState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is ProductLoading) {
                return const Center(child: ShimmerLoading());
              }
              if (state is ProductSuccess) {
                return ListView.builder(
                    itemCount: state.discountedProducts.length,
                    itemBuilder: (context, index) {
                      final product = state.discountedProducts[index];
                      return AllSpecialsWidget(
                       product: product ,);
                    });
              }
              if (state is ProductFailed) {
                return Center(
                  child: Text(state.message),
                );
              }
              if (state is ProductFailed) {
                return Center(
                  child: Text(state.message),
                );
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }
}
