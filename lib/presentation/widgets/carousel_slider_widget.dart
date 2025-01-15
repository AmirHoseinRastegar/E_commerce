import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_e_commerce/presentation/widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../core/loading.dart';
import '../../data/model/carousel_model.dart';
import '../blocs/carousel/carousel_bloc.dart';
import '../blocs/product/product_bloc.dart';

class CarouselSliderWidget extends StatefulWidget {
  final List<CarouselModel> carousel;

  const CarouselSliderWidget({super.key, required this.carousel});

  @override
  State<CarouselSliderWidget> createState() => _CarouselSliderWidgetState();
}

class _CarouselSliderWidgetState extends State<CarouselSliderWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
            itemCount: widget.carousel.length,
            itemBuilder: (context, index, realIndex) {
              return Container(
                decoration:  BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.network(widget.carousel[index].bannerImage,fit: BoxFit.cover,),
              );
            },
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
            ))
      ],
    );
  }
}
