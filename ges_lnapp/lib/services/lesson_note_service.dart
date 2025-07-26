import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/lesson_note_data.dart';

class LessonNoteService {
  // Replace with your actual API endpoint
  static const String _apiUrl = 'https://api.openai.com/v1/chat/completions';
  static const String _apiKey = 'YOUR_OPENAI_API_KEY'; // Replace with your API key

  String generateLessonNotePrompt({
    required String classLevel,
    required String subject,
    required String topic,
    required String date,
  }) {
    return '''You are an expert Ghanaian lesson note writer trained on the GES (Ghana Education Service) curriculum for basic schools (KG to JHS).

Generate a detailed lesson note based on the following input:
- Class Level: $classLevel
- Subject: $subject
- Topic: $topic
- Date: $date

Use the official GES format. Include the following sections:
1. Week and Date
2. Class
3. Subject
4. Topic
5. Sub-topic (if applicable)
6. Duration
7. Strand (if applicable)
8. Indicators/Objectives
9. Core Competencies
10. Learning Materials
11. Introduction
12. Main Activities (step-by-step with TLM usage)
13. Assessment
14. Summary/Conclusion
15. Pupils' Exercise (short)
16. Homework

The tone should be simple, clear, and suitable for Ghanaian classroom use. Keep the formatting professional and editable. Return the output in plain text.''';
  }

  Future<String> generateLessonNote(LessonNoteData data) async {
    try {
      final prompt = generateLessonNotePrompt(
        classLevel: data.classLevel,
        subject: data.subject,
        topic: data.topic,
        date: data.date,
      );

      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {
              'role': 'user',
              'content': prompt,
            }
          ],
          'max_tokens': 2000,
          'temperature': 0.7,
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return jsonResponse['choices'][0]['message']['content'];
      } else {
        throw Exception('Failed to generate lesson note: ${response.statusCode}');
      }
    } catch (e) {
      // For demo purposes, return a sample lesson note
      return _getSampleLessonNote(data);
    }
  }

  String _getSampleLessonNote(LessonNoteData data) {
    return '''
LESSON NOTE

Week and Date: Week 1, ${data.date}
Class: ${data.classLevel}
Subject: ${data.subject}
Topic: ${data.topic}
Sub-topic: Introduction to ${data.topic}
Duration: 40 minutes
Strand: Knowledge and Understanding

Indicators/Objectives:
By the end of the lesson, pupils will be able to:
- Define ${data.topic}
- Identify key characteristics of ${data.topic}
- Apply knowledge of ${data.topic} in daily life

Core Competencies:
- Critical thinking and problem solving
- Communication and collaboration
- Cultural identity and global citizenship

Learning Materials:
- Textbooks
- Charts and diagrams
- Real-life examples
- Whiteboard and markers

Introduction (5 minutes):
- Greet pupils and take attendance
- Review previous lesson
- Introduce today's topic through questioning

Main Activities (25 minutes):
Step 1: Explanation (10 minutes)
- Define ${data.topic} clearly
- Use visual aids to illustrate concepts
- Encourage pupils to ask questions

Step 2: Demonstration (10 minutes)
- Show practical examples
- Use teaching and learning materials (TLM)
- Involve pupils in hands-on activities

Step 3: Practice (5 minutes)
- Guide pupils through exercises
- Provide individual support where needed

Assessment (5 minutes):
- Ask oral questions to test understanding
- Observe pupils' participation
- Check pupils' work

Summary/Conclusion (3 minutes):
- Recap main points of the lesson
- Emphasize key learning outcomes
- Connect to real-life applications

Pupils' Exercise:
1. Define ${data.topic} in your own words
2. Give two examples of ${data.topic}
3. Explain why ${data.topic} is important

Homework:
Research and write three sentences about ${data.topic} using your textbook or other resources.

Teacher's Reflection:
[Space for teacher to reflect on lesson effectiveness]
''';
  }
}