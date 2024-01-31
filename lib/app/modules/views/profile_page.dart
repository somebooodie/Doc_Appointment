import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_appointment/app/config/routes/named_routes.dart';
import 'package:doc_appointment/app/config/theme/my_colors.dart';
import 'package:doc_appointment/app/core/extensions/build_context_extension.dart';
import 'package:doc_appointment/app/modules/feature/domain/models/User_model.dart';
import 'package:doc_appointment/app/modules/feature/domain/providers/controller/user_repo_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';



class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentuser = FirebaseAuth.instance.currentUser;
    // Check if currentuser is null before accessing its properties
    if (currentuser?.uid.isEmpty == true) {
      // Handle the case where the user is not authenticated
      return Scaffold(
        body: Center(
          child: Text("User not authenticated"),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primary_500,
        centerTitle: true,
        automaticallyImplyLeading: true,

        title: Text("Profile",
            style: context.textTheme.headlineMedium
                ?.copyWith(fontSize: 16, color: MyColors.white)),

      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        FirebaseAuth.instance.signOut();
        GoRouter.of(context).goNamed(MyNamedRoutes.docRegister);
      }),
      body: FutureBuilder(
        // 1. Get the current user data
        future: getCurrentUserData(),
        builder: (context, snapshot) {
          print(snapshot.data);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text("Error loading user data: ${snapshot.error}"),
            );
          }

          if (snapshot.hasData) {
            MyUser user = snapshot.data as MyUser;
            String accountType = "Patient";
            if (user.doctorId != "") {
              accountType = "Doctor";
            }
            // 3. Display the data (user) from Firebase
            return Column(
              crossAxisAlignment: CrossAxisAlignment
                  .stretch, // Ensure widgets span the entire width
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: context.screenHeight * 0.02), // Adjusted padding
                  child: Container(
                    width: context.screenWidth * 0.9,
                    height: context.screenWidth * 0.2,
                    decoration: BoxDecoration(
                      border: Border.all(color: MyColors.primary_500),
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("username: ",
                                  style: TextStyle(
                                      fontSize: 14, color: MyColors.black)),
                              Text(user.username,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: MyColors.primary_500)),
                            ],
                          ),
                          Row(
                            children: [
                              Text("email: ",
                                  style: TextStyle(
                                      fontSize: 14, color: MyColors.black)),
                              Text(user.email,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: MyColors.primary_500)),
                            ],
                          ),
                          Row(
                            children: [
                              Text("Account type: ",
                                  style: TextStyle(
                                      fontSize: 14, color: MyColors.black)),
                              Text(accountType,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: MyColors.primary_500)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: context.screenHeight * 0.02),
                  child: GestureDetector(
                    onTap: () => GoRouter.of(context)
                        .goNamed(MyNamedRoutes.changepassword),
                    child: Container(
                      width: context.screenWidth * 0.9,
                      height: context.screenWidth * 0.2,
                      decoration: BoxDecoration(
                        border: Border.all(color: MyColors.primary_500),
                      ),
                      child: Center(
                        child: Text(
                          "change username",
                          style: TextStyle(
                              fontSize: 14, color: MyColors.primary_500),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: context.screenHeight * 0.02),
                  child: Container(
                    width: context.screenWidth * 0.9,
                    height: context.screenWidth * 0.2,
                    decoration: BoxDecoration(
                      border: Border.all(color: MyColors.primary_500),
                    ),
                    child: Center(
                      child: Text(
                        "change password",
                        style: TextStyle(
                            fontSize: 14, color: MyColors.primary_500),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: context.screenHeight * 0.02),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Switch Account",
                      style:
                          TextStyle(fontSize: 14, color: MyColors.primary_500),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: context.screenHeight * 0.02),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Delete Account",
                      style:
                          TextStyle(fontSize: 14, color: MyColors.primary_500),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(child: Text("User data not found"));
          }
        },
      ),
    );
  }
}
