import 'package:flutter/material.dart';
import 'package:gym_adhd/config/colors.dart';
import 'package:gym_adhd/config/isar_config.dart';
import 'package:gym_adhd/config/routes.dart';
import 'package:gym_adhd/providers/training_sessions_provider.dart';
import 'package:gym_adhd/screens/sessions_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initIsar();
  await importExercisesIfNeeded();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => TrainingSessionsProvider())],
      builder: (context, _) {
        return MaterialApp(
          routes: routes,
          home: const SessionsScreen(),
          theme: ThemeData(
            useMaterial3: false,
            brightness: Brightness.dark,
            canvasColor: AppColors.black,
            primaryColor: AppColors.fitGreen,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.fitGreen,
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.fitGreen),
                foregroundColor: AppColors.fitGreen,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: AppColors.black88,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.fitGreen),
              ),
              labelStyle: const TextStyle(color: AppColors.fitGreen),
              hintStyle: const TextStyle(color: AppColors.grayBlue),
              suffixIconColor: AppColors.fitGreen40,
            ),
            datePickerTheme: DatePickerThemeData(
              backgroundColor: AppColors.black,
              headerBackgroundColor: AppColors.fitGreen,
              headerForegroundColor: AppColors.black,
              dayForegroundColor: WidgetStateProperty.all(AppColors.fitGreen),
              todayForegroundColor: WidgetStateProperty.all(AppColors.caribbeanGreen),
              cancelButtonStyle: TextButton.styleFrom(foregroundColor: AppColors.greenTea),
              confirmButtonStyle: TextButton.styleFrom(foregroundColor: AppColors.fitGreen),
              rangeSelectionBackgroundColor: AppColors.fitGreen40,
              todayBackgroundColor: WidgetStatePropertyAll(Colors.transparent),
            ),
            appBarTheme: const AppBarTheme(backgroundColor: AppColors.black, foregroundColor: AppColors.fitGreen, centerTitle: true, elevation: 0),
          ),
        );
      },
    );
  }
}
