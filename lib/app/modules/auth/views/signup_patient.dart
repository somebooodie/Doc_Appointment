import 'package:doc_appointment/app/config/routes/named_routes.dart';
import 'package:doc_appointment/app/config/theme/my_colors.dart';
import 'package:doc_appointment/app/core/extensions/build_context_extension.dart';
import 'package:doc_appointment/app/modules/auth/domain/providers/controller/text_form_provider.dart';
import 'package:doc_appointment/app/modules/auth/domain/providers/state/auth_provider.dart';
import 'package:doc_appointment/app/modules/auth/domain/providers/state/patient_auth_state.dart';
import 'package:doc_appointment/app/modules/auth/widgets/my_forms_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final myAuthFormControllerProvider =
    ChangeNotifierProvider((ref) => MyAuthFormController());

class PatientSignup extends StatelessWidget {
  PatientSignup({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.translate.register,
          style: context.theme.textTheme.titleMedium?.copyWith(
            color: MyColors.white,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyAuthForm(registerFormKey: formKey),
          const SizedBox(
            height: 12,
          ),
          Consumer(builder: (context, ref, child) {
            final authStateProvider =
                ref.watch(authControllerProvider.notifier);
            final AuthState authState = ref.watch(authControllerProvider);
            final MyAuthFormController authFormController =
                ref.watch(myAuthFormControllerProvider);

            return ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  authFormController.docID =
                      '0000'; // Set the docId for the patient
                  authStateProvider
                      .register(
                          email: authFormController.email,
                          userName: authFormController.userName,
                          password: authFormController.password,
                          docID: authFormController
                              .docID) // Pass the docId to the register method
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
                      context.translate.register,
                    ),
            );
          }),
          const SizedBox(
            height: 25,
          ),
          Consumer(builder: (context, ref, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Patient'),
                Switch(
                  value: false, // Assuming the default role is Patient
                  onChanged: (bool value) {
                    GoRouter.of(context).goNamed(MyNamedRoutes.signupDoctor);
                  },
                ),
                const Text('Doctor'),
              ],
            );
          }),
        ],
      ),
    );
  }
}
