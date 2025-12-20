import 'package:isar/isar.dart';

part 'exercise.g.dart';

@collection
class Exercise {
  Id id = Isar.autoIncrement;

  late String exerciseId;
  late String name;
  late String? force;
  late String? level;
  late String? mechanic;
  late String? equipment;
  late String category;

  List<String> primaryMuscles = [];
  List<String> secondaryMuscles = [];
  List<String> instructions = [];
  List<String> images = [];

  List<String> get imagesUrl => images.map((e) => 'https://raw.githubusercontent.com/yuhonas/free-exercise-db/main/exercises/$e').toList();

  Exercise({required this.exerciseId, required this.name, this.force, this.level, this.mechanic, this.equipment, required this.category});

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
        exerciseId: json['id'] as String,
        name: json['name'] as String,
        force: json['force'] as String?,
        level: json['level'] as String?,
        mechanic: json['mechanic'] as String?,
        equipment: json['equipment'] as String?,
        category: json['category'] as String,
      )
      ..primaryMuscles = List<String>.from(json['primaryMuscles'] as List<dynamic>)
      ..secondaryMuscles = List<String>.from(json['secondaryMuscles'] as List<dynamic>)
      ..instructions = List<String>.from(json['instructions'] as List<dynamic>)
      ..images = List<String>.from(json['images'] as List<dynamic>);
  }
}
