import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gym_adhd/config/colors.dart';
import 'package:gym_adhd/models/exercise.dart';
import 'package:gym_adhd/providers/planning_provider.dart';
import 'package:gym_adhd/screens/exercise_info_details_screen.dart';
import 'package:provider/provider.dart';

class SelectExerciseForm extends StatelessWidget {
  const SelectExerciseForm({super.key, required this.exercisesList});

  final List<Exercise> exercisesList;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Consumer<PlanningProvider>(
          builder: (context, provider, _) {
            final filteredExercises = exercisesList.where((e) => e.primaryMuscles.contains(provider.selectedMuscleGroup)).toList();
            return provider.selectedMuscleGroup == null
                ? Container()
                : Expanded(
                    child: Stack(
                      children: [
                        Expanded(
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: exercisesList.where((e) => e.primaryMuscles.contains(provider.selectedMuscleGroup)).length,
                            itemBuilder: (context, index) {
                              final exercise = filteredExercises[index];
                              return GestureDetector(
                                onTap: () {
                                  if (provider.selectedExercise?.id == exercise.id) {
                                    provider.setSelectedExercise(null);
                                    return;
                                  }
                                  provider.setSelectedExercise(exercise);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.backgroundBlack,
                                    border: Border.all(
                                      color: provider.selectedExercise?.id == exercise.id ? AppColors.fitGreen : Colors.transparent,
                                      width: 2,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(4),
                                          child: CachedNetworkImage(
                                            imageUrl: exercise.imagesUrl[0],
                                            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                            errorWidget: (context, url, error) => Icon(Icons.error),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          exercise.name,
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        if (provider.selectedExercise != null)
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 4.0),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: AppColors.fitGreen),
                                onPressed: () {
                                  Navigator.pushNamed(context, ExerciseInfoDetailsScreen.routeName, arguments: provider.selectedExercise);
                                },
                                child: Text('Exercise details'),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
          },
        ),
      ],
    );
  }
}
