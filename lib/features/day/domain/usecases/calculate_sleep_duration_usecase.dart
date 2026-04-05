class CalculateSleepDurationUseCase {
  double call(String sleepTime, String wakeTime) {
    final sleepParts = sleepTime.split(':');
    final wakeParts = wakeTime.split(':');

    if (sleepParts.length != 2 || wakeParts.length != 2) return 0;

    final sleepMinutes =
        (int.tryParse(sleepParts[0]) ?? 0) * 60 + (int.tryParse(sleepParts[1]) ?? 0);
    var wakeMinutes =
        (int.tryParse(wakeParts[0]) ?? 0) * 60 + (int.tryParse(wakeParts[1]) ?? 0);

    if (wakeMinutes < sleepMinutes) {
      wakeMinutes += 24 * 60;
    }

    return (wakeMinutes - sleepMinutes) / 60;
  }
}
