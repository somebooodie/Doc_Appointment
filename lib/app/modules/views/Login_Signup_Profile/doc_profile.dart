import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doc_appointment/app/config/routes/named_routes.dart';
import 'package:doc_appointment/app/config/theme/my_colors.dart';
import 'package:doc_appointment/app/core/extensions/build_context_extension.dart';
import 'package:doc_appointment/app/modules/auth/domain/models/user_model.dart';
import 'package:doc_appointment/app/modules/views/Login_Signup_Profile/UserInfo/user_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

Future<MyUser?> getCurrentUserData() async {
  try {
    final currentuser = FirebaseAuth.instance.currentUser;
    DocumentSnapshot userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentuser?.uid)
        .get();

    MyUser user = MyUser.fromMap(userData.data() as Map<String, dynamic>);

    return user;
  } catch (e) {
    print("Error fetching user data: $e");
    return null;
  }
}

class DocProfileScreen extends ConsumerWidget {
  const DocProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentuser = FirebaseAuth.instance.currentUser;
    if (currentuser?.uid.isEmpty == true) {
      return Scaffold(
        body: Center(
          child: Text("User not authenticated"),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: FutureBuilder(
                future: getCurrentUserData(),
                builder: (context, snapshot) {
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

                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(context.screenHeight * 0.01),
                          child: Container(
                            width: context.screenWidth * 0.9,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0),
                              color: Colors.white, // Updated color
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 207, 207, 207)
                                      .withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  UserInfoRow("Username:", user.username),
                                  UserInfoRow("Email:", user.email),
                                  UserInfoRow("Account Type:", accountType),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: context.screenHeight * 0.05),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(horizontal: 16),
                                child: GestureDetector(
                                  onTap: () => GoRouter.of(context)
                                      .goNamed(MyNamedRoutes.changeUsername),
                                  child: Card(
                                    elevation:
                                        4, // Add elevation for a subtle shadow
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    color: Colors.white,
                                    child: Container(
                                      width: double.infinity,
                                      height: context.screenWidth * 0.2,
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Change Username",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: MyColors.primary_500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(horizontal: 16),
                                child: GestureDetector(
                                  onTap: () => GoRouter.of(context)
                                      .goNamed(MyNamedRoutes.changepassword),
                                  child: Card(
                                    elevation:
                                        4, // Add elevation for a subtle shadow
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0),
                                    ),
                                    color: Colors.white,
                                    child: Container(
                                      width: double.infinity,
                                      height: context.screenWidth * 0.2,
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Change Password",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: MyColors.primary_500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: context.screenHeight * 0.05),
                          child: Column(
                            children: [
                              Container(
                                width:
                                    context.screenWidth * 0.6, // Adjusted width
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    primary: MyColors.primary_500,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          0), // No rounded corners
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                        8.0), // Adjusted padding
                                    child: Text(
                                      "Switch Account",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: context.screenWidth * 0.05,
                              ),
                              Container(
                                width:
                                    context.screenWidth * 0.6, // Adjusted width
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    primary: MyColors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          0), // No rounded corners
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(
                                        8.0), // Adjusted padding
                                    child: Text(
                                      "Delete Account",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Center(child: Text("User data not found"));
                  }
                },
              ),
            ),
          ),
          Positioned(
            bottom: 16, // Adjusted bottom margin
            right: 16, // Adjusted right margin
            child: Container(
              width: context.screenWidth * 0.15,
              child: ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  GoRouter.of(context).goNamed(MyNamedRoutes.docRegister);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(0), // No rounded corners
                  ),
                ),
                child: const Center(
                  child: SizedBox(
                    child: Icon(
                      Icons.exit_to_app,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
