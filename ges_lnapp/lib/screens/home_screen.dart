import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../services/lesson_note_service.dart';
import '../models/lesson_note_data.dart';
import 'lesson_note_preview_screen.dart';
import '../widgets/voice_input_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _classLevelController = TextEditingController();
  final _subjectController = TextEditingController();
  final _topicController = TextEditingController();
  final _dateController = TextEditingController();
  
  final LessonNoteService _lessonNoteService = LessonNoteService();
  bool _isGenerating = false;

  final List<String> _classLevels = [
    'KG 1', 'KG 2',
    'Primary 1', 'Primary 2', 'Primary 3', 'Primary 4', 'Primary 5', 'Primary 6',
    'JHS 1', 'JHS 2', 'JHS 3'
  ];

  final List<String> _subjects = [
    'English Language', 'Mathematics', 'Science', 'Social Studies',
    'Religious and Moral Education', 'Ghanaian Language', 'French',
    'Creative Arts', 'Physical Education', 'ICT'
  ];

  @override
  void initState() {
    super.initState();
    _dateController.text = DateTime.now().toString().split(' ')[0];
  }

  @override
  void dispose() {
    _classLevelController.dispose();
    _subjectController.dispose();
    _topicController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = picked.toString().split(' ')[0];
      });
    }
  }

  Future<void> _generateLessonNote() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isGenerating = true;
    });

    try {
      final lessonNoteData = LessonNoteData(
        classLevel: _classLevelController.text,
        subject: _subjectController.text,
        topic: _topicController.text,
        date: _dateController.text,
      );

      final generatedNote = await _lessonNoteService.generateLessonNote(lessonNoteData);

      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LessonNotePreviewScreen(
              lessonNoteData: lessonNoteData,
              generatedContent: generatedNote,
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error generating lesson note: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() {
        _isGenerating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GES Lesson Note Generator'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Generate Professional Lesson Notes',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Based on GES Curriculum for Basic Schools',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              
              // Class Level Dropdown
              DropdownButtonFormField<String>(
                value: _classLevelController.text.isEmpty ? null : _classLevelController.text,
                decoration: const InputDecoration(
                  labelText: 'Class Level',
                  prefixIcon: Icon(Icons.school),
                ),
                items: _classLevels.map((level) {
                  return DropdownMenuItem(
                    value: level,
                    child: Text(level),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _classLevelController.text = value ?? '';
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a class level';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Subject Dropdown
              DropdownButtonFormField<String>(
                value: _subjectController.text.isEmpty ? null : _subjectController.text,
                decoration: const InputDecoration(
                  labelText: 'Subject',
                  prefixIcon: Icon(Icons.book),
                ),
                items: _subjects.map((subject) {
                  return DropdownMenuItem(
                    value: subject,
                    child: Text(subject),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _subjectController.text = value ?? '';
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a subject';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Topic Field with Voice Input
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _topicController,
                      decoration: const InputDecoration(
                        labelText: 'Topic',
                        prefixIcon: Icon(Icons.topic),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a topic';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  VoiceInputButton(
                    onResult: (text) {
                      setState(() {
                        _topicController.text = text;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Date Field
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  labelText: 'Date',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: _selectDate,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              // Generate Button
              ElevatedButton(
                onPressed: _isGenerating ? null : _generateLessonNote,
                child: _isGenerating
                    ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                          SizedBox(width: 12),
                          Text('Generating...'),
                        ],
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.auto_awesome),
                          SizedBox(width: 8),
                          Text('Generate Lesson Note'),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}