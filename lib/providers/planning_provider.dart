import 'package:flutter/material.dart';
import 'package:gym_adhd/models/exercise.dart';
import 'package:gym_adhd/screens/forms/create_planning_forms/select_exercice.dart';
import 'package:gym_adhd/screens/forms/create_planning_forms/select_muscle_group.dart';

enum PlanningStep { selectMuscleGroup, selectExercise, setDetails }

class PlanningProvider with ChangeNotifier {
  PlanningStep currentStep = PlanningStep.selectMuscleGroup;

  List<String> muscleGroups = [];
  List<Exercise> exercisesList = [];

  String? selectedMuscleGroup;
  Exercise? selectedExercise;

  void setSelectedMuscleGroup(String? muscleGroup) {
    selectedMuscleGroup = muscleGroup;
    notifyListeners();
  }

  void setSelectedExercise(Exercise? exercise) {
    selectedExercise = exercise;
    notifyListeners();
  }

  String getStepTitle() {
    switch (currentStep) {
      case PlanningStep.selectMuscleGroup:
        return 'Select Muscle Group';
      case PlanningStep.selectExercise:
        return 'Select Exercise';
      case PlanningStep.setDetails:
        return 'Set Details';
    }
  }

  String nextStepTitle() {
    switch (currentStep) {
      case PlanningStep.selectMuscleGroup:
        return 'Exercises';
      case PlanningStep.selectExercise:
        return 'Details';
      case PlanningStep.setDetails:
        return 'Finish';
    }
  }

  String previousStepTitle() {
    switch (currentStep) {
      case PlanningStep.selectMuscleGroup:
        return 'Cancel';
      case PlanningStep.selectExercise:
        return 'Muscles';
      case PlanningStep.setDetails:
        return 'Exercises';
    }
  }

  void onNext() {
    switch (currentStep) {
      case PlanningStep.selectMuscleGroup:
        currentStep = PlanningStep.selectExercise;
        break;
      case PlanningStep.selectExercise:
        currentStep = PlanningStep.setDetails;
        break;
      case PlanningStep.setDetails:
        // Final step, maybe save the planning
        break;
    }
    notifyListeners();
  }

  void onPrevious() {
    switch (currentStep) {
      case PlanningStep.selectMuscleGroup:
        // First step, do nothing or exit
        break;
      case PlanningStep.selectExercise:
        currentStep = PlanningStep.selectMuscleGroup;
        break;
      case PlanningStep.setDetails:
        currentStep = PlanningStep.selectExercise;
        break;
    }
    notifyListeners();
  }

  Widget generateFormWidget() {
    switch (currentStep) {
      case PlanningStep.selectMuscleGroup:
        return SelectMuscleGroupForm(muscleGroups: muscleGroups);
      case PlanningStep.selectExercise:
        return SelectExerciseForm(exercisesList: exercisesList);
      case PlanningStep.setDetails:
        return Container();
    }
  }
}
