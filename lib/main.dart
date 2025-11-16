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
            canvasColor: AppColors.richBlack,
            primaryColor: AppColors.softSage,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.caribbeanGreen,
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.richBlack,
              foregroundColor: AppColors.caribbeanGreen,
              centerTitle: true,
              elevation: 0,
            ),
          ),
        );
      },
    );
  }
}
