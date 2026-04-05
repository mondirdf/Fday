import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../controllers/stats_controller.dart';
import '../widgets/soft_card.dart';

class StudiesScreen extends StatelessWidget {
  const StudiesScreen({super.key, required this.controller});

  final StatsController controller;

  @override
  Widget build(BuildContext context) {
    final days = controller.days;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: days
              .where((day) => day.studies.isNotEmpty)
              .map(
                (day) => SoftCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        day.date,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      ...day.studies.map((s) => Text('${s.subject}: ${s.duration} ساعة')),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
