import 'package:flutter/material.dart';

class OnboardingWidget extends StatefulWidget {
  final String title;
  final String description;
  final String image;

  const OnboardingWidget({
    super.key,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  State<OnboardingWidget> createState() => _OnboardingWidgetState();
}

class _OnboardingWidgetState extends State<OnboardingWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15)
              ),
              child: Image.asset(

                widget.image,
                fit: BoxFit.cover,
              )),
          const SizedBox(
            height: 15,
          ),
          Text( textAlign: TextAlign.center,
            widget.title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(widget.description,
          textAlign: TextAlign.center,
          style:  TextStyle(
            fontSize: 16,
             fontWeight: FontWeight.w600,
            color:Colors.black.withOpacity(0.74)
          ),),
        ],
      ),
    );
  }
}
