import 'package:doc_appointment/app/config/routes/named_routes.dart';
import 'package:doc_appointment/app/modules/auth/views/signup_doctor.dart';
import 'package:doc_appointment/app/modules/auth/views/signup_patient.dart';
import 'package:doc_appointment/app/modules/nav_bar/bottom_navbar_scaffold.dart';
import 'package:doc_appointment/app/modules/nav_bar/bottom_navbar_tabs.dart';
import 'package:doc_appointment/app/modules/views/calendar_screen.dart';
import 'package:doc_appointment/app/modules/views/home_page.dart';
import 'package:doc_appointment/app/modules/auth/views/login_screen.dart';
import 'package:doc_appointment/app/modules/views/prescription.dart';
import 'package:doc_appointment/app/modules/auth/views/splash.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

///[rootNavigatorKey] used for global | general navigation
final rootNavigatorKey = GlobalKey<NavigatorState>();
final form = GlobalKey<FormState>();
final shellRouteKey = GlobalKey<NavigatorState>();

abstract class AppRouter {
  static Widget errorWidget(BuildContext context, GoRouterState state) =>
      const SizedBox();

  /// use this in [MaterialApp.router]
  static final _router = GoRouter(
    initialLocation: MyNamedRoutes.root,
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      // outside the [ShellRoute] to make the screen on top of the [BottomNavBar]
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: MyNamedRoutes.root,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: "/${MyNamedRoutes.login}",
        name: MyNamedRoutes.login,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: LoginScreen(),
        ),
      ),

      ShellRoute(
        navigatorKey: shellRouteKey,
        builder: (context, state, child) {
          return ScaffoldWithBottomNavBar(
            navtabs: BottomNavBarItem.navtabs(context),
            child: child,
          );
        },
        routes: [
          GoRoute(
            // parentNavigatorKey: rootNavigatorKey,
            path: "/${MyNamedRoutes.homepage}",
            name: MyNamedRoutes.homepage,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const HomeScreen(),
            ),
          ),

          /// home route
          GoRoute(
            path: "/${MyNamedRoutes.calendar}",
            name: MyNamedRoutes.calendar,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: CalendarScreen(),
            ),
          ),

          GoRoute(
            path: "/${MyNamedRoutes.signupPatient}",
            name: MyNamedRoutes.signupPatient,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: PatientSignup(),
            ),
          ),

           GoRoute(
            path: "/${MyNamedRoutes.signupDoctor}",
            name: MyNamedRoutes.signupDoctor,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: DoctorSignup()),
            ),
          /// location route
          GoRoute(
            path: "/${MyNamedRoutes.prescription}",
            name: MyNamedRoutes.prescription,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: PrescriptionScreen(),
            ),
          ),
        ],
      ),
    ],
    errorBuilder: errorWidget,
  );

  static GoRouter get router => _router;
}
