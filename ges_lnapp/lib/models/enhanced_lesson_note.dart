class EnhancedLessonNote {
  // Header Section
  final String schoolName;
  final String weekNumber;
  final String teacherName;

  // Body Section - Part 1
  final String weekEndingDate;
  final String day;
  final String subject;
  final String strand;
  final String subStrand;
  final String duration;
  final String contentStandard;
  final String indicator;
  final String performanceIndicators;
  final String coreCompetence;

  // Body Section - Part 2 (List of phases)
  final List<LessonPhase> phases;

  EnhancedLessonNote({
    required this.schoolName,
    required this.weekNumber,
    required this.teacherName,
    required this.weekEndingDate,
    required this.day,
    required this.subject,
    required this.strand,
    required this.subStrand,
    required this.duration,
    required this.contentStandard,
    required this.indicator,
    required this.performanceIndicators,
    required this.coreCompetence,
    required this.phases,
  });

  Map<String, dynamic> toJson() {
    return {
      'schoolName': schoolName,
      'weekNumber': weekNumber,
      'teacherName': teacherName,
      'weekEndingDate': weekEndingDate,
      'day': day,
      'subject': subject,
      'strand': strand,
      'subStrand': subStrand,
      'duration': duration,
      'contentStandard': contentStandard,
      'indicator': indicator,
      'performanceIndicators': performanceIndicators,
      'coreCompetence': coreCompetence,
      'phases': phases.map((phase) => phase.toJson()).toList(),
    };
  }

  factory EnhancedLessonNote.fromJson(Map<String, dynamic> json) {
    return EnhancedLessonNote(
      schoolName: json['schoolName'] ?? '',
      weekNumber: json['weekNumber'] ?? '',
      teacherName: json['teacherName'] ?? '',
      weekEndingDate: json['weekEndingDate'] ?? '',
      day: json['day'] ?? '',
      subject: json['subject'] ?? '',
      strand: json['strand'] ?? '',
      subStrand: json['subStrand'] ?? '',
      duration: json['duration'] ?? '',
      contentStandard: json['contentStandard'] ?? '',
      indicator: json['indicator'] ?? '',
      performanceIndicators: json['performanceIndicators'] ?? '',
      coreCompetence: json['coreCompetence'] ?? '',
      phases: (json['phases'] as List<dynamic>?)
          ?.map((phase) => LessonPhase.fromJson(phase))
          .toList() ?? [],
    );
  }
}

class LessonPhase {
  final String phase;
  final String learnerActivities;
  final String resources;

  LessonPhase({
    required this.phase,
    required this.learnerActivities,
    required this.resources,
  });

  Map<String, dynamic> toJson() {
    return {
      'phase': phase,
      'learnerActivities': learnerActivities,
      'resources': resources,
    };
  }

  factory LessonPhase.fromJson(Map<String, dynamic> json) {
    return LessonPhase(
      phase: json['phase'] ?? '',
      learnerActivities: json['learnerActivities'] ?? '',
      resources: json['resources'] ?? '',
    );
  }
}
