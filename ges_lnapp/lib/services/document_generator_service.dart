import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../models/enhanced_lesson_note.dart';

class DocumentGeneratorService {
  Future<Uint8List> generatePdf(EnhancedLessonNote lessonNote) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(20),
        build: (pw.Context context) {
          return [
            // Header Section
            _buildPdfHeader(lessonNote),
            
            pw.SizedBox(height: 20),
            pw.Divider(thickness: 2),
            pw.SizedBox(height: 20),
            
            // Body Section
            _buildPdfBody(lessonNote),
          ];
        },
      ),
    );

    return pdf.save();
  }

  pw.Widget _buildPdfHeader(EnhancedLessonNote lessonNote) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.green800, width: 2),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        children: [
          pw.Text(
            'GHANA EDUCATION SERVICE',
            style: pw.TextStyle(
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.green800,
            ),
            textAlign: pw.TextAlign.center,
          ),
          pw.SizedBox(height: 8),
          pw.Text(
            'LESSON NOTE',
            style: pw.TextStyle(
              fontSize: 16,
              fontWeight: pw.FontWeight.bold,
            ),
            textAlign: pw.TextAlign.center,
          ),
          pw.SizedBox(height: 16),
          pw.Row(
            children: [
              pw.Expanded(
                flex: 2,
                child: _buildPdfHeaderField('School Name', lessonNote.schoolName),
              ),
              pw.SizedBox(width: 16),
              pw.Expanded(
                child: _buildPdfHeaderField('Week Number', lessonNote.weekNumber),
              ),
              pw.SizedBox(width: 16),
              pw.Expanded(
                flex: 2,
                child: _buildPdfHeaderField('Teacher Name', lessonNote.teacherName),
              ),
            ],
          ),
        ],
      ),
    );
  }

  pw.Widget _buildPdfHeaderField(String label, String value) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          label,
          style: pw.TextStyle(
            fontSize: 10,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.grey700,
          ),
        ),
        pw.SizedBox(height: 4),
        pw.Container(
          width: double.infinity,
          padding: const pw.EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: PdfColors.grey400),
            borderRadius: pw.BorderRadius.circular(4),
          ),
          child: pw.Text(
            value,
            style: const pw.TextStyle(fontSize: 12),
          ),
        ),
      ],
    );
  }

  pw.Widget _buildPdfBody(EnhancedLessonNote lessonNote) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Part 1: Lesson Information Table
        _buildPdfLessonInfoTable(lessonNote),
        
        pw.SizedBox(height: 24),
        
        // Part 2: Phases Table
        _buildPdfPhasesTable(lessonNote),
      ],
    );
  }

  pw.Widget _buildPdfLessonInfoTable(EnhancedLessonNote lessonNote) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'LESSON INFORMATION',
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.green800,
          ),
        ),
        pw.SizedBox(height: 12),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey400),
          columnWidths: {
            0: const pw.FlexColumnWidth(1),
            1: const pw.FlexColumnWidth(2),
          },
          children: [
            _buildPdfTableRow('Week Ending Date', lessonNote.weekEndingDate),
            _buildPdfTableRow('Day', lessonNote.day),
            _buildPdfTableRow('Subject', lessonNote.subject),
            _buildPdfTableRow('Strand', lessonNote.strand),
            _buildPdfTableRow('Sub-Strand', lessonNote.subStrand),
            _buildPdfTableRow('Duration', lessonNote.duration),
            _buildPdfTableRow('Content Standard', lessonNote.contentStandard),
            _buildPdfTableRow('Indicator', lessonNote.indicator),
            _buildPdfTableRow('Performance Indicators', lessonNote.performanceIndicators),
            _buildPdfTableRow('Core Competence', lessonNote.coreCompetence),
          ],
        ),
      ],
    );
  }

  pw.Widget _buildPdfPhasesTable(EnhancedLessonNote lessonNote) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'LESSON PHASES',
          style: pw.TextStyle(
            fontSize: 14,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.green800,
          ),
        ),
        pw.SizedBox(height: 12),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey400),
          columnWidths: {
            0: const pw.FlexColumnWidth(1),
            1: const pw.FlexColumnWidth(2),
            2: const pw.FlexColumnWidth(1.5),
          },
          children: [
            // Header row
            pw.TableRow(
              decoration: pw.BoxDecoration(
                color: PdfColors.green50,
              ),
              children: [
                _buildPdfTableHeader('Phase'),
                _buildPdfTableHeader('Learner Activities'),
                _buildPdfTableHeader('Resources'),
              ],
            ),
            // Data rows
            ...lessonNote.phases.map((phase) => pw.TableRow(
              children: [
                _buildPdfTableCell(phase.phase),
                _buildPdfTableCell(phase.learnerActivities),
                _buildPdfTableCell(phase.resources),
              ],
            )).toList(),
          ],
        ),
      ],
    );
  }

  pw.TableRow _buildPdfTableRow(String label, String value) {
    return pw.TableRow(
      children: [
        pw.Container(
          padding: const pw.EdgeInsets.all(8),
          decoration: pw.BoxDecoration(
            color: PdfColors.green50,
          ),
          child: pw.Text(
            label,
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ),
        pw.Container(
          padding: const pw.EdgeInsets.all(8),
          child: pw.Text(
            value,
            style: const pw.TextStyle(fontSize: 10),
          ),
        ),
      ],
    );
  }

  pw.Widget _buildPdfTableHeader(String text) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          fontWeight: pw.FontWeight.bold,
          fontSize: 10,
        ),
        textAlign: pw.TextAlign.center,
      ),
    );
  }

  pw.Widget _buildPdfTableCell(String text) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: const pw.TextStyle(fontSize: 9),
      ),
    );
  }

  String generateWordContent(EnhancedLessonNote lessonNote) {
    return '''
GHANA EDUCATION SERVICE
LESSON NOTE

School Name: ${lessonNote.schoolName}
Week Number: ${lessonNote.weekNumber}
Teacher Name: ${lessonNote.teacherName}

=====================================

LESSON INFORMATION

Week Ending Date: ${lessonNote.weekEndingDate}
Day: ${lessonNote.day}
Subject: ${lessonNote.subject}
Strand: ${lessonNote.strand}
Sub-Strand: ${lessonNote.subStrand}
Duration: ${lessonNote.duration}
Content Standard: ${lessonNote.contentStandard}
Indicator: ${lessonNote.indicator}
Performance Indicators: ${lessonNote.performanceIndicators}
Core Competence: ${lessonNote.coreCompetence}

=====================================

LESSON PHASES

${lessonNote.phases.map((phase) => '''
Phase: ${phase.phase}
Learner Activities: ${phase.learnerActivities}
Resources: ${phase.resources}
---
''').join('\n')}

=====================================

Generated by GES Lesson Note Generator
''';
  }

  String generatePlainText(EnhancedLessonNote lessonNote) {
    return generateWordContent(lessonNote);
  }
}
