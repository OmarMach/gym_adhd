import 'package:flutter/material.dart';
import 'package:gym_adhd/config/context.dart';
import 'package:gym_adhd/config/exercises_list.dart';
import 'package:gym_adhd/models/training_session.dart';
import 'package:gym_adhd/providers/training_sessions_provider.dart';
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
                return Column(
                  children: [
                    Text(session.id),
                    Text(session.title),
                    Text('${session.duration.inMinutes} minutes'),
                    ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          useSafeArea: true,
                          isScrollControlled: true,
                          builder: (context) {
                            return SafeArea(
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.5,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text('Add Exercise'),
                                      Text('Please select the exercise from the list below'),
                                      Expanded(
                                        child: ListView.builder(
                                          itemCount: exercisesList.length,
                                          itemBuilder: (BuildContext context, int index) {
                                            return ListTile(
                                              leading: Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(color: Colors.blueAccent, borderRadius: BorderRadius.circular(8)),
                                                child: Center(
                                                  child: Text(
                                                    exercisesList[index][0],
                                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              title: Text(exercisesList[index]),
                                              onTap: () {
                                                getTrainingSessionsProviderWithoutListener(
                                                  context,
                                                ).addExercise(Exercise(id: UniqueKey().toString(), name: exercisesList[index], sets: []));
                                                Navigator.of(context).pop();
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Text('Exercises (${session.exercises.length})'),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: session.exercises.length,
                        itemBuilder: (BuildContext context, int index) {
                          final exercise = session.exercises[index];
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
                                      exercise.name,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    const Divider(),
                                    ListView.builder(
                                      itemCount: exercise.sets.length,
                                      shrinkWrap: true,
                                      itemBuilder: (BuildContext context, int index) {
                                        final Set setValue = exercise.sets[index];
                                        return Stack(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.symmetric(vertical: 4),
                                              padding: const EdgeInsets.symmetric(vertical: 4),
                                              decoration: BoxDecoration(
                                                border: Border.all(color: Colors.grey.shade400),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Column(
                                                children: [
                                                  Text('Set ${index + 1}'),
                                                  Divider(),
                                                  Container(
                                                    width: 300,
                                                    height: 5,
                                                    decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(8)),
                                                    child: FractionallySizedBox(
                                                      alignment: Alignment.centerLeft,
                                                      widthFactor: (setValue.reps / 10).clamp(0.0, 1.0),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          color: setValue.reps >= 10 ? Colors.green : Colors.blueAccent,
                                                          borderRadius: BorderRadius.circular(8),
                                                        ),
                                                      ),
                                                    ),
                                                  ),

                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: IconButton(
                                                          onPressed: () {
                                                            provider.editSet(exercise.id, setValue.id, setValue.weight - 1, setValue.reps);
                                                          },
                                                          icon: const Icon(Icons.remove),
                                                        ),
                                                      ),
                                                      Text('${setValue.weight} kg'),
                                                      Expanded(
                                                        child: IconButton(
                                                          onPressed: () {
                                                            provider.editSet(exercise.id, setValue.id, setValue.weight + 1, setValue.reps);
                                                          },
                                                          icon: const Icon(Icons.add),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: IconButton(
                                                          onPressed: () {
                                                            provider.editSet(exercise.id, setValue.id, setValue.weight, setValue.reps - 1);
                                                          },
                                                          icon: const Icon(Icons.remove),
                                                        ),
                                                      ),
                                                      Text('${setValue.reps} Rep'),
                                                      Expanded(
                                                        child: IconButton(
                                                          onPressed: () {
                                                            provider.editSet(exercise.id, setValue.id, setValue.weight, setValue.reps + 1);
                                                          },
                                                          icon: const Icon(Icons.add),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              top: 0,
                                              right: 0,
                                              child: IconButton(
                                                onPressed: () {
                                                  provider.removeSet(exercise.id, setValue.id);
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
                                        provider.addSet(exercise.id, Set(id: UniqueKey().toString(), weight: 50, reps: 10));
                                      },
                                      child: const Text('Add Set'),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  provider.removeExercise(exercise.id);
                                },
                                icon: const Icon(Icons.close),
                              ),
                            ],
                          );
                        },
                      ),
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
