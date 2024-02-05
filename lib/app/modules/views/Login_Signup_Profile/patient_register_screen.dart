import 'package:doc_appointment/app/config/routes/named_routes.dart';
import 'package:doc_appointment/app/config/theme/my_colors.dart';
import 'package:doc_appointment/app/core/extensions/build_context_extension.dart';
import 'package:doc_appointment/app/modules/auth/domain/providers/state/patient_auth_provider.dart';
import 'package:doc_appointment/app/modules/widgets/doc_register_forms_widgets.dart';
import 'package:doc_appointment/app/modules/widgets/patient_register_forms_widget.dart';
import 'package:doc_appointment/app/modules/auth/domain/providers/controller/patient_authform_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PatientRegisterScreen extends ConsumerWidget {
  PatientRegisterScreen({super.key});
  final registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.read(authControllerProvider.notifier);
    final formProvider = ref.watch(authFormController);

    return Scaffold(
      body: Column(
        children: [
          // Adjust the height of the image asset to fill the top part
          Expanded(
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(
                'assets/images/Big_logo.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Smaller and less spaced-out cards
          Container(
            padding: EdgeInsets.all(16.0),
            child: PatientRegisterAuthForm(
              registerFormKey: registerFormKey,
            ),
          ),
          SizedBox(height: context.screenHeight * 0.02), // Adjust spacing
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (registerFormKey.currentState?.validate() == true) {
                  authController.patientregister(
                    email: formProvider.email,
                    userName: formProvider.userName,
                    password: formProvider.password,
                  );
                  // sign up router will be here
                  GoRouter.of(context).goNamed(MyNamedRoutes.patientlogin);
                }
              },
              child: Text(
                context.translate.login,
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: MyColors.blue,
                ),
              ),
            ),
          ),
          SizedBox(height: context.screenHeight * 0.02), // Adjust spacing
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: TextButton(
              onPressed: () {
                GoRouter.of(context).pushNamed(MyNamedRoutes.docRegister);
              },
              child: Text(
                "Switch to Doctor",
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: MyColors.primary_500,
                  decoration: TextDecoration.underline,
                  decorationColor: MyColors.blue,
                ),
              ),
            ),
          ),
          SizedBox(height: context.screenHeight * 0.02), // Adjust spacing
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: TextButton(
              onPressed: () {
                GoRouter.of(context).goNamed(MyNamedRoutes.patientlogin);
              },
              child: Text(
                "Already have an account? Login",
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: MyColors.primary_500,
                  decoration: TextDecoration.underline,
                  decorationColor: MyColors.blue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
