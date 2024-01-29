import 'package:doc_appointment/app/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';

abstract class BottomNavBarItem {
  static List<BottomNavigationBarItem> navtabs(BuildContext context) {
    return [
      BottomNavigationBarItem(
        icon: const Icon(Icons.home_filled),
        label: context.translate.home,
        activeIcon: const Icon(
          Icons.home_outlined,
        ),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.calculate_sharp),
        label: context.translate.calendar,
        activeIcon: Icon(Icons.calendar_month),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.media_bluetooth_off),
        label: context.translate.prescription,
        activeIcon: Icon(Icons.medication_outlined),
      ),
    ];
  }
}
