import 'package:gym_adhd/providers/training_sessions_provider.dart';
import 'package:provider/provider.dart';

TrainingSessionsProvider getTrainingSessionsProvider(context) => Provider.of<TrainingSessionsProvider>(context);
TrainingSessionsProvider getTrainingSessionsProviderWithoutListener(context) => Provider.of<TrainingSessionsProvider>(context, listen: false);
