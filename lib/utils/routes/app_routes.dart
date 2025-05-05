import 'package:ahmoma_app/modules/authentication/cubit/auth_cubit.dart';
import 'package:ahmoma_app/modules/authentication/login/login_screen.dart';
import 'package:ahmoma_app/modules/authentication/signup/signup_screen.dart';
import 'package:ahmoma_app/modules/home/home_screen.dart';
import 'package:ahmoma_app/modules/splash/splash_cubit/splash_cubit.dart';
import 'package:ahmoma_app/modules/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoutes {
  static const String splash = "/splash";
  static const String login = "/login";
  static const String signup = "/signup";
  static const String forgotPassword = "/resetPassword";
  static const String main = "/main";
  static const String home = "/home";
  static const String food = "/food";
  static const String orderFood = "/orderFood";
  static const String orderHistory = "/orderHistory";

  static MaterialPageRoute onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) {
        switch (settings.name) {
          case AppRoutes.splash:
            return BlocProvider(
              create: (_) => SplashCubit(),
              child: const SplashScreen(),
            );
          case AppRoutes.login:
            return BlocProvider(
              create: (context) => AuthCubit(),
              child: const LoginScreen(),
            );
        case AppRoutes.main:
          return MultiBlocProvider(
            providers: [
              // BlocProvider<NavigationMenuCubit>(
              //   create: (BuildContext context) => NavigationMenuCubit(),
              // ),
              // BlocProvider<OrderHistoryCubit>(
              //   create: (BuildContext context) => OrderHistoryCubit(),
              // ),
              // BlocProvider<HomeCubit>(
              //   create: (BuildContext context) => HomeCubit(),
              // ),
              BlocProvider<AuthCubit>(
                create: (BuildContext context) => AuthCubit(),
              ),
            ],
            child: const HomeScreen(),
          );
          case AppRoutes.signup:
            return BlocProvider(
              create: (context) => AuthCubit(),
              child: const SignupScreen(),
            );
        // case AppRoutes.forgotPassword:
        //   return const ForgotPasswordScreen();
        // case AppRoutes.food:
        //   return BlocProvider(
        //     create: (context) => FoodCubit(),
        //     child: const FoodScreen(),
        //   );
        // case AppRoutes.orderHistory:
        //   return BlocProvider(
        //     create: (context) => OrderHistoryCubit(),
        //     child: const OrderHistoryScreen(),
        //   );
          default:
            return const SizedBox();
        }
      },
    );
  }

// static goToPhotoViewPage(BuildContext context, List photos, {int index = 0}) {
//   Navigator.of(context).push(
//     MaterialPageRoute(
//       builder: (_) => PhotoViewerPage(
//         photos: photos,
//         index: index,
//       ),
//     ),
//   );
// }
}