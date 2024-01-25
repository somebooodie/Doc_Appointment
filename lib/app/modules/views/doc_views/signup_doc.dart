import 'package:doc_appointment/app/config/routes/named_routes.dart';
import 'package:doc_appointment/app/config/theme/my_colors.dart';
import 'package:doc_appointment/app/core/extensions/build_context_extension.dart';
import 'package:doc_appointment/app/modules/feature/domain/providers/controller/text_form_provider.dart';
import 'package:doc_appointment/app/modules/feature/domain/providers/state/auth_provider.dart';
import 'package:doc_appointment/app/modules/feature/domain/providers/state/patient_auth_state.dart';
import 'package:doc_appointment/app/modules/widgets/my_forms_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class DocSignup extends StatelessWidget {
  DocSignup({super.key});

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

          // email registeration button
          Consumer(builder: (context, ref, child) {
            final authStateProvider =
                ref.watch(authControllerProvider.notifier);
            final AuthState authState = ref.watch(authControllerProvider);
            final MyAuthFormController authFormContrller =
                ref.watch(authFormController);
            return ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  authStateProvider
                      .register(
                    email: authFormContrller.email,
                    userName: authFormContrller.userName,
                    password: authFormContrller.password,
                  )
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
        ],
      ),
    );
  }
}
