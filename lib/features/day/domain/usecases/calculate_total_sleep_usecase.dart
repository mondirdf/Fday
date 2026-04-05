import '../entities/day.dart';

class CalculateTotalSleepUseCase {
  double call(Day day) {
    final naps = day.sleep.naps.fold<double>(0, (sum, nap) => sum + nap.duration);
    return day.sleep.main.duration + naps;
  }
}
