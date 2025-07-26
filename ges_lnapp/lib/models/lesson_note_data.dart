class LessonNoteData {
  final String classLevel;
  final String subject;
  final String topic;
  final String date;

  LessonNoteData({
    required this.classLevel,
    required this.subject,
    required this.topic,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'classLevel': classLevel,
      'subject': subject,
      'topic': topic,
      'date': date,
    };
  }

  factory LessonNoteData.fromJson(Map<String, dynamic> json) {
    return LessonNoteData(
      classLevel: json['classLevel'],
      subject: json['subject'],
      topic: json['topic'],
      date: json['date'],
    );
  }
}