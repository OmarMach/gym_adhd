import 'package:flutter/material.dart';
import 'package:gym_adhd/config/context.dart';
import 'package:gym_adhd/config/isar_config.dart' show isar;
import 'package:gym_adhd/models/exercise.dart';
import 'package:gym_adhd/models/training_session.dart';
import 'package:isar/isar.dart';

class ExercisesListWidget extends StatelessWidget {
  const ExercisesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Add Exercise'),
          const Text('Please select the exercise from the list below'),
          Expanded(
            child: FutureBuilder<List<Exercise>>(
              future: isar.exercises.where().findAll(),
              builder: (context, asyncSnapshot) {
                if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final exercisesList = asyncSnapshot.data!;
                return ListView.builder(
                  itemCount: exercisesList.length,
                  itemBuilder: (BuildContext context, int index) {
                    Exercise exercise = exercisesList[index];
                    return ExerciseListItem(exercise: exercise);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ExerciseListItem extends StatelessWidget {
  const ExerciseListItem({super.key, required this.exercise});

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: exercise.images.isNotEmpty ? DecorationImage(image: NetworkImage(exercise.imagesUrl[0]), fit: BoxFit.cover) : null,
        ),
      ),
      title: Text(exercise.name),
      subtitle: Text(exercise.primaryMuscles.join(', ')),
      onTap: () {
        getTrainingSessionsProviderWithoutListener(context).addExercise(ExerciseInstance(id: exercise.exerciseId, exercise: exercise, sets: []));
        Navigator.of(context).pop();
      },
    );
  }
}
