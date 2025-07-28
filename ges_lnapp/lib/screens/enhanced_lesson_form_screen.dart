import 'package:flutter/material.dart';
import '../models/enhanced_lesson_note.dart';
import '../widgets/voice_input_button.dart';
import 'enhanced_lesson_preview_screen.dart';

class EnhancedLessonFormScreen extends StatefulWidget {
  const EnhancedLessonFormScreen({super.key});

  @override
  State<EnhancedLessonFormScreen> createState() => _EnhancedLessonFormScreenState();
}

class _EnhancedLessonFormScreenState extends State<EnhancedLessonFormScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Header Section Controllers
  final _schoolNameController = TextEditingController();
  final _weekNumberController = TextEditingController();
  final _teacherNameController = TextEditingController();
  
  // Body Section Part 1 Controllers
  final _weekEndingDateController = TextEditingController();
  final _dayController = TextEditingController();
  final _subjectController = TextEditingController();
  final _strandController = TextEditingController();
  final _subStrandController = TextEditingController();
  final _durationController = TextEditingController();
  final _contentStandardController = TextEditingController();
  final _indicatorController = TextEditingController();
  final _performanceIndicatorsController = TextEditingController();
  final _coreCompetenceController = TextEditingController();

  // Body Section Part 2 - Phases
  List<LessonPhase> phases = [
    LessonPhase(phase: 'Introduction', learnerActivities: '', resources: ''),
    LessonPhase(phase: 'Development', learnerActivities: '', resources: ''),
    LessonPhase(phase: 'Conclusion', learnerActivities: '', resources: ''),
  ];

  final List<String> _days = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'
  ];

  final List<String> _subjects = [
    'English Language', 'Mathematics', 'Science', 'Social Studies',
    'Religious and Moral Education', 'Ghanaian Language', 'French',
    'Creative Arts', 'Physical Education', 'ICT'
  ];

  @override
  void initState() {
    super.initState();
    _weekEndingDateController.text = DateTime.now().toString().split(' ')[0];
  }

  @override
  void dispose() {
    _schoolNameController.dispose();
    _weekNumberController.dispose();
    _teacherNameController.dispose();
    _weekEndingDateController.dispose();
    _dayController.dispose();
    _subjectController.dispose();
    _strandController.dispose();
    _subStrandController.dispose();
    _durationController.dispose();
    _contentStandardController.dispose();
    _indicatorController.dispose();
    _performanceIndicatorsController.dispose();
    _coreCompetenceController.dispose();
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
        _weekEndingDateController.text = picked.toString().split(' ')[0];
      });
    }
  }

  void _addPhase() {
    setState(() {
      phases.add(LessonPhase(phase: '', learnerActivities: '', resources: ''));
    });
  }

  void _removePhase(int index) {
    if (phases.length > 1) {
      setState(() {
        phases.removeAt(index);
      });
    }
  }

  void _previewLessonNote() {
    if (!_formKey.currentState!.validate()) return;

    final enhancedLessonNote = EnhancedLessonNote(
      schoolName: _schoolNameController.text,
      weekNumber: _weekNumberController.text,
      teacherName: _teacherNameController.text,
      weekEndingDate: _weekEndingDateController.text,
      day: _dayController.text,
      subject: _subjectController.text,
      strand: _strandController.text,
      subStrand: _subStrandController.text,
      duration: _durationController.text,
      contentStandard: _contentStandardController.text,
      indicator: _indicatorController.text,
      performanceIndicators: _performanceIndicatorsController.text,
      coreCompetence: _coreCompetenceController.text,
      phases: phases,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EnhancedLessonPreviewScreen(
          lessonNote: enhancedLessonNote,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enhanced Lesson Note'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              _buildSectionHeader('School Information'),
              const SizedBox(height: 16),
              _buildTextFieldWithVoice(
                controller: _schoolNameController,
                label: 'School Name',
                icon: Icons.school,
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _weekNumberController,
                      label: 'Week Number',
                      icon: Icons.calendar_view_week,
                      validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextFieldWithVoice(
                      controller: _teacherNameController,
                      label: 'Teacher Name',
                      icon: Icons.person,
                      validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 32),
              
              // Body Section Part 1
              _buildSectionHeader('Lesson Details'),
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _weekEndingDateController,
                      label: 'Week Ending Date',
                      icon: Icons.calendar_today,
                      readOnly: true,
                      onTap: _selectDate,
                      validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildDropdownField(
                      value: _dayController.text.isEmpty ? null : _dayController.text,
                      items: _days,
                      label: 'Day',
                      icon: Icons.today,
                      onChanged: (value) => _dayController.text = value ?? '',
                      validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              _buildDropdownField(
                value: _subjectController.text.isEmpty ? null : _subjectController.text,
                items: _subjects,
                label: 'Subject',
                icon: Icons.book,
                onChanged: (value) => _subjectController.text = value ?? '',
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              
              const SizedBox(height: 16),
              
              Row(
                children: [
                  Expanded(
                    child: _buildTextFieldWithVoice(
                      controller: _strandController,
                      label: 'Strand',
                      icon: Icons.category,
                      validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextFieldWithVoice(
                      controller: _subStrandController,
                      label: 'Sub-Strand',
                      icon: Icons.subdirectory_arrow_right,
                      validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              _buildTextField(
                controller: _durationController,
                label: 'Duration (e.g., 40 minutes)',
                icon: Icons.timer,
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              
              const SizedBox(height: 16),
              
              _buildTextFieldWithVoice(
                controller: _contentStandardController,
                label: 'Content Standard',
                icon: Icons.star,
                maxLines: 2,
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              
              const SizedBox(height: 16),
              
              _buildTextFieldWithVoice(
                controller: _indicatorController,
                label: 'Indicator',
                icon: Icons.flag,
                maxLines: 2,
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              
              const SizedBox(height: 16),
              
              _buildTextFieldWithVoice(
                controller: _performanceIndicatorsController,
                label: 'Performance Indicators',
                icon: Icons.assessment,
                maxLines: 3,
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              
              const SizedBox(height: 16),
              
              _buildTextFieldWithVoice(
                controller: _coreCompetenceController,
                label: 'Core Competence',
                icon: Icons.psychology,
                maxLines: 2,
                validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
              ),
              
              const SizedBox(height: 32),
              
              // Body Section Part 2 - Phases
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildSectionHeader('Lesson Phases'),
                  IconButton(
                    onPressed: _addPhase,
                    icon: const Icon(Icons.add_circle),
                    tooltip: 'Add Phase',
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              
              ...phases.asMap().entries.map((entry) {
                int index = entry.key;
                LessonPhase phase = entry.value;
                return _buildPhaseCard(index, phase);
              }),
              
              const SizedBox(height: 32),
              
              // Preview Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _previewLessonNote,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.preview),
                      SizedBox(width: 8),
                      Text('Preview Lesson Note'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFF2E7D32),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    bool readOnly = false,
    VoidCallback? onTap,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
      ),
      validator: validator,
      readOnly: readOnly,
      onTap: onTap,
      maxLines: maxLines,
    );
  }

  Widget _buildTextFieldWithVoice({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return Row(
      children: [
        Expanded(
          child: _buildTextField(
            controller: controller,
            label: label,
            icon: icon,
            validator: validator,
            maxLines: maxLines,
          ),
        ),
        const SizedBox(width: 8),
        VoiceInputButton(
          onResult: (text) {
            setState(() {
              controller.text = text;
            });
          },
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String? value,
    required List<String> items,
    required String label,
    required IconData icon,
    required void Function(String?) onChanged,
    String? Function(String?)? validator,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
      ),
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
      validator: validator,
    );
  }

  Widget _buildPhaseCard(int index, LessonPhase phase) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Phase ${index + 1}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (phases.length > 1)
                  IconButton(
                    onPressed: () => _removePhase(index),
                    icon: const Icon(Icons.delete, color: Colors.red),
                    tooltip: 'Remove Phase',
                  ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: phase.phase,
              decoration: const InputDecoration(
                labelText: 'Phase Name',
                prefixIcon: Icon(Icons.label),
              ),
              onChanged: (value) {
                setState(() {
                  phases[index] = LessonPhase(
                    phase: value,
                    learnerActivities: phase.learnerActivities,
                    resources: phase.resources,
                  );
                });
              },
              validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: phase.learnerActivities,
              decoration: const InputDecoration(
                labelText: 'Learner Activities',
                prefixIcon: Icon(Icons.group),
              ),
              maxLines: 3,
              onChanged: (value) {
                setState(() {
                  phases[index] = LessonPhase(
                    phase: phase.phase,
                    learnerActivities: value,
                    resources: phase.resources,
                  );
                });
              },
              validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: phase.resources,
              decoration: const InputDecoration(
                labelText: 'Resources',
                prefixIcon: Icon(Icons.inventory),
              ),
              maxLines: 2,
              onChanged: (value) {
                setState(() {
                  phases[index] = LessonPhase(
                    phase: phase.phase,
                    learnerActivities: phase.learnerActivities,
                    resources: value,
                  );
                });
              },
              validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
            ),
          ],
        ),
      ),
    );
  }
}
