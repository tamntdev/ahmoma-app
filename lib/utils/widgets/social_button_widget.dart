import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SocialButtonWidget extends StatelessWidget {
  const SocialButtonWidget({super.key, required this.image, this.onPressed});

  final String image;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: SvgPicture.asset(
        image,
      ),
      style: IconButton.styleFrom(
        shape: CircleBorder(),
        side: BorderSide(
          width: 1,
          color: Color(0xFFD0D5DD),
        ),
      ),
    );
  }
}
