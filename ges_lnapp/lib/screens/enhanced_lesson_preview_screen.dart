import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../models/enhanced_lesson_note.dart';
import '../services/document_generator_service.dart';

class EnhancedLessonPreviewScreen extends StatefulWidget {
  final EnhancedLessonNote lessonNote;

  const EnhancedLessonPreviewScreen({
    super.key,
    required this.lessonNote,
  });

  @override
  State<EnhancedLessonPreviewScreen> createState() => _EnhancedLessonPreviewScreenState();
}

class _EnhancedLessonPreviewScreenState extends State<EnhancedLessonPreviewScreen> {
  final DocumentGeneratorService _documentService = DocumentGeneratorService();
  bool _isGenerating = false;

  Future<void> _exportToPdf() async {
    setState(() => _isGenerating = true);
    
    try {
      final pdf = await _documentService.generatePdf(widget.lessonNote);
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf,
        name: 'Lesson_Note_${widget.lessonNote.subject}_${widget.lessonNote.weekEndingDate}.pdf',
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error generating PDF: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() => _isGenerating = false);
    }
  }

  Future<void> _exportToWord() async {
    setState(() => _isGenerating = true);
    
    try {
      final wordContent = _documentService.generateWordContent(widget.lessonNote);
      await Share.share(
        wordContent,
        subject: 'Lesson Note - ${widget.lessonNote.subject}',
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error generating Word document: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() => _isGenerating = false);
    }
  }

  void _copyToClipboard() {
    final content = _documentService.generatePlainText(widget.lessonNote);
    Clipboard.setData(ClipboardData(text: content));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Lesson note copied to clipboard!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lesson Note Preview'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'pdf':
                  _exportToPdf();
                  break;
                case 'word':
                  _exportToWord();
                  break;
                case 'copy':
                  _copyToClipboard();
                  break;
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: 'pdf',
                child: Row(
                  children: [
                    Icon(Icons.picture_as_pdf, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Export to PDF'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'word',
                child: Row(
                  children: [
                    Icon(Icons.description, color: Colors.blue),
                    SizedBox(width: 8),
                    Text('Export to Word'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'copy',
                child: Row(
                  children: [
                    Icon(Icons.copy),
                    SizedBox(width: 8),
                    Text('Copy to Clipboard'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: _isGenerating
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Generating document...'),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: _buildLessonNotePreview(),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _isGenerating ? null : _exportToPdf,
        icon: const Icon(Icons.download),
        label: const Text('Download PDF'),
      ),
    );
  }

  Widget _buildLessonNotePreview() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          _buildHeaderSection(),
          
          const SizedBox(height: 24),
          const Divider(thickness: 2),
          const SizedBox(height: 24),
          
          // Body Section
          _buildBodySection(),
        ],
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2E7D32).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF2E7D32)),
      ),
      child: Column(
        children: [
          const Text(
            'GHANA EDUCATION SERVICE',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E7D32),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'LESSON NOTE',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: _buildHeaderField('School Name', widget.lessonNote.schoolName),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildHeaderField('Week Number', widget.lessonNote.weekNumber),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: _buildHeaderField('Teacher Name', widget.lessonNote.teacherName),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            value,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildBodySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Part 1: Lesson Information Table
        _buildLessonInfoTable(),
        
        const SizedBox(height: 24),
        
        // Part 2: Phases Table
        _buildPhasesTable(),
      ],
    );
  }

  Widget _buildLessonInfoTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'LESSON INFORMATION',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E7D32),
          ),
        ),
        const SizedBox(height: 12),
        Table(
          border: TableBorder.all(color: Colors.grey.shade400),
          columnWidths: const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(2),
          },
          children: [
            _buildTableRow('Week Ending Date', widget.lessonNote.weekEndingDate),
            _buildTableRow('Day', widget.lessonNote.day),
            _buildTableRow('Subject', widget.lessonNote.subject),
            _buildTableRow('Strand', widget.lessonNote.strand),
            _buildTableRow('Sub-Strand', widget.lessonNote.subStrand),
            _buildTableRow('Duration', widget.lessonNote.duration),
            _buildTableRow('Content Standard', widget.lessonNote.contentStandard),
            _buildTableRow('Indicator', widget.lessonNote.indicator),
            _buildTableRow('Performance Indicators', widget.lessonNote.performanceIndicators),
            _buildTableRow('Core Competence', widget.lessonNote.coreCompetence),
          ],
        ),
      ],
    );
  }

  Widget _buildPhasesTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'LESSON PHASES',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E7D32),
          ),
        ),
        const SizedBox(height: 12),
        Table(
          border: TableBorder.all(color: Colors.grey.shade400),
          columnWidths: const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(1.5),
          },
          children: [
            // Header row
            TableRow(
              decoration: BoxDecoration(
                color: const Color(0xFF2E7D32).withOpacity(0.1),
              ),
              children: [
                _buildTableHeader('Phase'),
                _buildTableHeader('Learner Activities'),
                _buildTableHeader('Resources'),
              ],
            ),
            // Data rows
            ...widget.lessonNote.phases.map((phase) => TableRow(
              children: [
                _buildTableCell(phase.phase),
                _buildTableCell(phase.learnerActivities),
                _buildTableCell(phase.resources),
              ],
            )).toList(),
          ],
        ),
      ],
    );
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF2E7D32).withOpacity(0.1),
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(12),
          child: Text(
            value,
            style: const TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildTableHeader(String text) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildTableCell(String text) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Text(
        text,
        style: const TextStyle(fontSize: 11),
      ),
    );
  }
}
