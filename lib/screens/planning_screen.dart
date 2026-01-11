import 'package:flutter/material.dart';
import 'package:gym_adhd/models/exercise.dart';
import 'package:gym_adhd/config/isar_config.dart' show isar;
import 'package:gym_adhd/providers/planning_provider.dart';
import 'package:isar/isar.dart';
import 'package:provider/provider.dart';

class PlanningScreen extends StatelessWidget {
  static const routeName = '/planning';
  const PlanningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Planning Screen')),
      body: SafeArea(
        child: FutureBuilder<List<Exercise>>(
          future: isar.exercises.where().findAll(),
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final provider = Provider.of<PlanningProvider>(context, listen: false);

            final exercisesList = asyncSnapshot.data!;
            provider.exercisesList = exercisesList;
            provider.muscleGroups = exercisesList.expand((e) => e.primaryMuscles).toSet().toList();

            return Consumer<PlanningProvider>(
              builder: (context, provider, _) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 10,
                    children: [
                      Text(provider.getStepTitle(), style: Theme.of(context).textTheme.headlineSmall),
                      Expanded(child: provider.generateFormWidget()),
                      Row(
                        spacing: 10,
                        children: [
                          Flexible(
                            child: OutlinedButton(
                              onPressed: provider.onPrevious,
                              child: Row(
                                spacing: 10,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [Icon(Icons.arrow_back_ios, size: 16), Text(provider.previousStepTitle())],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: ElevatedButton(
                              onPressed: provider.onNext,
                              child: Row(
                                spacing: 10,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [Text(provider.nextStepTitle()), Icon(Icons.arrow_forward_ios, size: 16)],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
