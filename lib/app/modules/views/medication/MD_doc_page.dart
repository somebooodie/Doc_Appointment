import 'package:doc_appointment/app/config/routes/named_routes.dart';
import 'package:doc_appointment/app/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MdDocPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: context.screenHeight * 0.15,
        title: Image.asset(
          'assets/images/logo.png',
          width: context.screenHeight * 0.12,
          height: context.screenHeight * 0.12,
          fit: BoxFit.cover,
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSquareButton(
              context: context,
              imagePath: 'assets/images/top-view-variety-medicine-tablets.jpg',
              text: 'Add Meds By Doctor',
              routeName: MyNamedRoutes.medDocAdd,
            ),
            SizedBox(height: context.screenHeight * 0.0), // Adjusted spacing
            _buildSquareButton(
              context: context,
              imagePath:
                  'assets/images/glasses-medications-around-clipboard.jpg',
              text: 'Write Prescription By Doctor',
              routeName: MyNamedRoutes.PrescriptionUploadPage,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSquareButton({
    required BuildContext context,
    required String imagePath,
    required String text,
    required String routeName,
  }) {
    return InkWell(
      onTap: () {
        if (routeName == MyNamedRoutes.medDocAdd) {
          GoRouter.of(context).pushNamed(MyNamedRoutes.medDocAdd);
        } else if (routeName == MyNamedRoutes.PrescriptionUploadPage) {
          GoRouter.of(context).go('/mdDocPage/PrescriptionUploadPage');
        } else {
          GoRouter.of(context).go(routeName);
        }
      },
      child: Stack(
        children: [
          Container(
            width: double.infinity, // Adjusted width
            height: context.screenHeight * 0.35, // Adjusted height
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          Container(
            width: double.infinity,
            height: context.screenHeight * 0.35,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.12),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
