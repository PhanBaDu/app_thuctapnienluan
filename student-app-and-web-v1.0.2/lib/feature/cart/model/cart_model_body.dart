class CartModelBody {
  String? courseId;

  CartModelBody({this.courseId});

  CartModelBody.fromJson(Map<String, dynamic> json) {
    courseId = json['course_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['course_id'] = courseId;
    return data;
  }
}
