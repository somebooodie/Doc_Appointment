import 'package:doc_appointment/app/config/routes/named_routes.dart';
import 'package:doc_appointment/app/config/theme/my_colors.dart';
import 'package:doc_appointment/app/core/extensions/build_context_extension.dart';
import 'package:doc_appointment/app/modules/auth/domain/providers/controller/text_form_provider.dart';
import 'package:doc_appointment/app/modules/auth/domain/providers/state/auth_provider.dart';
import 'package:doc_appointment/app/modules/auth/domain/providers/state/patient_auth_state.dart';
import 'package:doc_appointment/app/modules/auth/widgets/my_login_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final myAuthFormControllerProvider =
    ChangeNotifierProvider((ref) => MyAuthFormController());

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.translate.login, // Change to login
          style: context.theme.textTheme.titleMedium?.copyWith(
            color: MyColors.white,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyAuthFormLogin(
              LoginFormKey:
                  formKey), // Make sure this has email and password fields only
          const SizedBox(height: 12),

          // Login button
          Consumer(builder: (context, ref, child) {
            final authStateProvider =
                ref.watch(authControllerProvider.notifier);
            final AuthState authState = ref.watch(authControllerProvider);
            final MyAuthFormController authFormController =
                ref.watch(myAuthFormControllerProvider);

            return ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  authStateProvider
                      .signIn(
                          // Use signIn method
                          email: authFormController.email,
                          password: authFormController.password)
                      .then((result) {
                    if (result == true) {
                      context.goNamed(MyNamedRoutes.homepage);
                    } else if (authState.error != null) {
                      context.showSnackbar(authState.error.toString());
                    }
                  });
                }
              },
              child: authState.isLoading
                  ? const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: CircularProgressIndicator(
                        color: MyColors.white,
                      ),
                    )
                  : Text(
                      context.translate.login, // Change to login
                    ),
            );
          }),
          const SizedBox(height: 25),

          // Remove the Toggle switch for Doctor signup as it's not relevant for login
        ],
      ),
    );
  }
}
