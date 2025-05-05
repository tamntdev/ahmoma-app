import 'package:ahmoma_app/utils/constants/colors.dart';
import 'package:flutter/cupertino.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.bgColor});

  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor ?? const Color.fromARGB(100, 0, 0, 0),
      ),
      child: Center(
        child: CupertinoActivityIndicator(color: AppColors.primary),
      ),
    );
  }
}
