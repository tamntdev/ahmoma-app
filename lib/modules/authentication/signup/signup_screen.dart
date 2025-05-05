import 'package:ahmoma_app/data/requests/signup_request.dart';
import 'package:ahmoma_app/modules/authentication/cubit/auth_cubit.dart';
import 'package:ahmoma_app/modules/authentication/cubit/auth_state.dart';
import 'package:ahmoma_app/utils/constants/app_sizes.dart';
import 'package:ahmoma_app/utils/constants/colors.dart';
import 'package:ahmoma_app/utils/extensions/context_extension.dart';
import 'package:ahmoma_app/utils/helpers/function_helper.dart';
import 'package:ahmoma_app/utils/routes/app_routes.dart';
import 'package:ahmoma_app/utils/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late AuthCubit _authenticationCubit;
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _passwordNameController = TextEditingController();
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
    _firstNameController.dispose();
    _lastNameController.dispose();
    _userNameController.dispose();
    _passwordNameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = AppHelperFunctions.isDarkMode(context);

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          context.showSuccess('context.locale.signUpSuccess');
          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
        }

        if (state is SignUpFailure) {
          context.showError('context.locale.signUpFailed');
        }

        if (state is ShowPassword) {
          setState(() {
            _obscureText = state.isShowPassword;
          });
        }

        if(state is SelectCheckbox) {
          setState(() {
            _isSelectRemember = state.isSelectRemember;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.defaultSpace),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'context.locale.letCreateYourAccount',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: AppSizes.spaceBtwSections),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _firstNameController,
                                  expands: false,
                                  decoration: InputDecoration(
                                    labelText: 'context.locale.firstName',
                                    prefixIcon: const Icon(Iconsax.user),
                                  ),
                                ),
                              ),
                              const SizedBox(width: AppSizes.spaceBtwInputFields),
                              Expanded(
                                child: TextFormField(
                                  controller: _lastNameController,
                                  expands: false,
                                  decoration: InputDecoration(
                                    labelText: 'context.locale.lastName',
                                    prefixIcon: const Icon(Iconsax.user),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          /// user name
                          const SizedBox(height: AppSizes.spaceBtwInputFields),
                          TextFormField(
                            controller: _userNameController,
                            expands: false,
                            decoration: InputDecoration(
                              labelText: 'context.locale.username',
                              prefixIcon: const Icon(Iconsax.user_edit),
                            ),
                          ),

                          /// Email
                          // const SizedBox(
                          //   height: AppSizes.spaceBtwInputFields,
                          // ),
                          // TextFormField(
                          //   expands: false,
                          //   decoration: const InputDecoration(
                          //     labelText: AppTexts.email,
                          //     prefixIcon: Icon(Iconsax.direct),
                          //   ),
                          // ),

                          /// Phone number
                          // const SizedBox(
                          //   height: AppSizes.spaceBtwInputFields,
                          // ),
                          // TextFormField(
                          //   expands: false,
                          //   decoration: const InputDecoration(
                          //     labelText: AppTexts.phoneNo,
                          //     prefixIcon: Icon(Iconsax.call),
                          //   ),
                          // ),

                          /// Password
                          const SizedBox(height: AppSizes.spaceBtwInputFields),
                          TextFormField(
                            controller: _passwordNameController,
                            expands: false,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              labelText: 'context.locale.password',
                              prefixIcon: const Icon(Iconsax.password_check),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  _authenticationCubit.showPassword(!_obscureText);
                                },
                                icon: Icon(_obscureText
                                    ? Iconsax.eye
                                    : Iconsax.eye_slash),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: AppSizes.spaceBtwSections,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 24,
                          height: 24,
                          child: BlocBuilder<AuthCubit, AuthState>(
                            builder: (context, state) {
                              return Checkbox(
                                value: _isSelectRemember,
                                onChanged: (value) {
                                  _authenticationCubit.selectCheckbox(value!);
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: AppSizes.spaceBtwItems),
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '${'context.locale.iAgreeTo'} ',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                TextSpan(
                                  text: 'context.locale.privacyPolicy',
                                  style: Theme.of(context).textTheme.bodyMedium!.apply(
                                    color: isDarkMode ? AppColors.white : AppColors.primary,
                                    decoration: TextDecoration.underline,
                                    decorationColor: isDarkMode ? AppColors.white : AppColors.primary,
                                  ),
                                ),
                                TextSpan(
                                  text: ' ${'context.locale.and'} ',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                TextSpan(
                                  text: 'context.locale.termOfUse',
                                  style: Theme.of(context).textTheme.bodyMedium!.apply(
                                    color: isDarkMode ? AppColors.white : AppColors.primary,
                                    decoration: TextDecoration.underline,
                                    decorationColor: isDarkMode ? AppColors.white : AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSizes.spaceBtwSections),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _authenticationCubit.signUp(
                              SignUpRequest(
                                  _userNameController.text,
                                  _passwordNameController.text,
                                  '${_firstNameController.text} ${_lastNameController.text}'),
                            );
                          }
                        },
                        child: Text('context.locale.createAccount'),
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
                  child: LoadingWidget(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
