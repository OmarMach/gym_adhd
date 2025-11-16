import 'package:gym_adhd/models/exercise.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:convert';
import 'package:flutter/services.dart';

late Isar isar;

Future<void> initIsar() async {
  final dir = await getApplicationDocumentsDirectory();

  isar = await Isar.open([ExerciseSchema], directory: dir.path);
}

Future<void> importExercisesIfNeeded() async {
  final count = await isar.exercises.count();
  if (count > 0) return; // Already imported

  final jsonString = await rootBundle.loadString('assets/exercises.json');
  final List<dynamic> jsonList = json.decode(jsonString);

  final exercises = jsonList.map((j) => Exercise.fromJson(j as Map<String, dynamic>)).toList();

  await isar.writeTxn(() async {
    await isar.exercises.putAll(exercises);
  });

  print("Imported ${exercises.length} exercises.");
}
