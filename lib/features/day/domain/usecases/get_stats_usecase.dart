import '../entities/day.dart';
import 'calculate_total_sleep_usecase.dart';
import 'calculate_total_study_usecase.dart';

class StatsResult {
  const StatsResult({
    required this.avgSleep7,
    required this.avgSleep30,
    required this.avgStudy7,
    required this.avgStudy30,
  });

  final double avgSleep7;
  final double avgSleep30;
  final double avgStudy7;
  final double avgStudy30;
}

class GetStatsUseCase {
  GetStatsUseCase({
    required CalculateTotalSleepUseCase totalSleepUseCase,
    required CalculateTotalStudyUseCase totalStudyUseCase,
  })  : _totalSleepUseCase = totalSleepUseCase,
        _totalStudyUseCase = totalStudyUseCase;

  final CalculateTotalSleepUseCase _totalSleepUseCase;
  final CalculateTotalStudyUseCase _totalStudyUseCase;

  StatsResult call(List<Day> days) {
    double avgSleep(int count) {
      final target = days.take(count).toList();
      if (target.isEmpty) return 0;
      final sum = target.fold<double>(0, (acc, day) => acc + _totalSleepUseCase(day));
      return sum / target.length;
    }

    double avgStudy(int count) {
      final target = days.take(count).toList();
      if (target.isEmpty) return 0;
      final sum = target.fold<double>(0, (acc, day) => acc + _totalStudyUseCase(day));
      return sum / target.length;
    }

    return StatsResult(
      avgSleep7: avgSleep(7),
      avgSleep30: avgSleep(30),
      avgStudy7: avgStudy(7),
      avgStudy30: avgStudy(30),
    );
  }
}
