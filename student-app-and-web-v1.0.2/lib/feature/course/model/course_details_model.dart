import 'package:get_lms_flutter/feature/course/model/course_model.dart';

class CourseDetailsModel {
  String? status;
  CourseDetailsContent? courseDetailsContent;

  CourseDetailsModel({this.status, this.courseDetailsContent});

  CourseDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    courseDetailsContent = json['data'] != null
        ? CourseDetailsContent.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (courseDetailsContent != null) {
      data['data'] = courseDetailsContent!.toJson();
    }
    return data;
  }
}

class CourseDetailsContent {
  int? id;
  String? title;
  String? subTitle;
  String? categoryId;
  String? subCategoryId;
  String? instructorId;
  List<String>? learningTopic;
  String? requirements;
  String? description;
  num? price;
  String? isFeatured;
  String? greetings;
  String? congratulationMessage;
  String? thumb;
  String? courseIntroVideo;
  String? videoSourceType;
  String? videoLinkPath;
  String? createdAt;
  String? updatedAt;
  List<Sections>? sections;
  List<Course>? moreCourse;

  CourseDetailsContent(
      {this.id,
        this.title,
        this.subTitle,
        this.categoryId,
        this.subCategoryId,
        this.instructorId,
        this.learningTopic,
        this.requirements,
        this.description,
        this.price,
        this.isFeatured,
        this.greetings,
        this.congratulationMessage,
        this.thumb,
        this.courseIntroVideo,
        this.videoSourceType,
        this.videoLinkPath,
        this.createdAt,
        this.updatedAt,
        this.sections,
        this.moreCourse});

  CourseDetailsContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subTitle = json['sub_title'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    instructorId = json['instructor_id'];
    learningTopic = json['learning_topic'].cast<String>();
    requirements = json['requirements'];
    description = json['description'];
    price = json['price'];
    isFeatured = json['is_featured'];
    greetings = json['greetings'];
    congratulationMessage = json['congratulation_message'];
    thumb = json['thumb'];
    courseIntroVideo = json['course_intro_video'];
    videoSourceType = json['video_source_type'];
    videoLinkPath = json['video_link_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['sections'] != null) {
      sections = <Sections>[];
      json['sections'].forEach((v) {
        sections!.add(Sections.fromJson(v));
      });
    }
    if (json['more_course'] != null) {
      moreCourse = <Course>[];
      json['more_course'].forEach((v) {
        moreCourse!.add(Course.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['sub_title'] = subTitle;
    data['category_id'] = categoryId;
    data['sub_category_id'] = subCategoryId;
    data['instructor_id'] = instructorId;
    data['learning_topic'] = learningTopic;
    data['requirements'] = requirements;
    data['description'] = description;
    data['price'] = price;
    data['is_featured'] = isFeatured;
    data['greetings'] = greetings;
    data['congratulation_message'] = congratulationMessage;
    data['thumb'] = thumb;
    data['course_intro_video'] = courseIntroVideo;
    data['video_source_type'] = videoSourceType;
    data['video_link_path'] = videoLinkPath;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (sections != null) {
      data['sections'] = sections!.map((v) => v.toJson()).toList();
    }
    if (moreCourse != null) {
      data['more_course'] = moreCourse!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sections {
  int? id;
  String? topic;
  String? description;
  String? courseId;
  String? createdAt;
  String? updatedAt;
  List<Lessons>? lessons;

  Sections(
      {this.id,
        this.topic,
        this.description,
        this.courseId,
        this.createdAt,
        this.updatedAt,
        this.lessons});

  Sections.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    topic = json['topic'];
    description = json['description'];
    courseId = json['course_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['lessons'] != null) {
      lessons = <Lessons>[];
      json['lessons'].forEach((v) {
        lessons!.add(Lessons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['topic'] = topic;
    data['description'] = description;
    data['course_id'] = courseId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (lessons != null) {
      data['lessons'] = lessons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lessons {
  String? id;
  String? courseId;
  String? sectionId;
  String? lectureTitle;
  String? videoResource;

  Lessons(
      {this.id,
        this.courseId,
        this.sectionId,
        this.lectureTitle,
        this.videoResource});

  Lessons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['course_id'];
    sectionId = json['section_id'];
    lectureTitle = json['lecture_title'];
    videoResource = json['video_resource'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['course_id'] = courseId;
    data['section_id'] = sectionId;
    data['lecture_title'] = lectureTitle;
    data['video_resource'] = videoResource;
    return data;
  }
}
