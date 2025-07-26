import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/lesson_note_data.dart';

class StorageService {
  static const String _lessonNotesKey = 'lesson_notes';
  static const String _templatesKey = 'lesson_templates';

  Future<void> saveLessonNote(LessonNoteData data, String content) async {
    final prefs = await SharedPreferences.getInstance();
    final existingNotes = await getSavedLessonNotes();
    
    final noteToSave = {
      'data': data.toJson(),
      'content': content,
      'timestamp': DateTime.now().toIso8601String(),
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
    };
    
    existingNotes.add(noteToSave);
    await prefs.setString(_lessonNotesKey, jsonEncode(existingNotes));
  }

  Future<List<Map<String, dynamic>>> getSavedLessonNotes() async {
    final prefs = await SharedPreferences.getInstance();
    final notesJson = prefs.getString(_lessonNotesKey);
    
    if (notesJson == null) return [];
    
    final List<dynamic> notesList = jsonDecode(notesJson);
    return notesList.cast<Map<String, dynamic>>();
  }

  Future<void> deleteLessonNote(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final existingNotes = await getSavedLessonNotes();
    
    existingNotes.removeWhere((note) => note['id'] == id);
    await prefs.setString(_lessonNotesKey, jsonEncode(existingNotes));
  }

  Future<void> saveTemplate(String name, Map<String, String> template) async {
    final prefs = await SharedPreferences.getInstance();
    final existingTemplates = await getTemplates();
    
    existingTemplates[name] = template;
    await prefs.setString(_templatesKey, jsonEncode(existingTemplates));
  }

  Future<Map<String, Map<String, String>>> getTemplates() async {
    final prefs = await SharedPreferences.getInstance();
    final templatesJson = prefs.getString(_templatesKey);
    
    if (templatesJson == null) return {};
    
    final Map<String, dynamic> templatesMap = jsonDecode(templatesJson);
    return templatesMap.map((key, value) => 
        MapEntry(key, Map<String, String>.from(value)));
  }
}