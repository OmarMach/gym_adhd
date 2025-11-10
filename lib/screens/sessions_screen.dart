import 'package:flutter/material.dart';
import 'package:gym_adhd/providers/training_sessions_provider.dart';
import 'package:gym_adhd/screens/forms/create_session_screen.dart';
import 'package:gym_adhd/screens/session_details_screen.dart';
import 'package:provider/provider.dart';

class SessionsScreen extends StatelessWidget {
  static const routeName = '/sessions';
  const SessionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Training Sessions')),
      body: Consumer<TrainingSessionsProvider>(
        builder: (context, provider, _) {
          return Column(
            children: [
              ElevatedButton(onPressed: () => Navigator.pushNamed(context, CreateSessionScreen.routeName), child: Text('Create New Session')),
              Expanded(
                child: ListView.builder(
                  itemCount: provider.sessions.length,
                  itemBuilder: (BuildContext context, int index) {
                    final session = provider.sessions[index];
                    return InkWell(
                      onTap: () {
                        final session = provider.sessions[index];
                        provider.setSelectedSession(session);
                        Navigator.pushNamed(context, SessionDetailsScreen.routeName);
                      },
                      child: ListTile(
                        title: Text(session.title),
                        subtitle: Text('Date: ${session.date.toLocal()} - Duration: ${session.duration.inMinutes} mins'),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
