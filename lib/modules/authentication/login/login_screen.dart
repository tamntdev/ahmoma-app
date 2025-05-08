import 'package:ahmoma_app/data/requests/login_request.dart';
import 'package:ahmoma_app/modules/authentication/cubit/auth_cubit.dart';
import 'package:ahmoma_app/modules/authentication/cubit/auth_state.dart';
import 'package:ahmoma_app/modules/live_tracking_screen.dart';
import 'package:ahmoma_app/utils/constants/app_sizes.dart';
import 'package:ahmoma_app/utils/constants/enums.dart';
import 'package:ahmoma_app/utils/constants/image_string.dart';

import 'package:ahmoma_app/utils/helpers/function_helper.dart';
import 'package:ahmoma_app/utils/helpers/spacing_style_helper.dart';
import 'package:ahmoma_app/utils/localization/locale_support.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ahmoma_app/utils/constants/image_strings.dart';
import 'package:ahmoma_app/utils/extensions/context_extension.dart';
import 'package:ahmoma_app/utils/routes/app_routes.dart';
import 'package:ahmoma_app/utils/widgets/loading_widget.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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

    super.initState();
  }

  @override
  void dispose() {
    _authenticationCubit.close();
    _userNameController.dispose();
    _passwordController.dispose();
    _userNameFocusNode.dispose();
    _passwordFocusNode.dispose();

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
            SingleChildScrollView(
              child: Padding(
                padding: AppSpacingStyle.paddingWithAppBarHeight,
                child: Column(
                  children: [
                    Column(
                      children: [
                        // Image.asset(
                        //   darkMode
                        //       ? AppImageStrings.lightAppLogo
                        //       : AppImageStrings.darkAppLogo,
                        //   height: 150,
                        // ),
                        Text(
                          context.locale.login,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: AppSizes.sm),
                        Text(
                          context.locale.welcomeBackToTheApp,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
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
                                prefixIcon: const Icon(Iconsax.user),
                                labelText: context.locale.username,
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
                            BlocBuilder<
                              AuthCubit,
                              AuthState
                            >(
                              builder: (context, state) {
                                return TextFormField(
                                  controller: _passwordController,
                                  textInputAction: TextInputAction.done,
                                  focusNode: _passwordFocusNode,
                                  decoration: InputDecoration(
                                    prefixIcon: const Icon(
                                      Iconsax.password_check,
                                    ),
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
                                      return context.locale.requiredPassword;
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                BlocBuilder<
                                  AuthCubit,
                                  AuthState
                                >(
                                  builder: (context, state) {
                                    return Row(
                                      children: [
                                        Checkbox(
                                          value: _isSelectRemember,
                                          onChanged: (value) {
                                            _authenticationCubit.selectCheckbox(
                                              value!,
                                            );
                                          },
                                        ),
                                        Text(context.locale.rememberMe),
                                      ],
                                    );
                                  },
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(context.locale.forgotPassword),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSizes.spaceBtwSections),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  // if (_formKey.currentState!.validate()) {
                                  //   _authenticationCubit.login(LoginRequest(
                                  //       email: _userNameController.text,
                                  //       password: _passwordController.text));
                                  // }
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => LiveTrackingScreen()));
                                },
                                child: Text(context.locale.signIn),
                              ),
                            ),
                            const SizedBox(height: AppSizes.spaceBtwItems),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.signup,
                                  );
                                },
                                child: Text(context.locale.createAccount),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
