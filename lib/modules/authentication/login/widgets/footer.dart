import 'package:ahmoma_app/utils/constants/app_sizes.dart';
import 'package:ahmoma_app/utils/constants/image_string.dart';
import 'package:ahmoma_app/utils/localization/locale_support.dart';
import 'package:ahmoma_app/utils/widgets/social_button_widget.dart';
import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.spaceBtwSections),
      child: Column(
        children: [
          Text(context.locale.or),
          SizedBox(height: AppSizes.spaceBtwItems),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SocialButtonWidget(
                image: AppImageStrings.googleLogo,
                onPressed: () {},
              ),
              SocialButtonWidget(
                image: AppImageStrings.facebookLogo,
                onPressed: () {},
              ),
              SocialButtonWidget(
                image: AppImageStrings.appleLogo,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
