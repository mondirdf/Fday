import 'package:flutter/material.dart';

import 'core/constants/app_colors.dart';
import 'core/theme/app_theme.dart';
import 'features/day/data/datasources/local_data_source.dart';
import 'features/day/data/repositories/day_repository_impl.dart';
import 'features/day/domain/usecases/calculate_sleep_duration_usecase.dart';
import 'features/day/domain/usecases/calculate_total_sleep_usecase.dart';
import 'features/day/domain/usecases/calculate_total_study_usecase.dart';
import 'features/day/domain/usecases/classify_day_usecase.dart';
import 'features/day/domain/usecases/get_all_days_usecase.dart';
import 'features/day/domain/usecases/get_day_usecase.dart';
import 'features/day/domain/usecases/get_insight_usecase.dart';
import 'features/day/domain/usecases/get_stats_usecase.dart';
import 'features/day/domain/usecases/save_day_usecase.dart';
import 'features/day/presentation/controllers/home_controller.dart';
import 'features/day/presentation/controllers/stats_controller.dart';
import 'features/day/presentation/screens/events_screen.dart';
import 'features/day/presentation/screens/home_screen.dart';
import 'features/day/presentation/screens/stats_screen.dart';
import 'features/day/presentation/screens/studies_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final localDataSource = LocalDataSource();
  await localDataSource.init();

  final repository = DayRepositoryImpl(localDataSource);
  final totalSleepUseCase = CalculateTotalSleepUseCase();
  final totalStudyUseCase = CalculateTotalStudyUseCase();

  final homeController = HomeController(
    getDayUseCase: GetDayUseCase(repository),
    saveDayUseCase: SaveDayUseCase(repository),
    calculateSleepDurationUseCase: CalculateSleepDurationUseCase(),
    classifyDayUseCase: ClassifyDayUseCase(
      totalSleepUseCase: totalSleepUseCase,
      totalStudyUseCase: totalStudyUseCase,
    ),
    getInsightUseCase: GetInsightUseCase(
      totalSleepUseCase: totalSleepUseCase,
      totalStudyUseCase: totalStudyUseCase,
    ),
  );

  final statsController = StatsController(
    getAllDaysUseCase: GetAllDaysUseCase(repository),
    getStatsUseCase: GetStatsUseCase(
      totalSleepUseCase: totalSleepUseCase,
      totalStudyUseCase: totalStudyUseCase,
    ),
  );

  runApp(
    FdayApp(
      homeController: homeController,
      statsController: statsController,
    ),
  );
}

class FdayApp extends StatelessWidget {
  const FdayApp({
    super.key,
    required this.homeController,
    required this.statsController,
  });

  final HomeController homeController;
  final StatsController statsController;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'fday',
      theme: buildAppTheme(),
      home: RootScreen(
        homeController: homeController,
        statsController: statsController,
      ),
    );
  }
}

class RootScreen extends StatefulWidget {
  const RootScreen({
    super.key,
    required this.homeController,
    required this.statsController,
  });

  final HomeController homeController;
  final StatsController statsController;

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(controller: widget.homeController),
      StatsScreen(controller: widget.statsController),
      StudiesScreen(controller: widget.statsController),
      EventsScreen(controller: widget.statsController),
    ];

    return Scaffold(
      body: pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (index) async {
          setState(() => _index = index);
          if (index > 0) {
            await widget.statsController.load();
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryText,
        unselectedItemColor: AppColors.secondaryText,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_rounded), label: 'Stats'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book_rounded), label: 'Studies'),
          BottomNavigationBarItem(icon: Icon(Icons.event_note_rounded), label: 'Events'),
        ],
      ),
    );
  }
}
