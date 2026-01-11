import 'package:flutter/material.dart';
import 'package:gym_adhd/config/colors.dart';
import 'package:gym_adhd/config/context.dart';
import 'package:gym_adhd/models/training_session.dart';
import 'package:gym_adhd/providers/training_sessions_provider.dart';
import 'package:gym_adhd/screens/exercise_screen.dart';
import 'package:gym_adhd/widgets/exercices_list_widget.dart';
import 'package:gym_adhd/widgets/gaps.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class SessionDetailsScreen extends StatelessWidget {
  static const routeName = '/session-details';
  const SessionDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Session Details')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<TrainingSessionsProvider>(
            builder: (context, provider, _) {
              if (provider.selectedSession == null) {
                return const Center(child: Text('No session selected'));
              } else {
                final session = provider.selectedSession!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Column(
                            children: [
                              Text(session.title.toUpperCase(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                              Text(DateFormat('yyyy-MM-dd').format(session.startDate)),
                            ],
                          ),
                          Text('Started at : ${DateFormat('kk:mm').format(session.startDate)}'),
                          if (session.endDate != null) Text('Started at : ${DateFormat('kk:mm').format(session.endDate!)}'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: session.exercises.length,
                        itemBuilder: (BuildContext context, int index) {
                          final exerciseInstance = session.exercises[index];
                          return ExerciseListItem(exerciseInstance: exerciseInstance);
                        },
                      ),
                    ),
                    StreamBuilder<int>(
                      stream: Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now().millisecondsSinceEpoch),
                      builder: (context, snapshot) {
                        final now = DateTime.now();
                        final duration = session.endDate == null ? now.difference(session.startDate) : session.duration;
                        return Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: AppColors.gray),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${duration.inMinutes.toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}',
                              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      },
                    ),
                    Gaps.vMedium,
                    Row(
                      children: [
                        if (session.endDate == null)
                          Expanded(
                            child: ElevatedButton(onPressed: () => provider.endSession(), child: Text('End Session')),
                          ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                useSafeArea: true,
                                isScrollControlled: true,
                                builder: (context) {
                                  return SafeArea(
                                    child: Padding(
                                      padding: EdgeInsets.all(16),
                                      child: SizedBox(height: MediaQuery.of(context).size.height * 0.5, child: ExercisesListWidget()),
                                    ),
                                  );
                                },
                              );
                            },
                            child: Text('Add Exercise'),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class ExerciseListItem extends StatelessWidget {
  const ExerciseListItem({super.key, required this.exerciseInstance});

  final ExerciseInstance exerciseInstance;

  @override
  Widget build(BuildContext context) {
    final provider = getTrainingSessionsProviderWithoutListener(context);
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                fit: StackFit.loose,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                    child: Image(image: NetworkImage(exerciseInstance.exercise.imagesUrl[0]), height: 150, fit: BoxFit.cover, width: double.infinity),
                  ),
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          exerciseInstance.exercise.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text('Target sets - ${exerciseInstance.targetSets}', textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.antiFlashWhite,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8))),
                      ),
                      onPressed: () {
                        provider.setSelectedExercise(exerciseInstance);
                        Navigator.pushNamed(context, ExerciseScreen.routeName);
                      },
                      child: const Text('Start'),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomRight: Radius.circular(8))),
                      ),
                      onPressed: () {
                        provider.setSelectedExercise(exerciseInstance);
                        Navigator.pushNamed(context, ExerciseScreen.routeName);
                      },
                      child: Icon(Icons.delete, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
