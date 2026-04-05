import '../entities/day.dart';
import '../repositories/day_repository.dart';

class GetAllDaysUseCase {
  GetAllDaysUseCase(this._repository);

  final DayRepository _repository;

  Future<List<Day>> call() {
    return _repository.getAllDays();
  }
}
