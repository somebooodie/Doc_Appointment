import 'package:doc_appointment/app/core/extensions/build_context_extension.dart';
import 'package:doc_appointment/app/modules/auth/domain/providers/state/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class faqDoctor extends ConsumerWidget {
  final List<String> faqList = [
    "1. What are the common symptoms of COVID-19?",
    "2. How can I schedule an appointment with a doctor using this app?",
    "3. Is my personal health information secure with this app?",
    "4. Can I consult with a doctor online through video calls?",
    "5. How do I reset my password if I forget it?",
    "6. Are there any fees associated with using this app for medical appointments?",
    "7. How can I update my medical history on the app?",
    "8. What should I do in case of a medical emergency?",
    "9. Can I view my previous medical appointments and prescriptions in the app?",
    "10. How do I provide feedback or report issues with the app?"
  ];

  faqDoctor({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkIfUserAuthenticated =
        ref.watch(checkIfAuthinticatedFutureProvider);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: context.screenHeight * 0.12,
        title: Image.asset(
          'assets/images/logo.png', // Replace with your [DA] logo asset path
          width: context.screenHeight * 0.05,
          height: context.screenHeight * 0.09,
          fit: BoxFit.cover,
        ),
        centerTitle: true, // Centers the title image
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
            ),
            Image.asset(
              'assets/images/med_report.png',
              width: context.screenHeight * 0.3,
              height: context.screenHeight * 0.2,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: ListView.separated(
                itemCount: faqList.length,
                separatorBuilder: (context, index) =>
                    const Divider(), // Add visual separation
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(faqList[index]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
