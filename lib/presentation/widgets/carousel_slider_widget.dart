import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../data/model/carousel_model.dart';

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
              return ClipRRect(

                  borderRadius: BorderRadius.circular(15),
                  child: CachedNetworkImage(

                    fit: BoxFit.cover,
                    imageUrl: widget.carousel[index].bannerImage,
                  ));
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
