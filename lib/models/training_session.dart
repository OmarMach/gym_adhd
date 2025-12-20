import 'package:flutter/material.dart';
import 'package:gym_adhd/models/exercise.dart';

enum TrainingLocation { gym, home, outdoor }

generateTrainingLocationIcon(TrainingLocation location) {
  switch (location) {
    case TrainingLocation.gym:
      return Icons.fitness_center;
    case TrainingLocation.home:
      return Icons.home;
    case TrainingLocation.outdoor:
      return Icons.park;
  }
}

class TrainingSession {
  final String id;
  final TrainingLocation location;
  final String title;
  final DateTime date;
  final DateTime startDate;
  DateTime? endDate;
  final List<ExerciseInstance> exercises;

  Duration get duration {
    final end = endDate ?? DateTime.now();
    return end.difference(startDate);
  }

  String get locationString {
    return '${location.toString().split('.').last[0].toUpperCase()}${location.toString().split('.').last.substring(1)}';
  }

  TrainingSession({
    required this.id,
    required this.location,
    required this.title,
    required this.date,
    required this.exercises,
    required this.startDate,
    this.endDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'duration': duration.inMinutes,
      'exercises': exercises.map((exercise) => exercise.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'TrainingSession{id: $id, title: $title, date: $date, duration: ${duration.inMinutes} minutes, exercises: $exercises} ';
  }
}

class ExerciseInstance {
  final String id;
  final Exercise exercise;
  final List<Set> sets;
  int targetSets = 3;

  ExerciseInstance({required this.exercise, required this.sets, required this.id});

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': exercise.name, 'sets': sets.map((set) => set.toJson()).toList()};
  }
}

class Set {
  final String id;
  int weight = 0;
  int reps = 0;

  int targetWeight = 10;
  int targetReps = 10;

  Set({required this.weight, required this.reps, required this.id});

  Map<String, dynamic> toJson() {
    return {'id': id, 'weight': weight, 'reps': reps};
  }
}
