import '../../domain/entities/day.dart';
import '../../domain/entities/sleep.dart';
import '../../domain/entities/study.dart';

class DayModel {
  const DayModel({
    required this.date,
    required this.sleep,
    required this.studies,
    required this.events,
  });

  final String date;
  final Map<String, dynamic> sleep;
  final List<Map<String, dynamic>> studies;
  final List<String> events;

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'sleep': sleep,
      'studies': studies,
      'events': events,
    };
  }

  factory DayModel.fromMap(Map<String, dynamic> map) {
    final studiesRaw = map['studies'] as List<dynamic>? ?? [];
    final eventsRaw = map['events'] as List<dynamic>? ?? [];
    return DayModel(
      date: map['date'] as String? ?? '',
      sleep: (map['sleep'] as Map?)?.cast<String, dynamic>() ?? {},
      studies: studiesRaw
          .whereType<Map>()
          .map((e) => e.cast<String, dynamic>())
          .toList(),
      events: eventsRaw.map((e) => e.toString()).toList(),
    );
  }

  factory DayModel.fromEntity(Day entity) {
    return DayModel(
      date: entity.date,
      sleep: {
        'main': {
          'sleepTime': entity.sleep.main.sleepTime,
          'wakeTime': entity.sleep.main.wakeTime,
          'duration': entity.sleep.main.duration,
        },
        'naps': entity.sleep.naps
            .map((nap) => {
                  'start': nap.start,
                  'duration': nap.duration,
                })
            .toList(),
      },
      studies: entity.studies
          .map((study) => {
                'subject': study.subject,
                'duration': study.duration,
              })
          .toList(),
      events: entity.events,
    );
  }

  Day toEntity() {
    final main = (sleep['main'] as Map?)?.cast<String, dynamic>() ?? {};
    final napsRaw = sleep['naps'] as List<dynamic>? ?? [];

    return Day(
      date: date,
      sleep: Sleep(
        main: MainSleep(
          sleepTime: main['sleepTime'] as String? ?? '23:00',
          wakeTime: main['wakeTime'] as String? ?? '07:00',
          duration: (main['duration'] as num?)?.toDouble() ?? 8,
        ),
        naps: napsRaw
            .whereType<Map>()
            .map((nap) => nap.cast<String, dynamic>())
            .map(
              (nap) => Nap(
                start: nap['start'] as String? ?? '13:00',
                duration: (nap['duration'] as num?)?.toDouble() ?? 0,
              ),
            )
            .toList(),
      ),
      studies: studies
          .map(
            (study) => Study(
              subject: study['subject'] as String? ?? '',
              duration: (study['duration'] as num?)?.toDouble() ?? 0,
            ),
          )
          .toList(),
      events: events,
    );
  }
}
