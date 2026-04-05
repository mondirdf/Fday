import '../entities/day.dart';
import '../repositories/day_repository.dart';

class GetDayUseCase {
  GetDayUseCase(this._repository);

  final DayRepository _repository;

  Future<Day?> call(String date) {
    return _repository.getDay(date);
  }
}
