import 'package:flutter/material.dart';
import 'package:gym_adhd/config/colors.dart';
import 'package:gym_adhd/models/training_session.dart';
import 'package:gym_adhd/providers/training_sessions_provider.dart';
import 'package:gym_adhd/screens/forms/create_session_screen.dart';
import 'package:gym_adhd/screens/session_details_screen.dart';
import 'package:gym_adhd/widgets/gaps.dart';
import 'package:provider/provider.dart';

class SessionsScreen extends StatelessWidget {
  static const routeName = '/sessions';
  const SessionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Training Sessions')),
      body: SafeArea(
        child: Consumer<TrainingSessionsProvider>(
          builder: (context, provider, _) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: AppColors.fitGreen),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                            child: Image(
                              height: 100,
                              width: double.infinity,
                              image: AssetImage('assets/images/training_sessions.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, CreateSessionScreen.routeName),
                          child: Container(
                            width: double.infinity,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.fitGreen,
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
                            ),
                            child: Center(
                              child: Text(
                                'Create New Session',
                                style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gaps.vLarge,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Your Sessions', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        Divider(color: AppColors.fitGreen40),
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
                                child: Container(
                                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                                  padding: const EdgeInsets.all(12.0),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0), color: AppColors.antiFlashWhite),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: AppColors.limeGlow,
                                        child: Icon(generateTrainingLocationIcon(session.location), size: 24),
                                      ),
                                      Gaps.hSmall,
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            session.title,
                                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.black),
                                          ),
                                          Text('${session.date.toLocal()}'.split(' ')[0], style: TextStyle(color: AppColors.black)),
                                          Text('${session.duration.inMinutes} Min', style: TextStyle(color: AppColors.black)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
