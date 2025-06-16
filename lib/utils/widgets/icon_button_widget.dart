import 'package:ahmoma_app/utils/constants/app_sizes.dart';
import 'package:ahmoma_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  const IconButtonWidget({
    super.key,
    required this.btnText,
    this.onPressed,
    this.borderRadius = AppSizes.borderRadiusLg,
    this.icon,
  });

  final String? btnText;
  final VoidCallback? onPressed;
  final double? borderRadius;
  final Widget? icon;

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
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
          ),
          backgroundColor: Colors.transparent,
          side: BorderSide.none,
        ),
        onPressed: onPressed,
        icon: icon,
        label: Text(
          btnText ?? "",
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
