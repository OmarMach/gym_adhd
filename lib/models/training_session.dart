class TrainingSession {
  final String id;
  final String title;
  final DateTime date;
  final Duration duration;
  final List<Exercise> exercises;

  TrainingSession({required this.id, required this.title, required this.date, required this.duration, required this.exercises});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
      'duration': duration.inMinutes,
      'exercises': exercises.map((exercise) => exercise.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'TrainingSession{id: $id, title: $title, date: $date, duration: ${duration.inMinutes} minutes, exercises: $exercises}';
  }
}

class Exercise {
  final String id;
  final String name;
  final List<Set> sets;

  Exercise({required this.name, required this.sets, required this.id});

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'sets': sets.map((set) => set.toJson()).toList()};
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
