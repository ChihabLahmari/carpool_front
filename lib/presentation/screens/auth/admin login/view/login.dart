import 'package:carpool/app/localizations.dart';
import 'package:carpool/presentation/components/appsize.dart';
import 'package:carpool/presentation/components/assets_manager.dart';
import 'package:carpool/presentation/components/color_manager.dart';
import 'package:carpool/presentation/components/strings_manager.dart';
import 'package:carpool/presentation/components/widgets.dart';
import 'package:carpool/presentation/screens/auth/admin%20login/cubit/login_cubit.dart';
import 'package:carpool/presentation/screens/auth/admin%20login/cubit/login_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminLoginView extends StatelessWidget {
  const AdminLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminLoginCubit(),
      child: BlocConsumer<AdminLoginCubit, AdminLoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AdminLoginCubit.get(context);

          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              bottomOpacity: 0,
              scrolledUnderElevation: 0,
            ),
            backgroundColor: ColorManager.white,
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(AppPadding.p18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: AppSize.s80),
                      SizedBox(
                        width: AppSize.s350,
                        child: Image.asset(ImageAsset.login),
                      ),
                      SizedBox(height: AppSize.s80),
                      CustomFormField(
                        textEditingcontroller: cubit.phoneNumberController,
                        label: AppStrings.phoneNumber.tr(context),
                        keyboardType: TextInputType.phone,
                        errorLabel: cubit.phoneNumberErrorMessage,
                        onChanged: (value) {
                          cubit.isPhoneNumberValid(context);
                        },
                        icon: null,
                      ),
                      SizedBox(height: AppSize.s20),
                      CustomPasswordFormField(
                        textEditingcontroller: cubit.passwordController,
                        label: AppStrings.password.tr(context),
                        errorLabel: null,
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (value) {
                          cubit.passwordChanged();
                        },
                        onVisibleChanged: () {
                          cubit.changePasswordVisibility();
                        },
                        isPasswordVisible: cubit.isPasswordVisible,
                      ),
                      SizedBox(height: AppSize.s20),
                      state is AdminLoginLoadingState
                          ? CircularProgressIndicator(
                              color: ColorManager.yellow,
                            )
                          : CustomLargeButton(
                              label: AppStrings.login.tr(context),
                              onPressed: cubit.phoneNumberValid && cubit.passwordController.text.isNotEmpty
                                  ? () {
                                      cubit.login(context, false);
                                    }
                                  : null,
                            ),
                      SizedBox(height: AppSize.s20),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
