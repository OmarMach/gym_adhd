import 'package:flutter/material.dart';
import 'package:gym_adhd/config/context.dart';
import 'package:gym_adhd/models/training_session.dart';

class CreateSessionScreen extends StatefulWidget {
  static const routeName = '/create-session';
  const CreateSessionScreen({super.key});

  @override
  State<CreateSessionScreen> createState() => _CreateSessionScreenState();
}

class _CreateSessionScreenState extends State<CreateSessionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _dateController = TextEditingController();
  final _durationController = TextEditingController();

  @override
  void initState() {
    _titleController.text = 'Session X';
    _dateController.text = DateTime.now().toIso8601String().split('T').first;
    _durationController.text = '60';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Training Session')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(labelText: 'Date (YYYY-MM-DD)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a date';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _durationController,
                decoration: const InputDecoration(labelText: 'Duration (minutes)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a duration';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newSession = TrainingSession(
                      id: DateTime.now().toString(),
                      title: _titleController.text,
                      date: DateTime.parse(_dateController.text),
                      duration: Duration(minutes: int.parse(_durationController.text)),
                      exercises: [],
                    );
                    final provider = getTrainingSessionsProviderWithoutListener(context);
                    provider.createSession(newSession);
                    Navigator.pop(context);
                  }
                },
                child: const Text('Create Session'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
