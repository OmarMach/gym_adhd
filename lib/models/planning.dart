import 'package:gym_adhd/models/exercise.dart';

class Planning {
  final String id;
  final String title;
  final List<PlanningDay> days;

  Planning({required this.id, required this.title, required this.days});
}

class PlanningDay {
  final String id;
  final List<String> muscleGroups;
  final List<Exercise> exercises;

  PlanningDay({required this.id, required this.muscleGroups, required this.exercises});
}
