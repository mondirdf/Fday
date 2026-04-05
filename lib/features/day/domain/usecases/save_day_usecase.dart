import '../entities/day.dart';
import '../repositories/day_repository.dart';

class SaveDayUseCase {
  SaveDayUseCase(this._repository);

  final DayRepository _repository;

  Future<void> call(Day day) {
    return _repository.saveDay(day);
  }
}
