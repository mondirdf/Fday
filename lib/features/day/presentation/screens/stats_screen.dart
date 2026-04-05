import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../controllers/stats_controller.dart';
import '../widgets/soft_card.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key, required this.controller});

  final StatsController controller;

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  void initState() {
    super.initState();
    widget.controller.load();
    widget.controller.addListener(_rebuild);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_rebuild);
    super.dispose();
  }

  void _rebuild() => setState(() {});

  @override
  Widget build(BuildContext context) {
    if (widget.controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final stats = widget.controller.stats;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            SoftCard(child: Text('متوسط النوم (7 أيام): ${stats.avgSleep7.toStringAsFixed(1)} ساعة')),
            SoftCard(
                child: Text('متوسط النوم (30 يوم): ${stats.avgSleep30.toStringAsFixed(1)} ساعة')),
            SoftCard(
                child: Text('متوسط الدراسة (7 أيام): ${stats.avgStudy7.toStringAsFixed(1)} ساعة')),
            SoftCard(
                child: Text('متوسط الدراسة (30 يوم): ${stats.avgStudy30.toStringAsFixed(1)} ساعة')),
          ],
        ),
      ),
    );
  }
}
