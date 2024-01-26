
import 'package:doc_appointment/app/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField({
    super.key,
    required this.textEditingController,
    required this.myFocusNode,
    required this.myTextInputAction,
    required this.labelText,
    required this.prefexIcon,
    this.suffixIcon,
    this.togglePassword,
    required this.obscureText,
    required this.onChanged,
    this.validator,
  });
  final TextEditingController textEditingController;
  final FocusNode myFocusNode;
  final TextInputAction myTextInputAction;
  final String labelText;
  final Icon prefexIcon;
  final Icon? suffixIcon;
  final Function()? togglePassword;
  final bool obscureText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.screenHeight * 0.07,
      child: TextFormField(
        controller: textEditingController,
        focusNode: myFocusNode,
        textInputAction: myTextInputAction,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            label: Text(labelText),
            prefixIcon: prefexIcon,
            suffix: IconButton(
                icon: suffixIcon ?? SizedBox(), onPressed: togglePassword)),
        obscureText: obscureText,
        validator: validator,
        onChanged: onChanged,
      ),
    );
  }
}