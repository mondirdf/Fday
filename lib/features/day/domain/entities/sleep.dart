class MainSleep {
  const MainSleep({
    required this.sleepTime,
    required this.wakeTime,
    required this.duration,
  });

  final String sleepTime;
  final String wakeTime;
  final double duration;

  MainSleep copyWith({
    String? sleepTime,
    String? wakeTime,
    double? duration,
  }) {
    return MainSleep(
      sleepTime: sleepTime ?? this.sleepTime,
      wakeTime: wakeTime ?? this.wakeTime,
      duration: duration ?? this.duration,
    );
  }
}

class Nap {
  const Nap({required this.start, required this.duration});

  final String start;
  final double duration;

  Nap copyWith({String? start, double? duration}) {
    return Nap(
      start: start ?? this.start,
      duration: duration ?? this.duration,
    );
  }
}

class Sleep {
  const Sleep({required this.main, required this.naps});

  final MainSleep main;
  final List<Nap> naps;

  Sleep copyWith({MainSleep? main, List<Nap>? naps}) {
    return Sleep(
      main: main ?? this.main,
      naps: naps ?? this.naps,
    );
  }
}
