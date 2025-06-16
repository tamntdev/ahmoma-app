import 'package:ahmoma_app/utils/constants/app_sizes.dart';
import 'package:ahmoma_app/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class OutlinedButtonWidget extends StatelessWidget {
  const OutlinedButtonWidget({
    super.key,
    required this.btnText,
    this.onPressed,
    this.borderRadius = AppSizes.borderRadiusLg,
  });

  final String btnText;
  final VoidCallback? onPressed;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(minimumSize: Size.fromHeight(50)),
      onPressed: onPressed,
      child: Text(btnText),
    );
  }
}
