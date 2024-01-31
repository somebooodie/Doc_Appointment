import 'package:doc_appointment/app/config/routes/named_routes.dart';

import 'package:doc_appointment/app/modules/nav_bar/doc_bottom_navbar.dart';
import 'package:doc_appointment/app/modules/nav_bar/pat_bottom_nav.dart';
import 'package:doc_appointment/app/modules/nav_bar/bottom_navbar_tabs.dart';

import 'package:doc_appointment/app/modules/views/FAQ/faq_doc.dart';
import 'package:doc_appointment/app/modules/views/FAQ/faq_patient.dart';
import 'package:doc_appointment/app/modules/views/Schedule/schedule_doc.dart';
import 'package:doc_appointment/app/modules/views/Schedule/schedule_patient.dart';
import 'package:doc_appointment/app/modules/views/calendar/doc_calendar_screen.dart';

import 'package:doc_appointment/app/modules/views/calendar/patient_calendar_screen.dart';
import 'package:doc_appointment/app/modules/views/doc_homescreen.dart';
import 'package:doc_appointment/app/modules/views/doc_register.dart';
import 'package:doc_appointment/app/modules/views/login_screen_doc.dart';
import 'package:doc_appointment/app/modules/views/login_screen_patient.dart';
import 'package:doc_appointment/app/modules/views/medication/MD_doc_page.dart';
import 'package:doc_appointment/app/modules/views/medication/MD_patient_page.dart';
import 'package:doc_appointment/app/modules/views/medication/meds_DocAdd_page.dart';
import 'package:doc_appointment/app/modules/views/medication/prescription_doc_page.dart';
import 'package:doc_appointment/app/modules/views/patient_homescreen.dart';
import 'package:doc_appointment/app/modules/views/patient_register_screen.dart';
import 'package:doc_appointment/app/modules/views/profile_page.dart';
import 'package:doc_appointment/app/modules/views/splash.dart';
import 'package:doc_appointment/app/modules/views/medication/med_detail_page.dart';
import 'package:doc_appointment/app/modules/views/medication/meds_patient_page.dart';
import 'package:doc_appointment/app/modules/views/medication/presription_patient_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

///[rootNavigatorKey] used for global | general navigation
final rootNavigatorKey = GlobalKey<NavigatorState>();
final form = GlobalKey<FormState>();
final shellRouteKey = GlobalKey<NavigatorState>();
final shellDocRouteKey = GlobalKey<NavigatorState>();

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
        path: "/${MyNamedRoutes.docRegister}",
        name: MyNamedRoutes.docRegister,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: DocRegisterScreen(),
        ),
      ),
      GoRoute(
        path: "/${MyNamedRoutes.patientRegister}",
        name: MyNamedRoutes.patientRegister,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: PatientRegisterScreen(),
        ),
      ),

      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: "/${MyNamedRoutes.patientlogin}",
        name: MyNamedRoutes.patientlogin,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: LoginScreen(),
        ),
      ),

      GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: "/${MyNamedRoutes.doclogin}",
        name: MyNamedRoutes.doclogin,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: doclogin(),
        ),
      ),

      //Doctor tabs and view
      //please focus, tis is only for doctor view home, paths only

      ShellRoute(
        navigatorKey: shellDocRouteKey,
        builder: (context, state, child) {
          return DocScaffoldWithBottomNavBar(
            navtabs: BottomNavBarItem.navtabs(context),
            child: child,
          );
        },
        routes: [
          GoRoute(
              parentNavigatorKey: shellDocRouteKey,
              path: "/${MyNamedRoutes.docHomeScreen}",
              name: MyNamedRoutes.docHomeScreen,
              pageBuilder: (context, state) => NoTransitionPage(
                    key: state.pageKey,
                    child: DocHomeScreen(),
                  ),
              //add path to Doc home screen
              routes: [
                GoRoute(
                  parentNavigatorKey: shellDocRouteKey,
                  path: "${MyNamedRoutes.drFAQ}",
                  name: MyNamedRoutes.drFAQ,
                  pageBuilder: (context, state) => NoTransitionPage(
                    key: state.pageKey,
                    child: faqDoctor(),
                  ),
                ),
                GoRoute(
                  parentNavigatorKey: shellDocRouteKey,
                  path: "${MyNamedRoutes.scheduleDoctor}",
                  name: MyNamedRoutes.scheduleDoctor,
                  pageBuilder: (context, state) => NoTransitionPage(
                    key: state.pageKey,
                    child: scheduleDoctor(),
                  ),
                ),
                GoRoute(
                  parentNavigatorKey: shellDocRouteKey,
                  path: "${MyNamedRoutes.profile}",
                  name: MyNamedRoutes.profile,
                  pageBuilder: (context, state) => NoTransitionPage(
                    key: state.pageKey,
                    child: ProfileScreen(),
                  ),
                ),
              ]),
          GoRoute(
            parentNavigatorKey: shellDocRouteKey,
            path: "/${MyNamedRoutes.docCalendarScreen}",
            name: MyNamedRoutes.docCalendarScreen,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: DoctorCalendarScreen(),
            ),
            // routes: [

            // ],
          ),
          GoRoute(
            parentNavigatorKey: shellDocRouteKey,
            path: "/${MyNamedRoutes.mdDocPage}",
            name: MyNamedRoutes.mdDocPage,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: mdDocPage(),
            ),
            routes: [
              GoRoute(
                parentNavigatorKey: shellDocRouteKey,
                path: "${MyNamedRoutes.medDocAdd}",
                name: MyNamedRoutes.medDocAdd,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: medDocAdd(),
                ),
              ),
              GoRoute(
                parentNavigatorKey: shellDocRouteKey,
                path: "${MyNamedRoutes.prescriptionDocPage}",
                name: MyNamedRoutes.prescriptionDocPage,
                pageBuilder: (context, state) => NoTransitionPage(
                  key: state.pageKey,
                  child: prescriptionDocPage(),
                ),
              ),
            ],
          ),
        ],
      ),

//end of doctor view

//Patient view only
//repeat, this is patient view only [homescreen, calendar, etc....]

      ShellRoute(
        navigatorKey: shellRouteKey,
        builder: (context, state, child) {
          return PatiantScaffoldWithBottomNavBar(
            navtabs: BottomNavBarItem.navtabs(context),
            child: child,
          );
        },
        routes: [
          GoRoute(
              // parentNavigatorKey: rootNavigatorKey,
              path: "/${MyNamedRoutes.patientHomeScreen}",
              name: MyNamedRoutes.patientHomeScreen,
              pageBuilder: (context, state) => NoTransitionPage(
                    key: state.pageKey,
                    child: patientHomeScreen(),
                  ),
              routes: []),

          /// home route
          GoRoute(
              path: "/${MyNamedRoutes.patientCalendarScreen}",
              name: MyNamedRoutes.patientCalendarScreen,
              pageBuilder: (context, state) => NoTransitionPage(
                    key: state.pageKey,
                    child: PatientCalendarScreen(),
                  ),
              routes: []),

          /// location route
          GoRoute(
            path: "/${MyNamedRoutes.mdPatientPage}",
            name: MyNamedRoutes.mdPatientPage,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: mdPatientPage(),
            ),
          ),
          GoRoute(
            path: "/${MyNamedRoutes.medDetail}",
            name: MyNamedRoutes.medDetail,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: medDetail(),
            ),
          ),
          GoRoute(
            path: "/${MyNamedRoutes.medBoxPage}",
            name: MyNamedRoutes.medBoxPage,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: medBoxPage(),
            ),
          ),
          GoRoute(
            path: "/${MyNamedRoutes.prescriptionPatientPage}",
            name: MyNamedRoutes.prescriptionPatientPage,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: prescriptionPatientPage(),
            ),
          ),
          GoRoute(
            path: "/${MyNamedRoutes.faqPatient}",
            name: MyNamedRoutes.faqPatient,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: faqPatient(),
            ),
          ),
          GoRoute(
            path: "/${MyNamedRoutes.schedulePatient}",
            name: MyNamedRoutes.schedulePatient,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const schedulePatient(),
            ),
          ),
        ],
      ),

      //end of patient view
    ],
    errorBuilder: errorWidget,
  );

  static GoRouter get router => _router;
}
