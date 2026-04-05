class Study {
  const Study({required this.subject, required this.duration});

  final String subject;
  final double duration;

  Study copyWith({String? subject, double? duration}) {
    return Study(
      subject: subject ?? this.subject,
      duration: duration ?? this.duration,
    );
  }
}
