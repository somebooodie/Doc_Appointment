import 'package:doc_appointment/app/core/extensions/build_context_extension.dart';
import 'package:doc_appointment/app/modules/feature/domain/providers/state/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class faqDoctor extends ConsumerWidget {
  final List<Map<String, String>> faqList = [
    {
      "question": "1. What are the common symptoms of COVID-19?",
      "answer":
          "Loss of sense of smell, coughing, fever, difficulty breathing, fatigue, body aches, sore throat, and headache are common symptoms of COVID-19."
    },
    {
      "question": "2. How to stop feeling dizzy?",
      "answer":
          "To stop feeling dizzy, you can try sitting or lying down, drinking water, avoiding sudden movements, and taking deep breaths. If the dizziness persists, consult with a healthcare professional."
    },
    {
      "question": "3. Is it ok to drink hot water after having a big meal?",
      "answer":
          "It is generally okay to drink hot water after a big meal. However, it's essential to listen to your body. If you feel comfortable doing so, hot water can aid digestion."
    },
    {
      "question": "4. Do we need to take Panadol when we have a fever?",
      "answer":
          "Panadol, or acetaminophen, can be taken to reduce fever. However, it's important to follow recommended dosage guidelines and consult with a healthcare professional if needed."
    },
    {
      "question": "5. How do we do CPR?",
      "answer":
          "To perform CPR, place the heel of your hand on the center of the person's chest, interlock the fingers, and compress the chest at least 2 inches deep. Perform chest compressions at a rate of 100-120 compressions per minute."
    },
    {
      "question": "6. Can I take 2 pills of antihistamine?",
      "answer":
          "The dosage of antihistamines depends on the specific medication. Follow the recommended dosage on the packaging or consult with a healthcare professional to ensure safe and effective use."
    },
    {
      "question": "7. How can I update my medical history on the app?",
      "answer":
          "To update your medical history on the app, navigate to the profile or settings section, find the medical history option, and follow the provided prompts to add or edit information."
    },
    {
      "question": "8. What should I do in case of a medical emergency?",
      "answer":
          "In case of a medical emergency, call emergency services immediately (e.g., 911). Provide clear information about the situation, your location, and follow any instructions given by the dispatcher."
    },
    {
      "question": "9. What kind of medicine do we take to treat fever?",
      "answer":
          "Common fever-reducing medications include acetaminophen (Panadol), ibuprofen, and aspirin. However, it's essential to consult with a healthcare professional for personalized advice."
    },
    {
      "question": "10. Why do I need to eat before taking antibiotics?",
      "answer":
          "Eating before taking antibiotics helps reduce the risk of stomach upset or nausea. It also aids in the absorption of the medication. Always follow the instructions provided by your healthcare provider."
    },
  ];

  faqDoctor({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkIfUserAuthenticated =
        ref.watch(checkIfAuthinticatedFutureProvider);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 60,
            ),
            Image.asset(
              'assets/images/faq_doctor.png',
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
                      title: Text(faqList[index]["question"] ?? ""),
                      subtitle: Text(
                        "Answer: ${faqList[index]["answer"] ?? ""}",
                        style: const TextStyle(color: Colors.blue),
                      ),
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
