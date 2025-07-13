class MyLearningModel {
  String? status;
  MyLearningContent? myLearningContent;

  MyLearningModel({this.status, this.myLearningContent});

  MyLearningModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    myLearningContent = json['data'] != null
        ? MyLearningContent.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (myLearningContent != null) {
      data['data'] = myLearningContent!.toJson();
    }
    return data;
  }
}

class MyLearningContent {
  int? id;
  String? thumb;
  String? title;
  String? subTitle;
  List<String>? learningTopic;
  String? requirements;
  String? description;
  int? completedLessons;
  String? completedPercentage;
  int? isFree;
  num? price;
  int? isDiscounted;
  List<Sections>? sections;

  MyLearningContent(
      {this.id,
        this.thumb,
        this.title,
        this.subTitle,
        this.learningTopic,
        this.requirements,
        this.description,
        this.completedLessons,
        this.completedPercentage,
        this.isFree,
        this.price,
        this.isDiscounted,
        this.sections});

  MyLearningContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    thumb = json['thumb'];
    title = json['title'];
    subTitle = json['sub_title'];
    learningTopic = json['learning_topic'].cast<String>();
    requirements = json['requirements'];
    description = json['description'];
    completedLessons = json['completedLessons'];
    completedPercentage = json['completedPercentage'];
    isFree = json['isFree'];
    price = json['price'];
    isDiscounted = json['isDiscounted'];
    if (json['sections'] != null) {
      sections = <Sections>[];
      json['sections'].forEach((v) {
        sections!.add(Sections.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['thumb'] = thumb;
    data['title'] = title;
    data['sub_title'] = subTitle;
    data['learning_topic'] = learningTopic;
    data['requirements'] = requirements;
    data['description'] = description;
    data['completedLessons'] = completedLessons;
    data['completedPercentage'] = completedPercentage;
    data['isFree'] = isFree;
    data['price'] = price;
    data['isDiscounted'] = isDiscounted;
    if (sections != null) {
      data['sections'] = sections!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sections {
  int? id;
  String? title;
  String? description;
  List<Lessons>? lessons;
  List<Quiz>? quizs;

  Sections({this.id, this.title, this.description, this.lessons, this.quizs});

  Sections.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    if (json['lessons'] != null) {
      lessons = <Lessons>[];
      json['lessons'].forEach((v) {
        lessons!.add(Lessons.fromJson(v));
      });
    }
    if (json['quizs'] != null) {
      quizs = <Quiz>[];
      json['quizs'].forEach((v) {
        quizs!.add(Quiz.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    if (lessons != null) {
      data['lessons'] = lessons!.map((v) => v.toJson()).toList();
    }
    if (quizs != null) {
      data['quizs'] = quizs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lessons {
  int? id;
  String? title;
  String? description;
  String? lessonResource;
  String? videoResource;
  String? videoSourceType;
  String? videoLinkPath;
  String? isCompleted;

  Lessons(
      {this.id,
        this.title,
        this.description,
        this.lessonResource,
        this.videoResource,
        this.videoSourceType,
        this.videoLinkPath,
        this.isCompleted});

  Lessons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    lessonResource = json['lesson_resource'];
    videoResource = json['video_resource'];
    videoSourceType = json['video_source_type'];
    videoLinkPath = json['video_link_path'];
    isCompleted = json['is_completed'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['lesson_resource'] = lessonResource;
    data['video_resource'] = videoResource;
    data['video_source_type'] = videoSourceType;
    data['video_link_path'] = videoLinkPath;
    data['is_completed'] = isCompleted;
    return data;
  }
}

class Quiz {
  int? id;
  String? sectionId;
  String? title;
  String? description;
  String? marks;

  Quiz({this.id, this.sectionId, this.title, this.description, this.marks});

  Quiz.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sectionId = json['section_id'];
    title = json['title'];
    description = json['description'];
    marks = json['marks'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['section_id'] = sectionId;
    data['title'] = title;
    data['description'] = description;
    data['marks'] = marks.toString();
    return data;
  }
}