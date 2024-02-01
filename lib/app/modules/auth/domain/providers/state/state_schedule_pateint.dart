import 'package:flutter_riverpod/flutter_riverpod.dart';

class SchedulePatientNotifier extends StateNotifier<SchedulePatientState> {
  SchedulePatientNotifier() : super(SchedulePatientState());

  void setIssues(String value) {
    state = state.copyWith(issues: value);
  }

  void setPrefDays(String value) {
    state = state.copyWith(prefDays: value);
  }

  void setPrefTime(String value) {
    state = state.copyWith(prefTime: value);
  }

  void setPrefArea(String value) {
    state = state.copyWith(prefArea: value);
  }
}

class SchedulePatientState {
  String issues = "What is your issue?";
  List<String> issuesList = <String>[
    'What is your issue?',
    'Orthopedics',
    'Cardiology',
    'Ophthalmology',
    'Gastroenterology',
    'Dermatology'
  ];
  String prefDays = "Preferred Days of Week ?";
  List<String> daysList = <String>[
    'Preferred Days of Week ?',
    'Weekends',
    'Weekdays',
  ];
  String prefTime = "Preferred time?";
  List<String> timeList = <String>[
    'Preferred time?',
    'Evening',
    'Morning',
    'Afternoon'
  ];

  String prefArea = "Preferred area?";
  List<String> areaList = <String>[
    'Preferred area?',
    'Jahra',
    'Assima',
    'Hawally'
  ];

  List<Map<String, dynamic>> filtered = []; // Add this line

  SchedulePatientState copyWith({
    String? issues,
    List<String>? issuesList,
    String? prefDays,
    List<String>? daysList,
    String? prefTime,
    List<String>? timeList,
    String? prefArea,
    List<String>? areaList,
    List<Map<String, dynamic>>? filtered,
  }) {
    return SchedulePatientState()
      ..issues = issues ?? this.issues
      ..issuesList = issuesList ?? this.issuesList
      ..prefDays = prefDays ?? this.prefDays
      ..daysList = daysList ?? this.daysList
      ..prefTime = prefTime ?? this.prefTime
      ..timeList = timeList ?? this.timeList
      ..prefArea = prefArea ?? this.prefArea
      ..areaList = areaList ?? this.areaList
      ..filtered = filtered ?? this.filtered;
  }
}

final schedulePatientProvider =
    StateNotifierProvider<SchedulePatientNotifier, SchedulePatientState>(
        (ref) => SchedulePatientNotifier());
