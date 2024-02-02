import 'package:doc_appointment/app/config/routes/named_routes.dart';
import 'package:doc_appointment/app/config/theme/my_colors.dart';
import 'package:doc_appointment/app/core/extensions/build_context_extension.dart';
import 'package:doc_appointment/app/modules/auth/domain/providers/state/auth_provider.dart';
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
      appBar: AppBar(
        backgroundColor: MyColors.primary_500,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(context.translate.patientlogin,
            style: context.textTheme.headlineMedium
                ?.copyWith(fontSize: 16, color: MyColors.white)),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PatientLoginAuthForm(
              registerFormKey: registerFormKey,
            ),
            SizedBox(
              height: context.screenHeight * 0.04,
            ),
            ElevatedButton(
              onPressed: () {
                if (registerFormKey.currentState?.validate() == true) {
                  authController
                      .login(
                          email: formProvider.email,
                          //  userName: formProvider.userName,
                          password: formProvider.password)
                      .then((value) {
                    if (value == true) {
                      GoRouter.of(context)
                          .goNamed(MyNamedRoutes.patientHomeScreen);
                    }
                  });
                  // sign up router will be here)
                  //GoRouter.of(context).goNamed(MyNamedRoutes.homepage);
                }
                //GoRouter.of(context).goNamed(MyNamedRoutes.login);
              },
              child: Text(context.translate.login,
                  style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: MyColors.primary_500)),
            ),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).pushNamed(MyNamedRoutes.patientRegister);
              },
              child: Text(context.translate.register,
                  style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: MyColors.primary_500)),
            ),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).goNamed(MyNamedRoutes.doclogin);
              },
              child: Text(context.translate.docLogin,
                  style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: MyColors.primary_500)),
            ),
          ],
        ),
      ),
    );
  }
}
