import 'package:hive_flutter/hive_flutter.dart';

import '../models/day_model.dart';

class LocalDataSource {
  static const boxName = 'days_box';

  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<Map>(boxName);
  }

  Box<Map> get _box => Hive.box<Map>(boxName);

  Future<void> saveDay(DayModel model) async {
    await _box.put(model.date, model.toMap());
  }

  DayModel? getDay(String date) {
    final raw = _box.get(date);
    if (raw == null) return null;
    return DayModel.fromMap(raw.cast<String, dynamic>());
  }

  List<DayModel> getAllDays() {
    final result = _box.values
        .map((raw) => DayModel.fromMap(raw.cast<String, dynamic>()))
        .toList();

    result.sort((a, b) => b.date.compareTo(a.date));
    return result;
  }
}
