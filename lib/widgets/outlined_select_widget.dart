import 'package:flutter/material.dart';
import 'package:gym_adhd/config/colors.dart';
import 'package:gym_adhd/widgets/gaps.dart';

class OutlinedSelectWidget extends StatelessWidget {
  const OutlinedSelectWidget({super.key, required this.label, required this.icon, required this.onTap, required this.isSelected});

  final String label;
  final Widget icon;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: isSelected ? AppColors.fitGreen : AppColors.grayBlue),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 26),
        child: Center(child: Column(children: [icon, Gaps.vSmall, Text(label)])),
      ),
    );
  }
}
