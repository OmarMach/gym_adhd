import 'package:flutter/material.dart';
import 'package:gym_adhd/config/colors.dart';
import 'package:gym_adhd/config/routes.dart';
import 'package:gym_adhd/providers/training_sessions_provider.dart';
import 'package:gym_adhd/screens/sessions_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => TrainingSessionsProvider())],
      builder: (context, _) {
        return MaterialApp(
          title: 'Material App',
          routes: routes,
          home: const SessionsScreen(),
          theme: ThemeData(
            useMaterial3: false,
            brightness: Brightness.dark,
            canvasColor: Colors.black,
            primaryColor: AppColors.neonBlue,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.neonBlue,
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            appBarTheme: const AppBarTheme(backgroundColor: Colors.black12, foregroundColor: Colors.white, centerTitle: true, elevation: 0),
          ),
        );
      },
    );
  }
}
