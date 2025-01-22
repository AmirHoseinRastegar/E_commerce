import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../data/model/carousel_model.dart';

class CarouselSliderWidget extends StatefulWidget {
  final List<CarouselModel> carousel;

  const CarouselSliderWidget({super.key, required this.carousel});

  @override
  State<CarouselSliderWidget> createState() => _CarouselSliderWidgetState();
}

class _CarouselSliderWidgetState extends State<CarouselSliderWidget> {
  CarouselSliderController carouselController = CarouselSliderController();
  int currentIndex = 0;

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
                    fit: BoxFit.fill,
                    imageUrl: widget.carousel[index].bannerImage,
                  ));
            },
            options: CarouselOptions(
              initialPage: 0,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
            )),
        const SizedBox(
          height: 10,
        ),
        AnimatedSmoothIndicator(
          activeIndex: currentIndex,
          count: widget.carousel.length,
          effect: const WormEffect(
              dotHeight: 3,
              type: WormType.normal,
              dotWidth: 15,
              dotColor: Colors.grey,
              activeDotColor: Colors.red),
        )
      ],
    );
  }
}
