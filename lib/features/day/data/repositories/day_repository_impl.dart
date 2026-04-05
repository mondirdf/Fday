import '../../domain/entities/day.dart';
import '../../domain/repositories/day_repository.dart';
import '../datasources/local_data_source.dart';
import '../models/day_model.dart';

class DayRepositoryImpl implements DayRepository {
  DayRepositoryImpl(this._localDataSource);

  final LocalDataSource _localDataSource;

  @override
  Future<void> saveDay(Day day) {
    return _localDataSource.saveDay(DayModel.fromEntity(day));
  }

  @override
  Future<Day?> getDay(String date) async {
    final model = _localDataSource.getDay(date);
    return model?.toEntity();
  }

  @override
  Future<List<Day>> getAllDays() async {
    return _localDataSource.getAllDays().map((model) => model.toEntity()).toList();
  }
}
