import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/date_utils.dart';
import '../controllers/home_controller.dart';
import '../widgets/soft_button.dart';
import '../widgets/soft_card.dart';
import '../widgets/soft_input.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.controller});

  final HomeController controller;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    widget.controller.loadToday();
    widget.controller.addListener(_rebuild);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_rebuild);
    super.dispose();
  }

  void _rebuild() => setState(() {});

  Future<void> _pickTime({required bool sleep}) async {
    final value = sleep
        ? widget.controller.day.sleep.main.sleepTime
        : widget.controller.day.sleep.main.wakeTime;
    final parts = value.split(':');

    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: int.tryParse(parts[0]) ?? 23,
        minute: int.tryParse(parts[1]) ?? 0,
      ),
      builder: (_, child) => Directionality(
        textDirection: TextDirection.rtl,
        child: child!,
      ),
    );

    if (picked == null) return;
    final formatted =
        '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';

    if (sleep) {
      await widget.controller.updateSleepTime(formatted);
    } else {
      await widget.controller.updateWakeTime(formatted);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.controller.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final day = widget.controller.day;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SoftCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppDateUtils.formatArabicDate(DateTime.now()),
                        style: const TextStyle(color: AppColors.secondaryText),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'التصنيف: ${widget.controller.classification}',
                        style: const TextStyle(
                          color: AppColors.primaryText,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.controller.insight,
                        style: const TextStyle(color: AppColors.secondaryText),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                const Text('النوم', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SoftCard(
                  child: Row(
                    children: [
                      Expanded(
                        child: SoftButton(
                          label: 'وقت النوم: ${day.sleep.main.sleepTime}',
                          onTap: () => _pickTime(sleep: true),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: SoftButton(
                          label: 'وقت الاستيقاظ: ${day.sleep.main.wakeTime}',
                          onTap: () => _pickTime(sleep: false),
                        ),
                      ),
                    ],
                  ),
                ),
                const Text('القيلولة', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ...day.sleep.naps.asMap().entries.map((entry) {
                  final index = entry.key;
                  final nap = entry.value;
                  return SoftCard(
                    child: Row(
                      children: [
                        Expanded(
                          child: SoftInput(
                            controller: TextEditingController(text: nap.start),
                            hint: 'بداية HH:MM',
                            onChanged: (v) => widget.controller.updateNapStart(index, v),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: SoftInput(
                            controller: TextEditingController(text: nap.duration.toString()),
                            hint: 'المدة (ساعة)',
                            keyboardType:
                                const TextInputType.numberWithOptions(decimal: true),
                            onChanged: (v) => widget.controller.updateNapDuration(index, v),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                SoftButton(label: '+ إضافة قيلولة', onTap: widget.controller.addNap),
                const SizedBox(height: 8),
                const Text('الدراسة', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ...day.studies.asMap().entries.map((entry) {
                  final index = entry.key;
                  final study = entry.value;
                  return SoftCard(
                    child: Row(
                      children: [
                        Expanded(
                          child: SoftInput(
                            controller: TextEditingController(text: study.subject),
                            hint: 'المادة',
                            onChanged: (v) => widget.controller.updateStudySubject(index, v),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: SoftInput(
                            controller: TextEditingController(text: study.duration.toString()),
                            hint: 'المدة (ساعة)',
                            keyboardType:
                                const TextInputType.numberWithOptions(decimal: true),
                            onChanged: (v) => widget.controller.updateStudyDuration(index, v),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                SoftButton(label: '+ إضافة دراسة', onTap: widget.controller.addStudy),
                const SizedBox(height: 8),
                const Text('الأحداث', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                ...day.events.asMap().entries.map((entry) {
                  final index = entry.key;
                  return SoftCard(
                    child: SoftInput(
                      controller: TextEditingController(text: entry.value),
                      hint: 'اكتب الحدث',
                      onChanged: (v) => widget.controller.updateEvent(index, v),
                    ),
                  );
                }),
                SoftButton(label: '+ إضافة حدث', onTap: widget.controller.addEvent),
                const SizedBox(height: 16),
                SoftButton(label: 'حفظ', onTap: widget.controller.save),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
