import 'package:gym_adhd/screens/exercise_info_details_screen.dart';
import 'package:gym_adhd/screens/exercise_screen.dart';
import 'package:gym_adhd/screens/forms/create_session_screen.dart';
import 'package:gym_adhd/screens/planning_screen.dart';
import 'package:gym_adhd/screens/session_details_screen.dart';
import 'package:gym_adhd/screens/sessions_screen.dart';

final routes = {
  SessionDetailsScreen.routeName: (_) => const SessionDetailsScreen(),
  CreateSessionScreen.routeName: (_) => const CreateSessionScreen(),
  SessionsScreen.routeName: (_) => const SessionsScreen(),
  ExerciseScreen.routeName: (_) => const ExerciseScreen(),
  PlanningScreen.routeName: (_) => const PlanningScreen(),
  ExerciseInfoDetailsScreen.routeName: (_) => const ExerciseInfoDetailsScreen(),
};
