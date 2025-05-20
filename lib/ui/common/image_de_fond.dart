import 'package:flutter/material.dart';

class ImageFondEcran extends StatelessWidget {
  const ImageFondEcran({super.key});

  static const String imagePath = 'assets/images/photo_home_page.jpg';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImageFondEcran.imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}