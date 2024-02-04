import 'package:doc_appointment/app/config/routes/named_routes.dart';
import 'package:doc_appointment/app/config/theme/my_colors.dart';
import 'package:doc_appointment/app/core/extensions/build_context_extension.dart';
import 'package:doc_appointment/app/modules/auth/domain/providers/controller/fetch_doctors.dart';
import 'package:doc_appointment/app/modules/auth/domain/providers/repo/user_repo.dart';
import 'package:doc_appointment/app/modules/auth/domain/providers/state/state_schedule_pateint.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// class DoctorNamesListView extends ConsumerStatefulWidget {
//   DoctorNamesListView({Key? key}) : super(key: key);

//   @override
//   _DoctorNamesListViewState createState() => _DoctorNamesListViewState();
// }

// class _DoctorNamesListViewState extends ConsumerState<DoctorNamesListView> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         toolbarHeight: context.screenHeight * 0.12,
//         title: Image.asset(
//           'assets/images/logo.png', // Replace with your [DA] logo asset path
//           width: context.screenHeight * 0.05,
//           height: context.screenHeight * 0.09,
//           fit: BoxFit.cover,
//         ),
//         centerTitle: true,
//       ),
//       body: Consumer(builder: (context, ref, child) {
//         final state = ref.watch(schedulePatientProvider);

//         return
//         ListView.builder(
//           itemCount: state.filtered.length,
//           itemBuilder: (context, index) {
//             return GestureDetector(
//               onTap: () =>
//                   GoRouter.of(context).pushNamed(MyNamedRoutes.availability),
//               child: Card(
//                 color: MyColors.blue,
//                 child: ListTile(
//                   title: Text(state.filtered[index]['name']),
//                   subtitle: Text(state.filtered[index]['specialty']),
//                 ),
//               ),
//             );
//           },
//         );
//       }),
//     );
//   }
// }

class DoctorNamesListView extends ConsumerStatefulWidget {
  DoctorNamesListView({Key? key}) : super(key: key);

  @override
  _DoctorNamesListViewState createState() => _DoctorNamesListViewState();
}

class _DoctorNamesListViewState extends ConsumerState<DoctorNamesListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: context.screenHeight * 0.12,
        title: Image.asset(
          'assets/images/logo.png', // Replace with your [DA] logo asset path
          width: context.screenHeight * 0.05,
          height: context.screenHeight * 0.09,
          fit: BoxFit.cover,
        ),
        centerTitle: true,
      ),
      body: Consumer(builder: (context, ref, child) {
        final myUsers = ref.watch(usersProvider);
        final state = ref.watch(schedulePatientProvider);
        return myUsers.when(data: (List<UserRepo> data) {
          return ListView.builder(
            // itemCount: state.filtered.length,
            itemCount: 5,
            itemBuilder: (context, index) {
              final user = data[index];
              return GestureDetector(
                onTap: () =>
                    GoRouter.of(context).pushNamed(MyNamedRoutes.availability),
                child: Card(
                  color: MyColors.blue,
                  child: ListTile(
                    title: Text(data[index].username.toString()),
                    subtitle: Text(data[index].email.toString()),
                    // title: Text(state.filtered[index]['name']),
                    // subtitle: Text(state.filtered[index]['specialty']),
                  ),
                ),
              );
            },
          );
        }, error: (Object error, StackTrace stackTrace) {
          return Center(child: Text(error.toString()));
        }, loading: () {
          return const Center(child: CircularProgressIndicator());
        });
      }),
    );
  }
}

// class ChatScreen extends ConsumerWidget {
//   const ChatScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final chatUsers = ref.watch(usersProvider);
//     return Scaffold(
//       appBar: AppBar(title: Text(context.translate.chats)),
//       body: chatUsers.when(data: (List<UserModel> data) {
//         return ListView.builder(
//           itemCount: data.length,
//           itemBuilder: (context, index) {
//             final user = data[index];
//             return Card(
//                 child: ListTile(
//               title: Text(data[index].username.toString()),
//               subtitle: Text(data[index].email.toString()),
//             ));
//           },
//         );
//       }, error: (Object error, StackTrace stackTrace) {
//         return Center(child: Text(error.toString()));
//       }, loading: () {
//         return const Center(child: CircularProgressIndicator());
//       }),
//     );
//   }
// }
