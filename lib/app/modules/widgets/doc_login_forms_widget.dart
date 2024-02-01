import 'package:doc_appointment/app/core/extensions/build_context_extension.dart';
import 'package:doc_appointment/app/modules/auth/domain/helper/auth_validator.dart';
import 'package:doc_appointment/app/modules/auth/domain/providers/state/auth_provider.dart';
import 'package:doc_appointment/app/modules/widgets/my_textform_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DocLoginAuthForm extends ConsumerStatefulWidget {
  const DocLoginAuthForm({
    Key? key,
    this.registerFormKey,
  }) : super(key: key);

  final GlobalKey<FormState>? registerFormKey;

  @override
  ConsumerState createState() => _MyAuthFormState();
}

class _MyAuthFormState extends ConsumerState<DocLoginAuthForm> {
  final authValidators = AuthValidators();

  final TextEditingController emailController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();

  final TextEditingController passwordController = TextEditingController();
  final FocusNode passwordFocusNode = FocusNode();

  final TextEditingController doctorIdController = TextEditingController();
  final FocusNode doctorIdFocus = FocusNode();
  bool isPatient = true;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    emailFocusNode.dispose();

    passwordController.dispose();
    passwordFocusNode.dispose();

    doctorIdController.dispose();
    doctorIdFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authFormContrller = ref.watch(authFormController);
    return SizedBox(
      child: Form(
        key: widget.registerFormKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              MyTextFormField(
                textEditingController: emailController,
                obscureText: false,
                myFocusNode: emailFocusNode,
                validator: (input) {
                  return authValidators.emailValidator(input);
                },
                prefexIcon: const Icon(Icons.email),
                labelText: context.translate.email,
                myTextInputAction: TextInputAction.next,
                onChanged: (val) {
                  authFormContrller.setEmailField(val);
                },
              ),
              SizedBox(height: context.screenHeight * 0.05),
              MyTextFormField(
                textEditingController: doctorIdController,
                obscureText: false,
                myFocusNode: doctorIdFocus,
                validator: (input) => authValidators.doctorIdValidator(input),
                prefexIcon: const Icon(Icons.medical_services),
                labelText: context.translate.doctorId,
                myTextInputAction: TextInputAction.next,
                onChanged: (val) {
                  authFormContrller.setDoctorId(val);
                },
              ),
              SizedBox(height: context.screenHeight * 0.05),
              MyTextFormField(
                textEditingController: passwordController,
                obscureText: authFormContrller.togglePassword,
                myFocusNode: passwordFocusNode,
                validator: (input) => authValidators.passwordVlidator(input),
                prefexIcon: const Icon(Icons.password),
                labelText: context.translate.password,
                myTextInputAction: TextInputAction.done,
                onChanged: (val) {
                  authFormContrller.setPasswordField(val);
                },
                togglePassword: () {
                  authFormContrller.togglePasswordIcon();
                },
                suffixIcon: Icon(
                  authFormContrller.togglePassword
                      ? Icons.remove_red_eye_outlined
                      : Icons.remove_red_eye_rounded,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
