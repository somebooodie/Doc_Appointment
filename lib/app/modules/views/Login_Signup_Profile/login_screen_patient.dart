import 'package:doc_appointment/app/config/routes/named_routes.dart';
import 'package:doc_appointment/app/config/theme/my_colors.dart';
import 'package:doc_appointment/app/core/extensions/build_context_extension.dart';
import 'package:doc_appointment/app/modules/auth/domain/providers/state/patient_auth_provider.dart';
import 'package:doc_appointment/app/modules/widgets/doc_register_forms_widgets.dart';
import 'package:doc_appointment/app/modules/widgets/patient_login_forms_widget.dart';
import 'package:doc_appointment/app/modules/widgets/patient_register_forms_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});
  final registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.read(authControllerProvider.notifier);
    final formProvider = ref.watch(authFormController);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: context.screenHeight * 0.03),
            Image.asset(
              'assets/images/Big_logo.png',
              width: context.screenWidth * 0.8,
              height: context.screenHeight * 0.3,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PatientLoginAuthForm(
                    registerFormKey: registerFormKey,
                  ),
                  SizedBox(
                    height: context.screenHeight * 0.02,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (registerFormKey.currentState?.validate() == true) {
                        authController
                            .login(
                          email: formProvider.email,
                          password: formProvider.password,
                        )
                            .then((value) {
                          if (value == true) {
                            GoRouter.of(context)
                                .goNamed(MyNamedRoutes.patientHomeScreen);
                          }
                        });
                      }
                    },
                    child: Text(
                      context.translate.login,
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: MyColors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: MyColors.blue, // Set the background color
                      onPrimary: MyColors.white, // Set the text color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      minimumSize: Size(300, 60), // Set button size
                    ),
                  ),
                  SizedBox(
                    height: context.screenHeight * 0.02,
                  ),
                  TextButton(
                    onPressed: () {
                      GoRouter.of(context)
                          .pushNamed(MyNamedRoutes.patientRegister);
                    },
                    child: Text(
                      context.translate.register,
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: MyColors.primary_500,
                        decoration: TextDecoration.underline,
                        decorationColor: MyColors.blue,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: context.screenHeight * 0.02,
                  ),
                  TextButton(
                    onPressed: () {
                      GoRouter.of(context).goNamed(MyNamedRoutes.doclogin);
                    },
                    child: Text(
                      context.translate.docLogin,
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: MyColors.primary_500,
                        decoration: TextDecoration.underline,
                        decorationColor: MyColors.blue,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
