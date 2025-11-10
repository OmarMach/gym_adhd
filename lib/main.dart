import 'package:flutter/material.dart';
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
        return MaterialApp(title: 'Material App', routes: routes, home: const SessionsScreen());
      },
    );
  }
}
