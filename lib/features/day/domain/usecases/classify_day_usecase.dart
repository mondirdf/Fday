import '../entities/day.dart';
import 'calculate_total_sleep_usecase.dart';
import 'calculate_total_study_usecase.dart';

class ClassifyDayUseCase {
  ClassifyDayUseCase({
    required CalculateTotalSleepUseCase totalSleepUseCase,
    required CalculateTotalStudyUseCase totalStudyUseCase,
  })  : _totalSleepUseCase = totalSleepUseCase,
        _totalStudyUseCase = totalStudyUseCase;

  final CalculateTotalSleepUseCase _totalSleepUseCase;
  final CalculateTotalStudyUseCase _totalStudyUseCase;

  String call(Day day) {
    final totalSleep = _totalSleepUseCase(day);
    final totalStudy = _totalStudyUseCase(day);

    var score = 0;
    if (totalSleep >= 7 && totalSleep <= 8) score++;
    if (totalStudy >= 4) score++;
    if (day.events.isNotEmpty) score++;

    if (score <= 1) return 'ضعيف';
    if (score == 2) return 'متوسط';
    return 'جيد';
  }
}
