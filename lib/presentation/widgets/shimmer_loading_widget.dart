import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/media_query.dart';


class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: getWidth(context, 0.95),
                height: 125,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:BorderRadius.circular(15),
                ),
              ),
              const SizedBox(height: 10),
              const Wrap(
                children: [
                  LittleShimmer(),
                  LittleShimmer(),
                  LittleShimmer(),
                  LittleShimmer(),
                  LittleShimmer(),
                  LittleShimmer(),
                  LittleShimmer(),
                  LittleShimmer(),
                  LittleShimmer(),
                  LittleShimmer(),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                width: getWidth(context, 0.95),
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:BorderRadius.circular(15),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: getWidth(context, 0.95),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:BorderRadius.circular(15),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: getWidth(context, 0.95),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LittleShimmer extends StatelessWidget {
  const LittleShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(getWidth(context, 0.02)),
      width: getWidth(context, 0.15),
      height: getWidth(context, 0.15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}