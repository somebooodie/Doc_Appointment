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

// 1. Create a function to get the current user data from the 'users' collection based on the user ID.
Future<MyUser?> getCurrentUserData() async {
  try {
    final currentuser = FirebaseAuth.instance.currentUser;
    DocumentSnapshot userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentuser?.uid)
        .get();

    // 2. Create user object and map the value from Firebase to this user object.
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
      body: SingleChildScrollView( // Wrap the body with SingleChildScrollView
        child: FutureBuilder(
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
              children: [
                Padding(
                  padding: EdgeInsets.all(context.screenHeight * 0.05),
                  child: Container(
                    width: context.screenWidth * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          10), // Add border radius for a rounded look
                      color: MyColors
                          .primary_500, // Set background color to blue or your preferred color
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // Align text to the left
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
                  padding: EdgeInsets.only(top: context.screenHeight * 0.05),
                  child: GestureDetector(
                    onTap: () => GoRouter.of(context)
                        .goNamed(MyNamedRoutes.changeUsername),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: MyColors.primary_500),
                      ),
                      child: Container(
                        width: context.screenWidth * 0.9,
                        height: context.screenWidth * 0.2,
                        alignment: Alignment.center,
                        child: Text(
                          "Change Username",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold, // Make the font bold
                            color: MyColors.primary_500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: context.screenHeight * 0.05),
                  child: GestureDetector(
                    onTap: () => GoRouter.of(context)
                        .goNamed(MyNamedRoutes.changepassword),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: MyColors.primary_500),
                      ),
                      child: Container(
                        width: context.screenWidth * 0.9,
                        height: context.screenWidth * 0.2,
                        alignment: Alignment.center,
                        child: Text(
                          "Change Password",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold, // Make the font bold
                            color: MyColors.primary_500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: context.screenHeight * 0.05),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceEvenly, // Use spaceEvenly to distribute the space between buttons
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Switch Account",
                          style: TextStyle(
                              fontSize: 14, color: MyColors.primary_500),
                        ),
                      ),
                      SizedBox(
                          width: context.screenWidth *
                              0.05), // Adjust the width as needed
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "Delete Account",
                          style: TextStyle(fontSize: 14, color: MyColors.red),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    GoRouter.of(context).goNamed(MyNamedRoutes.docRegister);
                  },
                  child: Icon(
                    Icons.exit_to_app,
                    color: Colors.blue, // Set the color to blue
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
    );
  }
}
