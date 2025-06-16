import 'package:ahmoma_app/modules/splash/splash_cubit/splash_cubit.dart';
import 'package:ahmoma_app/modules/splash/splash_cubit/splash_state.dart';
import 'package:ahmoma_app/utils/constants/app_sizes.dart';
import 'package:ahmoma_app/utils/constants/colors.dart';
import 'package:ahmoma_app/utils/constants/image_string.dart';
import 'package:ahmoma_app/utils/helpers/function_helper.dart';
import 'package:ahmoma_app/utils/local_storage/app_local_storages.dart';
import 'package:ahmoma_app/utils/localization/locale_support.dart';
import 'package:ahmoma_app/utils/widgets/elevated_button_widget.dart';
import 'package:ahmoma_app/utils/widgets/outlined_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SplashCubit _splashCubit;

  @override
  void initState() {
    _splashCubit = context.read<SplashCubit>();
    _splashCubit.checkLoadSplashDone();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = AppHelperFunctions.isDarkMode(context);

    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state.isSplashDone == true && state.isSigned) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.main,
            (route) => false,
          );
        } else {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.login,
            (route) => false,
          );
        }
      },
      child: Scaffold(
        backgroundColor: isDarkMode ? AppColors.black : AppColors.white,
        body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.sm,
            vertical: AppSizes.md,
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SvgPicture.asset(
                  isDarkMode
                      ? AppImageStrings.lightAppLogo
                      : AppImageStrings.darkAppLogo,
                ),
              ),

              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: AppSizes.md),
                child: Column(
                  children: [
                    Text(
                      context.locale.appName,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 45,
                      ),
                    ),
                    Text(
                      context.locale.makingItEasyForYou,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(fontSize: 20),
                    ),
                    ElevatedButtonWidget(
                      btnText: context.locale.login,
                      onPressed: () {},
                    ),
                    OutlinedButtonWidget(
                      btnText: context.locale.createAccount,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
