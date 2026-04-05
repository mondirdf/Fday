import '../entities/day.dart';

class CalculateTotalStudyUseCase {
  double call(Day day) {
    return day.studies.fold<double>(0, (sum, study) => sum + study.duration);
  }
}
