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
      backgroundColor: Colors.white, // Set scaffold background color to white
      appBar: AppBar(
        title: Text('Doctor Register', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: MyColors.primary_500, // Use the primary color from MyColors
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            GoRouter.of(context).pop();
          },
        ),
        // Removed the question mark icon from the AppBar actions
      ),
      body: SingleChildScrollView( // Use SingleChildScrollView to avoid overflow when keyboard appears
        child: Column(
          children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(
                'assets/images/Big_logo.png',
                fit: BoxFit.contain, // Use BoxFit.contain to keep the image aspect ratio
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0), // Adjust padding to bring fields closer
              child: DocRegisterAuthForm(
                registerFormKey: registerFormKey,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: MyColors.primary_500, // Set the background color to the primary color
                  onPrimary: Colors.white, // Set the text color to white
                ),
                onPressed: () {
                  if (registerFormKey.currentState?.validate() == true) {
                    authController.docregister(
                      email: formProvider.email,
                      userName: formProvider.userName,
                      password: formProvider.password,
                      doctorId: formProvider.doctorId,
                    );
                    GoRouter.of(context).goNamed(MyNamedRoutes.doclogin);
                  }
                },
                child: Text(
                  context.translate.register,
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextButton(
                onPressed: () {
                  GoRouter.of(context).pushNamed(MyNamedRoutes.patientRegister);
                },
                child: Text(
                  "Switch to Patient",
                  style: TextStyle(
                    decoration: TextDecoration.underline, // Underline the text
                    color: MyColors.primary_500, // Use the primary color for the text
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}