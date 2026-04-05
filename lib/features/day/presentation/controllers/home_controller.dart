import 'package:flutter/material.dart';

import '../../../../core/utils/date_utils.dart';
import '../../domain/entities/day.dart';
import '../../domain/entities/sleep.dart';
import '../../domain/entities/study.dart';
import '../../domain/usecases/calculate_sleep_duration_usecase.dart';
import '../../domain/usecases/classify_day_usecase.dart';
import '../../domain/usecases/get_day_usecase.dart';
import '../../domain/usecases/get_insight_usecase.dart';
import '../../domain/usecases/save_day_usecase.dart';

class HomeController extends ChangeNotifier {
  HomeController({
    required GetDayUseCase getDayUseCase,
    required SaveDayUseCase saveDayUseCase,
    required CalculateSleepDurationUseCase calculateSleepDurationUseCase,
    required ClassifyDayUseCase classifyDayUseCase,
    required GetInsightUseCase getInsightUseCase,
  })  : _getDayUseCase = getDayUseCase,
        _saveDayUseCase = saveDayUseCase,
        _calculateSleepDurationUseCase = calculateSleepDurationUseCase,
        _classifyDayUseCase = classifyDayUseCase,
        _getInsightUseCase = getInsightUseCase;

  final GetDayUseCase _getDayUseCase;
  final SaveDayUseCase _saveDayUseCase;
  final CalculateSleepDurationUseCase _calculateSleepDurationUseCase;
  final ClassifyDayUseCase _classifyDayUseCase;
  final GetInsightUseCase _getInsightUseCase;

  Day _day = Day.empty(AppDateUtils.todayKey());
  bool _loading = true;

  Day get day => _day;
  bool get isLoading => _loading;
  String get classification => _classifyDayUseCase(_day);
  String get insight => _getInsightUseCase(_day);

  Future<void> loadToday() async {
    _loading = true;
    notifyListeners();

    final date = AppDateUtils.todayKey();
    _day = await _getDayUseCase(date) ?? Day.empty(date);
    _day = _rebuildMainSleepDuration(_day);

    _loading = false;
    notifyListeners();
  }

  Future<void> updateSleepTime(String value) async {
    final main = _day.sleep.main.copyWith(sleepTime: value);
    _day = _day.copyWith(sleep: _day.sleep.copyWith(main: main));
    _day = _rebuildMainSleepDuration(_day);
    await save();
  }

  Future<void> updateWakeTime(String value) async {
    final main = _day.sleep.main.copyWith(wakeTime: value);
    _day = _day.copyWith(sleep: _day.sleep.copyWith(main: main));
    _day = _rebuildMainSleepDuration(_day);
    await save();
  }

  Future<void> addNap() async {
    final naps = [..._day.sleep.naps, const Nap(start: '13:00', duration: 0)];
    _day = _day.copyWith(sleep: _day.sleep.copyWith(naps: naps));
    await save();
  }

  Future<void> updateNapStart(int index, String value) async {
    final naps = [..._day.sleep.naps];
    naps[index] = naps[index].copyWith(start: value);
    _day = _day.copyWith(sleep: _day.sleep.copyWith(naps: naps));
    await save();
  }

  Future<void> updateNapDuration(int index, String value) async {
    final naps = [..._day.sleep.naps];
    naps[index] = naps[index].copyWith(duration: double.tryParse(value) ?? 0);
    _day = _day.copyWith(sleep: _day.sleep.copyWith(naps: naps));
    await save();
  }

  Future<void> addStudy() async {
    final studies = [..._day.studies, const Study(subject: '', duration: 0)];
    _day = _day.copyWith(studies: studies);
    await save();
  }

  Future<void> updateStudySubject(int index, String value) async {
    final studies = [..._day.studies];
    studies[index] = studies[index].copyWith(subject: value);
    _day = _day.copyWith(studies: studies);
    await save();
  }

  Future<void> updateStudyDuration(int index, String value) async {
    final studies = [..._day.studies];
    studies[index] = studies[index].copyWith(duration: double.tryParse(value) ?? 0);
    _day = _day.copyWith(studies: studies);
    await save();
  }

  Future<void> addEvent() async {
    _day = _day.copyWith(events: [..._day.events, '']);
    await save();
  }

  Future<void> updateEvent(int index, String value) async {
    final events = [..._day.events];
    events[index] = value;
    _day = _day.copyWith(events: events);
    await save();
  }

  Future<void> save() async {
    await _saveDayUseCase(_day);
    notifyListeners();
  }

  Day _rebuildMainSleepDuration(Day input) {
    final duration = _calculateSleepDurationUseCase(
      input.sleep.main.sleepTime,
      input.sleep.main.wakeTime,
    );
    final main = input.sleep.main.copyWith(duration: duration);
    return input.copyWith(sleep: input.sleep.copyWith(main: main));
  }
}
