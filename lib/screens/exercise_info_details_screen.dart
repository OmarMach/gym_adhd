import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gym_adhd/config/colors.dart';
import 'package:gym_adhd/models/exercise.dart';
import 'package:gym_adhd/widgets/gaps.dart';

class ExerciseInfoDetailsScreen extends StatefulWidget {
  static const String routeName = '/exercise_info_details';
  const ExerciseInfoDetailsScreen({super.key});

  @override
  State<ExerciseInfoDetailsScreen> createState() => _ExerciseInfoDetailsScreenState();
}

class _ExerciseInfoDetailsScreenState extends State<ExerciseInfoDetailsScreen> {
  bool expandedImage = false;

  @override
  Widget build(BuildContext context) {
    final Exercise exercise = ModalRoute.of(context)!.settings.arguments as Exercise;
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(exercise.name)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              exercise.images.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            expandedImage = !expandedImage;
                          });
                        },
                        child: SizedBox(
                          height: expandedImage ? 600 : 200,
                          child: PageView.builder(
                            itemCount: exercise.images.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: CachedNetworkImage(imageUrl: exercise.imagesUrl[index], fit: BoxFit.cover),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),

              if (!expandedImage) ...[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.fitGreen),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Text('Muscles', textAlign: TextAlign.center, style: theme.textTheme.titleLarge),
                        Gaps.vMedium,
                        ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: exercise.primaryMuscles.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Text(exercise.primaryMuscles[index]);
                          },
                        ),
                        ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: exercise.secondaryMuscles.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Text(exercise.secondaryMuscles[index]);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Text('Instructions', style: theme.textTheme.titleLarge),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: exercise.instructions.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10,
                        children: [
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: AppColors.fitGreen,
                            child: Text('${index + 1}', style: const TextStyle(fontSize: 12, color: Colors.black)),
                          ),
                          Flexible(child: Text(exercise.instructions[index])),
                        ],
                      ),
                    );
                  },
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
