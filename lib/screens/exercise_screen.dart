import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gym_adhd/config/colors.dart';
import 'package:gym_adhd/models/training_session.dart';
import 'package:gym_adhd/providers/training_sessions_provider.dart';
import 'package:gym_adhd/widgets/blurred_background_widget.dart';
import 'package:provider/provider.dart';

class ExerciseScreen extends StatelessWidget {
  static const routeName = '/exercise';
  const ExerciseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TrainingSessionsProvider>(
      builder: (context, provider, _) {
        final Exercise exercise = provider.selectedExercise!;
        return Scaffold(
          body: SafeArea(
            top: false,
            child: Column(
              spacing: 16,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://raw.githubusercontent.com/yuhonas/free-exercise-db/main/exercises/Alternate_Incline_Dumbbell_Curl/0.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: SafeArea(
                      bottom: false,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                ClipOval(
                                  child: BlurredBackgroundWidget(
                                    child: IconButton(
                                      onPressed: () => Navigator.pop(context),
                                      icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                ClipOval(
                                  child: BlurredBackgroundWidget(
                                    child: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.open_in_full_rounded, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              gradient: LinearGradient(
                                colors: [Colors.black54, Colors.transparent],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  exercise.name,
                                  style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    spacing: 8,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            fixedSize: Size.fromHeight(80),
                            backgroundColor: AppColors.antiFlashWhite,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.stop), const Text('Finish')]),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            fixedSize: Size.fromHeight(80),
                            backgroundColor: AppColors.softSage,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.pause), const Text('Pause')]),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16.0), fixedSize: Size.fromHeight(80)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.arrow_forward), const Text('Set')]),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
