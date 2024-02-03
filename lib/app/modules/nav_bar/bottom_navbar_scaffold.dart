
// import 'package:doc_appointment/app/config/routes/named_routes.dart';
// import 'package:doc_appointment/app/config/theme/my_colors.dart';
// import 'package:doc_appointment/app/core/extensions/build_context_extension.dart';
// import 'package:doc_appointment/app/modules/nav_bar/bottom_navbar_tabs.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// class ScaffoldWithBottomNavBar extends StatefulWidget {
//   const ScaffoldWithBottomNavBar(
//       {super.key, required this.navtabs, required this.child});

//   final List<BottomNavigationBarItem> navtabs;
//   final Widget child;

//   @override
//   State<ScaffoldWithBottomNavBar> createState() =>
//       _ScaffoldWithBottomNavBarState();
// }

// class _ScaffoldWithBottomNavBarState extends State<ScaffoldWithBottomNavBar> {
//   _calculateCurrentIndex(context) {
//     final String location = GoRouterState.of(context).matchedLocation;
//     if (location.startsWith('/${MyNamedRoutes.homepage}')) {
//       return 0;
//     } else if (location.startsWith('/${MyNamedRoutes.calendar}')) {
//       return 1;
//     } else if (location.startsWith('/${MyNamedRoutes.prescription}')) {
//       return 2;
//     }
//     return 0;
//   }

//   onItemTapped(int index, BuildContext context) {
//     switch (index) {
//       case 0:
//         GoRouter.of(context).go('/${MyNamedRoutes.homepage}');
//         break;
//       case 1:
//         GoRouter.of(context).go('/${MyNamedRoutes.calendar}');
//         break;
//       case 2:
//         GoRouter.of(context).go('/${MyNamedRoutes.prescription}');
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: widget.child,
//       bottomNavigationBar: BottomNavigationBar(
//         items: BottomNavBarItem.navtabs(context),
//         backgroundColor: MyColors.secondary_500,
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: MyColors.primary_500,
//         unselectedItemColor: MyColors.greyscale_500,
//         selectedLabelStyle: context.textTheme.bodyMedium?.copyWith(
//           color: MyColors.primary_500,
//         ),
//         unselectedLabelStyle: context.textTheme.bodyMedium
//             ?.copyWith(color: MyColors.greyscale_500),
//         onTap: (index) => onItemTapped(index, context),
//         currentIndex: _calculateCurrentIndex(context),
//       ),
//     );
//   }
// }