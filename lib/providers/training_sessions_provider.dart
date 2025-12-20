import 'package:flutter/material.dart';
import 'package:gym_adhd/models/training_session.dart';

class TrainingSessionsProvider with ChangeNotifier {
  final List<TrainingSession> _sessions = [];

  TrainingSession? selectedSession;
  ExerciseInstance? selectedExercise;

  List<TrainingSession> get sessions => List.unmodifiable(_sessions);

  void createSession(TrainingSession session) {
    _sessions.add(session);
    notifyListeners();
  }

  void setSelectedSession(TrainingSession session) {
    selectedSession = session;
    notifyListeners();
  }

  void setSelectedExercise(ExerciseInstance exercise) {
    selectedExercise = exercise;
    notifyListeners();
  }

  void addExercise(ExerciseInstance exercise) {
    if (selectedSession != null) {
      selectedSession!.exercises.add(exercise);
      notifyListeners();
    }
  }

  void addSet(String exerciseId, Set set) {
    if (selectedSession != null) {
      final exercise = selectedSession!.exercises.firstWhere((ex) => ex.id == exerciseId, orElse: () => throw Exception('Exercise not found'));
      exercise.sets.add(set);
      notifyListeners();
    }
  }

  void editSet(String setId, int newWeight, int newReps) {
    if (selectedSession != null && selectedExercise != null) {
      final set = selectedExercise!.sets.firstWhere((s) => s.id == setId, orElse: () => throw Exception('Set not found'));
      set.weight = newWeight;
      set.reps = newReps;
      notifyListeners();
    }
  }

  void removeExercise(String exerciseId) {
    if (selectedSession != null) {
      selectedSession!.exercises.removeWhere((ex) => ex.id == exerciseId);
      notifyListeners();
    }
  }

  void removeSession(String sessionId) {
    if (selectedSession != null) {
      sessions.removeWhere((ss) => ss.id == sessionId);
      notifyListeners();
    }
  }

  void removeSet(String exerciseId, String setId) {
    if (selectedSession != null) {
      final exercise = selectedSession!.exercises.firstWhere((ex) => ex.id == exerciseId, orElse: () => throw Exception('Exercise not found'));
      exercise.sets.removeWhere((s) => s.id == setId);
      notifyListeners();
    }
  }

  void endSession() {
    if (selectedSession != null && selectedSession!.endDate == null) {
      selectedSession!.endDate = DateTime.now();
      notifyListeners();
    }
  }
}
