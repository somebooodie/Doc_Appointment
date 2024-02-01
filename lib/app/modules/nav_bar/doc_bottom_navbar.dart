import 'package:doc_appointment/app/config/routes/named_routes.dart';
import 'package:doc_appointment/app/config/theme/my_colors.dart';
import 'package:doc_appointment/app/core/extensions/build_context_extension.dart';
import 'package:doc_appointment/app/modules/nav_bar/bottom_navbar_tabs.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DocScaffoldWithBottomNavBar extends StatefulWidget {
  const DocScaffoldWithBottomNavBar(
      {super.key, required this.navtabs, required this.child});

  final List<BottomNavigationBarItem> navtabs;
  final Widget child;

  @override
  State<DocScaffoldWithBottomNavBar> createState() =>
      _ScaffoldWithBottomNavBarState();
}

class _ScaffoldWithBottomNavBarState
    extends State<DocScaffoldWithBottomNavBar> {
  int _calculateCurrentIndex(context) {
    final String location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith('/${MyNamedRoutes.docHomeScreen}')) {
      return 0;
    } else if (location.startsWith('/${MyNamedRoutes.docCalendarScreen}')) {
      return 1;
    } else if (location.startsWith('/${MyNamedRoutes.mdDocPage}')) {
      return 2;
    }
    return 0;
  }

  void onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go('/${MyNamedRoutes.docHomeScreen}');
        break;
      case 1:
        GoRouter.of(context).go('/${MyNamedRoutes.docCalendarScreen}');
        break;
      case 2:
        GoRouter.of(context).go('/${MyNamedRoutes.mdDocPage}');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool shouldShowNavBar = !GoRouterState.of(context)
            .matchedLocation
            .startsWith('/${MyNamedRoutes.signupPatient}') &&
        !GoRouterState.of(context)
            .matchedLocation
            .startsWith('/${MyNamedRoutes.signupDoctor}') &&
        !GoRouterState.of(context)
            .matchedLocation
            .startsWith('/${MyNamedRoutes.patientlogin}') &&
        !GoRouterState.of(context)
            .matchedLocation
            .startsWith('/${MyNamedRoutes.doclogin}');
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: shouldShowNavBar
          ? BottomNavigationBar(
              items: BottomNavBarItem.navtabs(context),
              backgroundColor: MyColors.secondary_500,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: MyColors.primary_500,
              unselectedItemColor: MyColors.greyscale_500,
              selectedLabelStyle: context.textTheme.bodyMedium?.copyWith(
                color: MyColors.primary_500,
              ),
              unselectedLabelStyle: context.textTheme.bodyMedium
                  ?.copyWith(color: MyColors.greyscale_500),
              onTap: (index) => onItemTapped(index, context),
              currentIndex: _calculateCurrentIndex(context),
            )
          : null,
    );
  }
}
