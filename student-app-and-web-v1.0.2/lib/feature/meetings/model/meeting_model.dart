class MeetingModel {
  String? status;
  MeetingContent? meetingContent;

  MeetingModel({this.status, this.meetingContent});

  MeetingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    meetingContent = json['data'] != null
        ? MeetingContent.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (meetingContent != null) {
      data['data'] = meetingContent!.toJson();
    }
    return data;
  }
}

class MeetingContent {
  int? limit;
  int? offset;
  int? total;
  List<Meeting>? meetings;

  MeetingContent({this.limit, this.offset, this.total, this.meetings});

  MeetingContent.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    offset = json['offset'];
    total = json['total'];
    if (json['data'] != null) {
      meetings = <Meeting>[];
      json['data'].forEach((v) {
        meetings!.add(Meeting.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['limit'] = limit;
    data['offset'] = offset;
    data['total'] = total;
    if (meetings != null) {
      data['data'] = meetings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meeting {
  int? id;
  String? status;
  String? meetingLink;
  String? meetingDate;

  Meeting(
      {this.id,
        this.status,
        this.meetingLink,
        this.meetingDate});

  Meeting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    meetingLink = json['meeting_link'];
    meetingDate = json['meeting_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['meeting_link'] = meetingLink;
    data['meeting_date'] = meetingDate;
    return data;
  }
}