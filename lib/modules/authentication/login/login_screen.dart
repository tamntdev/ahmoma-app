import 'package:ahmoma_app/data/requests/login_request.dart';
import 'package:ahmoma_app/modules/authentication/cubit/auth_cubit.dart';
import 'package:ahmoma_app/modules/authentication/cubit/auth_state.dart';
import 'package:ahmoma_app/modules/authentication/login/widgets/footer.dart';
import 'package:ahmoma_app/modules/live_tracking_screen.dart';
import 'package:ahmoma_app/utils/constants/app_sizes.dart';
import 'package:ahmoma_app/utils/constants/colors.dart';
import 'package:ahmoma_app/utils/constants/enums.dart';
import 'package:ahmoma_app/utils/constants/image_string.dart';
import 'package:ahmoma_app/utils/device_utils/app_device_util.dart';

import 'package:ahmoma_app/utils/helpers/function_helper.dart';
import 'package:ahmoma_app/utils/helpers/spacing_style_helper.dart';
import 'package:ahmoma_app/utils/localization/locale_support.dart';
import 'package:ahmoma_app/utils/widgets/elevated_button_widget.dart';
import 'package:ahmoma_app/utils/widgets/gradient_text.dart';
import 'package:ahmoma_app/utils/widgets/icon_button_widget.dart';
import 'package:ahmoma_app/utils/widgets/radio_button_widget.dart';
import 'package:ahmoma_app/utils/widgets/social_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ahmoma_app/utils/constants/image_strings.dart';
import 'package:ahmoma_app/utils/extensions/context_extension.dart';
import 'package:ahmoma_app/utils/routes/app_routes.dart';
import 'package:ahmoma_app/utils/widgets/loading_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late AuthCubit _authenticationCubit;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _userNameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  bool _obscureText = true;
  bool _isSelectRemember = true;

  @override
  void initState() {
    _authenticationCubit = context.read<AuthCubit>();
    _authenticationCubit.showPassword(false);
    _authenticationCubit.selectCheckbox(true);
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    _authenticationCubit.close();
    _userNameController.dispose();
    _passwordController.dispose();
    _userNameFocusNode.dispose();
    _passwordFocusNode.dispose();
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = AppHelperFunctions.isDarkMode(context);

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          context.showSuccess(context.locale.loginSuccess);
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.main,
            (route) => false,
          );
        }

        if (state is LoginFailure) {
          context.showCustomToast(
            context,
            title: "Info",
            message: "This is a toast",
            type: ToastType.error,
          );
        }

        if (state is ShowPassword) {
          setState(() {
            _obscureText = state.isShowPassword;
          });
        }

        if (state is SelectCheckbox) {
          setState(() {
            _isSelectRemember = state.isSelectRemember;
          });
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: AppDeviceUtils.getScreenWidth(context),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.primary1],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: SvgPicture.asset(
                'assets/images/bg_screen.svg',
                fit: BoxFit.fitWidth,
              ),
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.centerLeft,
                  height: AppDeviceUtils.getScreenHeight(context) * .20,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.locale.login,
                        style: Theme.of(context).textTheme.headlineLarge
                            ?.copyWith(color: AppColors.white),
                      ),
                      const SizedBox(height: AppSizes.sm),
                      Text(
                        context.locale.welcomeBackToTheApp,
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(color: AppColors.white),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      color: AppColors.white,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TabBar(
                            controller: _tabController,
                            onTap: (value) {
                              // awardController.setTabIndex(value);
                            },
                            tabs: [
                              Tab(text: context.locale.email),
                              Tab(text: context.locale.phoneNumber),
                            ],
                          ),
                          Form(
                            key: _formKey,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: AppSizes.spaceBtwSections,
                              ),
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: _userNameController,
                                    focusNode: _userNameFocusNode,
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      // prefixIcon: const Icon(Iconsax.user),
                                      labelText: context.locale.username,
                                      hintText: 'enter your email',
                                      suffixIcon:
                                          _userNameController.text.isNotEmpty
                                              ? IconButton(
                                                onPressed: () {
                                                  _userNameController.clear();
                                                },
                                                icon: Icon(
                                                  CupertinoIcons.clear_circled,
                                                  size: 16,
                                                ),
                                              )
                                              : null,
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        _userNameController.text = value;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return context.locale.requiredUsername;
                                      }

                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: AppSizes.spaceBtwInputFields,
                                  ),
                                  BlocBuilder<AuthCubit, AuthState>(
                                    builder: (context, state) {
                                      return TextFormField(
                                        controller: _passwordController,
                                        textInputAction: TextInputAction.done,
                                        focusNode: _passwordFocusNode,
                                        decoration: InputDecoration(
                                          // prefixIcon: const Icon(
                                          //   Iconsax.password_check,
                                          // ),
                                          hintText: 'enter your password',
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              _authenticationCubit.showPassword(
                                                !_obscureText,
                                              );
                                            },
                                            icon: Icon(
                                              _obscureText
                                                  ? Iconsax.eye
                                                  : Iconsax.eye_slash,
                                            ),
                                          ),
                                          labelText: context.locale.password,
                                        ),
                                        obscureText: _obscureText,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return context
                                                .locale
                                                .requiredPassword;
                                          }

                                          return null;
                                        },
                                      );
                                    },
                                  ),
                                  const SizedBox(
                                    height: AppSizes.spaceBtwInputFields / 2,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      BlocBuilder<AuthCubit, AuthState>(
                                        builder: (context, state) {
                                          return Row(
                                            children: [
                                              Checkbox(
                                                value: _isSelectRemember,
                                                onChanged: (value) {
                                                  _authenticationCubit
                                                      .selectCheckbox(value!);
                                                },
                                              ),
                                              // Text(context.locale.rememberMe),
                                              RichText(
                                                text: TextSpan(
                                                  text:
                                                      '${context.locale.rememberMe}\n',
                                                  style: TextStyle(
                                                    color:
                                                        Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .color,
                                                  ),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text:
                                                          context
                                                              .locale
                                                              .saveMyLogin,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelMedium
                                                          ?.copyWith(
                                                            fontSize: 8,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                      TextButton(
                                        onPressed: () {},
                                        child: GradientText(
                                          style: const TextStyle(
                                            fontSize: AppSizes.fontSizeSm,
                                            decoration:
                                                TextDecoration.underline,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          gradient: LinearGradient(
                                            colors: [
                                              AppColors.primary,
                                              AppColors.primary1,
                                            ],
                                          ),
                                          text: context.locale.forgotPassword,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: AppSizes.spaceBtwSections,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButtonWidget(
                                      onPressed: () async {
                                        // if (_formKey.currentState!.validate()) {
                                        //   _authenticationCubit.login(
                                        //     LoginRequest(
                                        //       email: _userNameController.text,
                                        //       password:
                                        //           _passwordController.text,
                                        //     ),
                                        //   );
                                        // }
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder:
                                        //         (context) => LiveTrackingScreen(),
                                        //   ),
                                        // );
                                        context.showConfirmDialog(title: 'this is title', content: 'this is content', onOk: () {});
                                      },
                                      btnText: context.locale.signIn,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: AppSizes.spaceBtwItems,
                                  ),
                                  // SizedBox(
                                  //   width: double.infinity,
                                  //   child: OutlinedButton(
                                  //     onPressed: () {
                                  //       Navigator.pushNamed(
                                  //         context,
                                  //         AppRoutes.signup,
                                  //       );
                                  //     },
                                  //     child: Text(context.locale.createAccount),
                                  //   ),
                                  // ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(right: 8),
                                        child: Text(
                                          context.locale.dontHaveAccount,
                                          style:
                                              Theme.of(
                                                context,
                                              ).textTheme.bodyLarge,
                                        ),
                                      ),
                                      GradientText(
                                        style: const TextStyle(
                                          fontSize: AppSizes.fontSizeSm,
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        gradient: LinearGradient(
                                          colors: [
                                            AppColors.primary,
                                            AppColors.primary1,
                                          ],
                                        ),
                                        text: context.locale.signUp,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          FooterWidget()
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return Visibility(
                  visible: state is AuthenticationInProgress,
                  child: const LoadingWidget(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
