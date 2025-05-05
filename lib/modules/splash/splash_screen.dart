import 'package:ahmoma_app/modules/splash/splash_cubit/splash_cubit.dart';
import 'package:ahmoma_app/modules/splash/splash_cubit/splash_state.dart';
import 'package:ahmoma_app/utils/constants/colors.dart';
import 'package:ahmoma_app/utils/constants/image_string.dart';
import 'package:ahmoma_app/utils/helpers/function_helper.dart';
import 'package:ahmoma_app/utils/local_storage/app_local_storages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        if(state.isSplashDone == true && state.isSigned) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.main, (route) => false,
            );
          } else {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.login, (route) => false,
            );
          }
      },
      child: Scaffold(
        backgroundColor: isDarkMode ? AppColors.black : AppColors.white,
        body: Center(
          // child: Image.asset(
          //   isDarkMode ?
          //   AppImageStrings.lightAppLogo :
          //   AppImageStrings.darkAppLogo,
          // ),
          child: Text('logo'),
        ),
      ),
    );
  }
}
