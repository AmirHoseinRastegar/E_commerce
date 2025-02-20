import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_e_commerce/core/media_query.dart';
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
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          CarouselSlider.builder(
              itemCount: widget.carousel.length,
              itemBuilder: (context, index, realIndex) {
                return Container(
                  width: getAllWidth(context),
                  margin: const EdgeInsets.all(10), // Add some margin around the container
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1), // Shadow color
                        spreadRadius: 2, // Spread radius
                        blurRadius: 5, // Blur radius
                        offset: const Offset(0, 3), // Shadow position
                      ),
                    ],),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: widget.carousel[index].bannerImage,
                      )),
                );
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
      ),
    );
  }
}
