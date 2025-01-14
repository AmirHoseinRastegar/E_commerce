import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_e_commerce/presentation/widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../core/loading.dart';
import '../blocs/carousel/carousel_bloc.dart';
import '../blocs/product/product_bloc.dart';

class CarouselSliderWidget extends StatefulWidget {
  const CarouselSliderWidget({super.key});

  @override
  State<CarouselSliderWidget> createState() => _CarouselSliderWidgetState();
}

class _CarouselSliderWidgetState extends State<CarouselSliderWidget> {
  @override
  void initState() {
    super.initState();
    context.read<CarouselBloc>().add(FetchCarouselEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarouselBloc, CarouselState>(
      builder: (context, state) {
        if (state is CarouseLoading ) {
          return Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.red.shade700, size: 50),
          );
        }
        if (state is CarouselFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
        }
        if (state is CarouseSuccess) {
          return SizedBox(
            width: double.infinity,
            child: CarouselSlider.builder(
              itemCount: state.bannerUrl.length,
              itemBuilder: (context, index, realIndex) {
                return ClipRRect(
                  borderRadius:  BorderRadius.circular(24),
                  child: Image.network(state.bannerUrl[index].bannerImage,
                      fit: BoxFit.fitWidth,),
                );
              },
              options: CarouselOptions(
                enlargeStrategy: CenterPageEnlargeStrategy.scale,
                height: 180.0,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                viewportFraction: 0.8, // Fraction of the viewport to show
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
