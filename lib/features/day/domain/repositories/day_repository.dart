import '../entities/day.dart';

abstract class DayRepository {
  Future<void> saveDay(Day day);
  Future<Day?> getDay(String date);
  Future<List<Day>> getAllDays();
}
