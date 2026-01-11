import 'package:flutter/material.dart';
import 'package:gym_adhd/providers/planning_provider.dart';
import 'package:provider/provider.dart';

class SelectMuscleGroupForm extends StatelessWidget {
  const SelectMuscleGroupForm({super.key, required this.muscleGroups});

  final List<String> muscleGroups;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PlanningProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 16,
      children: [
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
            itemCount: muscleGroups.length,
            itemBuilder: (context, index) {
              final muscleGroup = muscleGroups[index];
              return GestureDetector(
                onTap: () => provider.setSelectedMuscleGroup(muscleGroup),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: provider.selectedMuscleGroup == muscleGroup ? Colors.blue : Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(muscleGroup, style: TextStyle(color: provider.selectedMuscleGroup == muscleGroup ? Colors.white : Colors.black)),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
