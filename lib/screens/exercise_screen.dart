import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gym_adhd/config/colors.dart';
import 'package:gym_adhd/config/context.dart';
import 'package:gym_adhd/models/training_session.dart';
import 'package:gym_adhd/providers/training_sessions_provider.dart';
import 'package:gym_adhd/widgets/blurred_background_widget.dart';
import 'package:provider/provider.dart';

class ExerciseScreen extends StatefulWidget {
  static const routeName = '/exercise';
  const ExerciseScreen({super.key});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  int selectedImageIndex = 0;
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<TrainingSessionsProvider>(
      builder: (context, provider, _) {
        final ExerciseInstance exerciseInstance = provider.selectedExercise!;
        return Scaffold(
          body: SafeArea(
            top: false,
            child: Column(
              spacing: 16,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    height: 199,
                    decoration: BoxDecoration(
                      image: exerciseInstance.exercise.images.isNotEmpty
                          ? DecorationImage(image: NetworkImage(exerciseInstance.exercise.imagesUrl[selectedImageIndex]), fit: BoxFit.cover)
                          : null,
                    ),
                    child: SafeArea(
                      bottom: false,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ClipOval(
                                  child: BlurredBackgroundWidget(
                                    child: IconButton(
                                      onPressed: () => Navigator.pop(context),
                                      icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                                    ),
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: BlurredBackgroundWidget(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        exerciseInstance.exercise.name,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
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
                          if (!isExpanded)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: List.generate(
                                  exerciseInstance.exercise.images.length,
                                  (index) => GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedImageIndex = index;
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                                      width: 60.0,
                                      height: 50.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                          color: selectedImageIndex == index ? AppColors.caribbeanGreen : AppColors.antiFlashWhite,
                                          width: selectedImageIndex == index ? 1 : 0,
                                        ),
                                        image: DecorationImage(image: NetworkImage(exerciseInstance.exercise.imagesUrl[index]), fit: BoxFit.cover),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          Spacer(),
                          Container(
                            padding: const EdgeInsets.all(8.0),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.richBlack,
                              gradient: LinearGradient(
                                colors: isExpanded
                                    ? [Colors.transparent, AppColors.richBlack.withOpacity(0.7), AppColors.richBlack]
                                    : [Colors.transparent, AppColors.richBlack],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isExpanded = !isExpanded;
                                });
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 8,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'More info',
                                        style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                                      ),
                                      Spacer(),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isExpanded = !isExpanded;
                                          });
                                        },
                                        icon: Icon(isExpanded ? Icons.expand_less : Icons.expand_more, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  if (exerciseInstance.exercise.instructions.isNotEmpty && isExpanded)
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: exerciseInstance.exercise.instructions.length,
                                      padding: EdgeInsets.all(8),
                                      itemBuilder: (BuildContext context, int index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Text(
                                            '${index + 1}. ${exerciseInstance.exercise.instructions[index]}',
                                            style: const TextStyle(color: Colors.white, fontSize: 14),
                                          ),
                                        );
                                      },
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                ListView.builder(
                  itemCount: exerciseInstance.sets.length,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return SetListItem(setValue: exerciseInstance.sets[index]);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    spacing: 8,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16.0), fixedSize: Size.fromHeight(80)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.stop), const Text('Finish')]),
                        ),
                      ),
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16.0), fixedSize: Size.fromHeight(80)),
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
                            provider.addSet(exerciseInstance.id, Set(id: UniqueKey().toString(), weight: 50, reps: 10));
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

class SetListItem extends StatelessWidget {
  const SetListItem({super.key, required this.setValue});
  final Set setValue;

  @override
  Widget build(BuildContext context) {
    final provider = getTrainingSessionsProviderWithoutListener(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Text('Target reps - ${setValue.targetReps}', textAlign: TextAlign.center)),
                Expanded(child: Text('Target weight - ${setValue.targetWeight} kg', textAlign: TextAlign.center)),
              ],
            ),
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
                    color: setValue.reps >= 10 ? AppColors.caribbeanGreen : AppColors.softSage,
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
                      provider.editSet(setValue.id, setValue.weight - 1, setValue.reps);
                    },
                    icon: const Icon(Icons.remove),
                  ),
                ),
                Text('${setValue.weight} kg'),
                Expanded(
                  child: IconButton(
                    onPressed: () {
                      provider.editSet(setValue.id, setValue.weight + 1, setValue.reps);
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
                      provider.editSet(setValue.id, setValue.weight, setValue.reps - 1);
                    },
                    icon: const Icon(Icons.remove),
                  ),
                ),
                Text('${setValue.reps} Rep'),
                Expanded(
                  child: IconButton(
                    onPressed: () {
                      provider.editSet(setValue.id, setValue.weight, setValue.reps + 1);
                    },
                    icon: const Icon(Icons.add),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
