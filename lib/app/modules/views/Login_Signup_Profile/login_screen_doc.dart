import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_appointment/app/config/routes/named_routes.dart';
import 'package:doc_appointment/app/config/theme/my_colors.dart';
import 'package:doc_appointment/app/core/extensions/build_context_extension.dart';
import 'package:doc_appointment/app/modules/auth/domain/models/user_model.dart';
import 'package:doc_appointment/app/modules/auth/domain/providers/state/doc_auth_provider.dart';
import 'package:doc_appointment/app/modules/widgets/doc_register_forms_widgets.dart';
import 'package:doc_appointment/app/modules/widgets/doc_login_forms_widget.dart';
import 'package:doc_appointment/app/modules/widgets/patient_login_forms_widget.dart';
import 'package:doc_appointment/app/modules/widgets/patient_register_forms_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class doclogin extends ConsumerWidget {
  doclogin({super.key});
  final registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.read(authControllerProvider.notifier);
    final formProvider = ref.watch(authFormController);

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: context.screenHeight * 0.03),
            Image.asset(
              'assets/images/Big_logo.png',
              width: context.screenWidth * 0.8,
              height: context.screenHeight * 0.3,
            ),
            Padding(
              padding:
                  const EdgeInsets.all(8.0), // Adjusted the overall padding
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DocLoginAuthForm(
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
                                password: formProvider.password)
                            .then((value) async {
                          if (value == true) {
                            Future<MyUser?> getCurrentUserData() async {
                              try {
                                DocumentSnapshot userData =
                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .get();

                                MyUser user = MyUser.fromMap(
                                    userData.data() as Map<String, dynamic>);
                                return user;
                              } catch (e) {
                                print("Error fetching user data: $e");
                                return null;
                              }
                            }

                            MyUser? user = await getCurrentUserData();

                            if (user!.doctorId == formProvider.doctorId) {
                              GoRouter.of(context)
                                  .goNamed(MyNamedRoutes.docHomeScreen);
                            } else {
                              print("User is not a doctor");
                            }
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
                      primary: Colors.blue,
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
                      GoRouter.of(context).pushNamed(MyNamedRoutes.docRegister);
                    },
                    child: Text(
                      context.translate.register,
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: MyColors.blue,
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
                      GoRouter.of(context).goNamed(MyNamedRoutes.patientlogin);
                    },
                    child: Text(
                      context.translate.patientlogin,
                      style: context.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: MyColors.blue,
                        decoration: TextDecoration.underline,
                        decorationColor:
                            MyColors.blue, // Set the underline color
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
