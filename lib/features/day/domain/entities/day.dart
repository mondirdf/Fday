import 'sleep.dart';
import 'study.dart';

class Day {
  const Day({
    required this.date,
    required this.sleep,
    required this.studies,
    required this.events,
  });

  final String date;
  final Sleep sleep;
  final List<Study> studies;
  final List<String> events;

  factory Day.empty(String date) {
    return Day(
      date: date,
      sleep: const Sleep(
        main: MainSleep(sleepTime: '23:00', wakeTime: '07:00', duration: 8),
        naps: [],
      ),
      studies: const [],
      events: const [],
    );
  }

  Day copyWith({
    String? date,
    Sleep? sleep,
    List<Study>? studies,
    List<String>? events,
  }) {
    return Day(
      date: date ?? this.date,
      sleep: sleep ?? this.sleep,
      studies: studies ?? this.studies,
      events: events ?? this.events,
    );
  }
}
