import 'package:flutter/material.dart';

import '../../domain/entities/day.dart';
import '../../domain/usecases/get_all_days_usecase.dart';
import '../../domain/usecases/get_stats_usecase.dart';

class StatsController extends ChangeNotifier {
  StatsController({
    required GetAllDaysUseCase getAllDaysUseCase,
    required GetStatsUseCase getStatsUseCase,
  })  : _getAllDaysUseCase = getAllDaysUseCase,
        _getStatsUseCase = getStatsUseCase;

  final GetAllDaysUseCase _getAllDaysUseCase;
  final GetStatsUseCase _getStatsUseCase;

  bool _loading = true;
  List<Day> _days = [];
  StatsResult _stats =
      const StatsResult(avgSleep7: 0, avgSleep30: 0, avgStudy7: 0, avgStudy30: 0);

  bool get isLoading => _loading;
  List<Day> get days => _days;
  StatsResult get stats => _stats;

  Future<void> load() async {
    _loading = true;
    notifyListeners();

    _days = await _getAllDaysUseCase();
    _stats = _getStatsUseCase(_days);

    _loading = false;
    notifyListeners();
  }
}
