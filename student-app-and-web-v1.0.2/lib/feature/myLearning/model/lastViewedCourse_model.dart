class LastViewedCourseModel {
  String? status;
  LastViewedCourseContent? lastViewedCourseContent;

  LastViewedCourseModel({this.status, this.lastViewedCourseContent});

  LastViewedCourseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    lastViewedCourseContent = json['data'] != null
        ? LastViewedCourseContent.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (lastViewedCourseContent != null) {
      data['data'] = lastViewedCourseContent!.toJson();
    }
    return data;
  }
}

class LastViewedCourseContent {
  int? id;
  String? userId;
  int? lastViewedCourse;
  int? lastViewedSection;
  int? lastViewedLesson;

  LastViewedCourseContent(
      {this.id,
        this.userId,
        this.lastViewedCourse,
        this.lastViewedSection,
        this.lastViewedLesson});

  LastViewedCourseContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    lastViewedCourse = json['last_viewed_course'];
    lastViewedSection = json['last_viewed_section'];
    lastViewedLesson = json['last_viewed_lesson'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['last_viewed_course'] = lastViewedCourse;
    data['last_viewed_section'] = lastViewedSection;
    data['last_viewed_lesson'] = lastViewedLesson;
    return data;
  }
}