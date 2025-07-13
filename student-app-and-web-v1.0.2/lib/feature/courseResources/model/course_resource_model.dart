class CourseResourceModel {
  String? status;
  CourseResourceContent? courseResourceContent;

  CourseResourceModel({this.status, this.courseResourceContent});

  CourseResourceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    courseResourceContent = json['data'] != null
        ? CourseResourceContent.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (courseResourceContent != null) {
      data['data'] = courseResourceContent!.toJson();
    }
    return data;
  }
}

class CourseResourceContent {
  int? limit;
  int? offset;
  int? total;
  List<CourseResource>? courseResources;

  CourseResourceContent({this.limit, this.offset, this.total, this.courseResources});

  CourseResourceContent.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    offset = json['offset'];
    total = json['total'];
    if (json['data'] != null) {
      courseResources = <CourseResource>[];
      json['data'].forEach((v) {
        courseResources!.add(CourseResource.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['limit'] = limit;
    data['offset'] = offset;
    data['total'] = total;
    if (courseResources != null) {
      data['data'] = courseResources!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CourseResource {
  int? id;
  String? title;
  String? lessonResource;

  CourseResource(
      {this.id,
        this.title,
        this.lessonResource});

  CourseResource.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    lessonResource = json['lesson_resource'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['lesson_resource'] = lessonResource;
    return data;
  }
}