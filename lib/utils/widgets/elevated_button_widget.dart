import 'package:ahmoma_app/utils/constants/app_sizes.dart';
import 'package:ahmoma_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  const ElevatedButtonWidget({
    super.key,
    required this.btnText,
    this.onPressed,
    this.borderRadius = AppSizes.borderRadiusLg
  });

  final String btnText;
  final VoidCallback? onPressed;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primary1],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(borderRadius!),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
          ),
          backgroundColor: Colors.transparent,
          side: BorderSide.none,
        ),
        onPressed: onPressed,
        child: Text(
          btnText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: AppSizes.fontSizeMd,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}