import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_appointment/app/config/routes/named_routes.dart';
import 'package:doc_appointment/app/config/theme/my_colors.dart';
import 'package:doc_appointment/app/core/extensions/build_context_extension.dart';
import 'package:doc_appointment/app/modules/feature/domain/models/user_model.dart';
import 'package:doc_appointment/app/modules/feature/domain/providers/state/auth_provider.dart';
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
      appBar: AppBar(
        backgroundColor: MyColors.primary_500,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(context.translate.docLogin,
            style: context.textTheme.headlineMedium
                ?.copyWith(fontSize: 16, color: MyColors.white)),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DocLoginAuthForm(
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
                          password: formProvider.password)
                      .then((value) async {
                    if (value == true) {
                      Future<MyUser?> getCurrentUserData() async {
                        try {
                          DocumentSnapshot userData = await FirebaseFirestore
                              .instance
                              .collection('users')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .get();

                          // 2. Create user object and map the value from Firebase to this user object.
                          MyUser user = MyUser.fromMap(
                              userData.data() as Map<String, dynamic>);
                          return user;
                        } catch (e) {
                          print("Error fetching user data: $e");
                          return null;
                        }
                      }

                      MyUser? user = await getCurrentUserData();
                      print(user!.doctorId + "\n");
                      print(user!.email + "\n");
                      //   Verify if the user has a doctor ID
                      if (user!.doctorId == formProvider.doctorId) {
                        // Navigate to the doctor home screen
                        GoRouter.of(context)
                            .goNamed(MyNamedRoutes.docHomeScreen);
                      } else {
                        //   // Handle the case when the user is not a doctor
                        //   // You can show an error message or perform other actions

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
                  color: MyColors.primary_500,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).pushNamed(MyNamedRoutes.docRegister);
              },
              child: Text(context.translate.register,
                  style: context.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: MyColors.primary_500)),
            ),
            ElevatedButton(
              onPressed: () {
                GoRouter.of(context).goNamed(MyNamedRoutes.patientlogin);
              },
              child: Text(context.translate.patientlogin,
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
