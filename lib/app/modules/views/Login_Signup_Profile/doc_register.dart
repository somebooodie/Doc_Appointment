import 'package:doc_appointment/app/config/routes/named_routes.dart';
import 'package:doc_appointment/app/config/theme/my_colors.dart';
import 'package:doc_appointment/app/core/extensions/build_context_extension.dart';
import 'package:doc_appointment/app/modules/auth/domain/providers/state/doc_auth_provider.dart';
import 'package:doc_appointment/app/modules/widgets/doc_register_forms_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DocRegisterScreen extends ConsumerWidget {
  DocRegisterScreen({super.key});
  final registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.read(authControllerProvider.notifier);
    final formProvider = ref.watch(authFormController);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primary_500,
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: Text(
          context.translate.docRegister,
          style: context.textTheme.headlineMedium
              ?.copyWith(fontSize: 16, color: MyColors.white),
        ),
      ),
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
            child: DocRegisterAuthForm(
              registerFormKey: registerFormKey,
            ),
          ),
          SizedBox(height: context.screenHeight * 0.02), // Adjust spacing
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (registerFormKey.currentState?.validate() == true) {
                  authController.docregister(
                    email: formProvider.email,
                    userName: formProvider.userName,
                    password: formProvider.password,
                    doctorId: formProvider.doctorId,
                  );
                  // sign up router will be here
                  GoRouter.of(context).goNamed(MyNamedRoutes.doclogin);
                }
              },
              child: Text(
                context.translate.register,
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: MyColors.primary_500,
                ),
              ),
            ),
          ),
          SizedBox(height: context.screenHeight * 0.02), // Adjust spacing
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                GoRouter.of(context).pushNamed(MyNamedRoutes.patientRegister);
              },
              child: Text(
                "Switch to Patient",
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: MyColors.primary_500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
