class QuizDetailsModel {
  String? status;
  QuizDetailsContent? quizDetailsContent;

  QuizDetailsModel({this.status, this.quizDetailsContent});

  QuizDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    quizDetailsContent = json['data'] != null
        ? QuizDetailsContent.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (quizDetailsContent != null) {
      data['data'] = quizDetailsContent!.toJson();
    }
    return data;
  }
}

class QuizDetailsContent {
  int? id;
  String? sectionId;
  String? title;
  String? description;
  List<Questions>? questions;

  String? marks;

  QuizDetailsContent(
      {this.id,
        this.sectionId,
        this.title,
        this.description,
        this.questions,
        this.marks});

  QuizDetailsContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sectionId = json['section_id'];
    title = json['title'];
    description = json['description'];
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(Questions.fromJson(v));
      });
    }
    marks = json['marks'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['section_id'] = sectionId;
    data['title'] = title;
    data['description'] = description;
    if (questions != null) {
      data['questions'] = questions!.map((v) => v.toJson()).toList();
    }
    data['marks'] = marks.toString();
    return data;
  }
}

class Questions {
  int? id;
  String? question;
  List<String>? answers;
  String? correctAnswer;

  Questions({this.id, this.question, this.answers, this.correctAnswer});

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answers = json['answers'].cast<String>();
    correctAnswer = json['correct_answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    data['answers'] = answers;
    data['correct_answer'] = correctAnswer;
    return data;
  }
}