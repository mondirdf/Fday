import '../entities/day.dart';
import 'calculate_total_sleep_usecase.dart';
import 'calculate_total_study_usecase.dart';

class GetInsightUseCase {
  GetInsightUseCase({
    required CalculateTotalSleepUseCase totalSleepUseCase,
    required CalculateTotalStudyUseCase totalStudyUseCase,
  })  : _totalSleepUseCase = totalSleepUseCase,
        _totalStudyUseCase = totalStudyUseCase;

  final CalculateTotalSleepUseCase _totalSleepUseCase;
  final CalculateTotalStudyUseCase _totalStudyUseCase;

  String call(Day day) {
    final totalSleep = _totalSleepUseCase(day);
    final totalStudy = _totalStudyUseCase(day);

    if (totalSleep < 6) return 'نومك قليل';
    if (totalStudy < 2) return 'الدراسة ضعيفة';
    if (totalSleep >= 7 && totalStudy >= 4) return 'يوم ممتاز';
    return 'يوم عادي';
  }
}
