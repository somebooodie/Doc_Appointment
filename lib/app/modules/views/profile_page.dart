import 'package:doc_appointment/app/config/routes/named_routes.dart';
import 'package:doc_appointment/app/config/theme/my_colors.dart';
import 'package:doc_appointment/app/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primary_500,
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: Text(context.translate.profile,
            style: context.textTheme.headlineMedium
                ?.copyWith(fontSize: 16, color: MyColors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            GoRouter.of(context).goNamed(
                MyNamedRoutes.homepage); // Add your navigation logic here
          },
        ),
      ),
      body: Center(
          child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: context.screenHeight * 0.05),
            child: Container(
              child: Center(
                  child: Column(
                children: [
                  Row(
                    children: [
                      Text("username: ",
                          style:
                              TextStyle(fontSize: 14, color: MyColors.black)),
                      Text("test",
                          style: TextStyle(
                              fontSize: 14, color: MyColors.primary_500)),
                    ],
                  ),
                  Row(
                    children: [
                      Text("email: ",
                          style:
                              TextStyle(fontSize: 14, color: MyColors.black)),
                      Text("test",
                          style: TextStyle(
                              fontSize: 14, color: MyColors.primary_500)),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Account type: ",
                          style:
                              TextStyle(fontSize: 14, color: MyColors.black)),
                      Text("patient",
                          style: TextStyle(
                              fontSize: 14, color: MyColors.primary_500)),
                    ],
                  ),
                ],
              )),
              width: context.screenWidth * 0.9,
              height: context.screenWidth * 0.2,
              decoration: BoxDecoration(
                border: Border.all(color: MyColors.primary_500),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: context.screenHeight * 0.05),
            child: Container(
              child: Container(
                child: Text("change username",
                    style:
                        TextStyle(fontSize: 14, color: MyColors.primary_500)),
                width: context.screenWidth * 0.9,
                height: context.screenWidth * 0.2,
                decoration: BoxDecoration(
                  border: Border.all(color: MyColors.primary_500),
                ),
              ),
              width: context.screenWidth * 0.9,
              height: context.screenWidth * 0.2,
              decoration: BoxDecoration(
                border: Border.all(color: MyColors.primary_500),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: context.screenHeight * 0.05),
            child: Container(
              child: Container(
                child: Text("change passwrod",
                    style:
                        TextStyle(fontSize: 14, color: MyColors.primary_500)),
                width: context.screenWidth * 0.9,
                height: context.screenWidth * 0.2,
                decoration: BoxDecoration(
                  border: Border.all(color: MyColors.primary_500),
                ),
              ),
              width: context.screenWidth * 0.9,
              height: context.screenWidth * 0.2,
              decoration: BoxDecoration(
                border: Border.all(color: MyColors.primary_500),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: context.screenHeight * 0.05),
            child: ElevatedButton(
              onPressed: () {},
              child: Text("Switch Account",
                  style: TextStyle(fontSize: 14, color: MyColors.primary_500)),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: context.screenHeight * 0.05),
            child: ElevatedButton(
              onPressed: () {},
              child: Text("Delete Account",
                  style: TextStyle(fontSize: 14, color: MyColors.primary_500)),
            ),
          ),
        ],
      )),
    );
  }
}
