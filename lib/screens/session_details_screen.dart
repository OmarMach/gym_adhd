import 'package:flutter/material.dart';
import 'package:gym_adhd/config/context.dart';
import 'package:gym_adhd/config/isar_config.dart';
import 'package:gym_adhd/models/exercise.dart';
import 'package:gym_adhd/models/training_session.dart';
import 'package:gym_adhd/providers/training_sessions_provider.dart';
import 'package:gym_adhd/screens/exercise_screen.dart';
import 'package:gym_adhd/widgets/exercices_list_widget.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';

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
                return ListView(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            session.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text('${session.locationString} Session', textAlign: TextAlign.center),
                          Divider(),
                          Text('Started at : ${session.startDate}'),
                          if (session.endDate != null) Text('Ended at : ${session.endDate}'),
                          Text('Duration : ${session.duration.inMinutes} minutes'),
                          Divider(),
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
                              IconButton(
                                icon: const Icon(Icons.close),
                                onPressed: () {
                                  provider.removeExercise(session.exercises.last.id);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: session.exercises.length,
                      itemBuilder: (BuildContext context, int index) {
                        final exerciseInstance = session.exercises[index];
                        return Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    exerciseInstance.exercise.name,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  Text('Target sets - ${exerciseInstance.targetSets}', textAlign: TextAlign.center),
                                  const Divider(),
                                  ListView.builder(
                                    itemCount: exerciseInstance.sets.length,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (BuildContext context, int index) {
                                      final Set setValue = exerciseInstance.sets[index];
                                      return Stack(
                                        children: [
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: IconButton(
                                              onPressed: () {
                                                provider.removeSet(exerciseInstance.id, setValue.id);
                                              },
                                              icon: const Icon(Icons.close),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      provider.addSet(exerciseInstance.id, Set(id: UniqueKey().toString(), weight: 50, reps: 10));
                                    },
                                    child: const Text('Add Set'),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                  onPressed: () {
                                    provider.removeExercise(exerciseInstance.id);
                                  },
                                  icon: const Icon(Icons.close),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                  onPressed: () {
                                    provider.setSelectedExercise(exerciseInstance);
                                    Navigator.pushNamed(context, ExerciseScreen.routeName);
                                  },
                                  icon: const Icon(Icons.arrow_forward),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
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
