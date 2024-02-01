import 'package:doc_appointment/app/config/routes/named_routes.dart';
import 'package:doc_appointment/app/config/theme/my_colors.dart';
import 'package:doc_appointment/app/core/extensions/build_context_extension.dart';
import 'package:doc_appointment/app/modules/feature/domain/providers/state/state_schedule_pateint.dart';
import 'package:doc_appointment/app/modules/lists/doctor_list.dart';
import 'package:flutter/material.dart';
import 'package:doc_appointment/app/modules/views/Schedule/schedule_patient.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DoctorNamesListView extends ConsumerWidget {
  DoctorNamesListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: context.screenHeight * 0.12,
        title: Image.asset(
          'assets/images/logo.png', // Replace with your [DA] logo asset path
          width: context.screenHeight * 0.05,
          height: context.screenHeight * 0.09,
          fit: BoxFit.cover,
        ),
        centerTitle: true, // This will center the title image
      ),
      body: Consumer(builder: (context, ref, child) {
        final state = ref.watch(schedulePatientProvider);

        return ListView.builder(
          itemCount: state.filtered.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () =>
                  GoRouter.of(context).pushNamed(MyNamedRoutes.patientlogin),
              child: Card(
                color: MyColors.blue,
                child: ListTile(
                  title: Text(state.filtered[index]['name']),
                  subtitle: Text(state.filtered[index]['specialty']),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
