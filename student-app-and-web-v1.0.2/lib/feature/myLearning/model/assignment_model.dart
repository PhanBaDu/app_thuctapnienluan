class AssignmentModel {
  String? status;
  AssignmentContent? assignmentContent;

  AssignmentModel({this.status, this.assignmentContent});

  AssignmentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    assignmentContent = json['data'] != null
        ? AssignmentContent.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (assignmentContent != null) {
      data['data'] = assignmentContent!.toJson();
    }
    return data;
  }
}

class AssignmentContent {
  int? limit;
  int? offset;
  int? total;
  List<Assignment>? assignment;

  AssignmentContent({this.limit, this.offset, this.total, this.assignment});

  AssignmentContent.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    offset = json['offset'];
    total = json['total'];
    if (json['data'] != null) {
      assignment = <Assignment>[];
      json['data'].forEach((v) {
        assignment!.add(Assignment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['limit'] = limit;
    data['offset'] = offset;
    data['total'] = total;
    if (assignment != null) {
      data['data'] = assignment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Assignment {
  int? id;
  String? title;
  String? description;
  String? assignmentResource;
  String? isSubmited;
  String? submissionFile;
  String? marks;

  Assignment(
      {this.id,
        this.title,
        this.description,
        this.assignmentResource,
        this.isSubmited,
        this.submissionFile,
        this.marks});

  Assignment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    assignmentResource = json['assignment_resource'];
    isSubmited = json['is_submited'];
    submissionFile = json['submission_file'];
    marks = json['marks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['assignment_resource'] = assignmentResource;
    data['is_submited'] = isSubmited;
    data['submission_file'] = submissionFile;
    data['marks'] = marks;
    return data;
  }
}