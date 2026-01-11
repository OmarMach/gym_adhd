import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gym_adhd/config/colors.dart';
import 'package:gym_adhd/config/context.dart';
import 'package:gym_adhd/models/training_session.dart';
import 'package:gym_adhd/widgets/outlined_select_widget.dart';

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

  TrainingLocation _selectedLocation = TrainingLocation.gym;

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
      body: Stack(
        children: [
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Image(
              image: AssetImage('assets/images/training_sessions.jpg'),
              fit: BoxFit.fitHeight,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          SafeArea(
            top: false,
            bottom: false,
            child: Column(
              children: [
                AppBar(title: const Text('Create Training Session')),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        spacing: 16.0,
                        children: [
                          Spacer(),
                          Container(
                            padding: const EdgeInsets.only(top: 24.0, left: 16.0, right: 16.0),
                            decoration: BoxDecoration(color: AppColors.black, borderRadius: BorderRadius.circular(12)),
                            child: SafeArea(
                              top: false,
                              child: Column(
                                spacing: 16,
                                children: [
                                  TextFormField(
                                    controller: _dateController,
                                    decoration: const InputDecoration(labelText: 'Date (YYYY-MM-DD)', suffixIcon: Icon(Icons.calendar_today)),
                                    readOnly: true,
                                    onTap: () async {
                                      final selectedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2100),
                                      );
                                      if (selectedDate != null) {
                                        setState(() {
                                          _dateController.text = selectedDate.toIso8601String().split('T').first;
                                        });
                                      }
                                    },
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
                                  Row(
                                    spacing: 16,
                                    children: [
                                      ...TrainingLocation.values.map(
                                        (loc) => Expanded(
                                          child: OutlinedSelectWidget(
                                            label: loc.name.toUpperCase(),
                                            icon: Icon(generateTrainingLocationIcon(loc)),
                                            onTap: () => setState(() {
                                              _selectedLocation = loc;
                                            }),
                                            isSelected: _selectedLocation == loc,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        final newSession = TrainingSession(
                                          id: DateTime.now().toString(),
                                          location: _selectedLocation,
                                          title: '${_selectedLocation.name} Session ',
                                          date: DateTime.parse(_dateController.text),
                                          startDate: DateTime.now(),
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
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
