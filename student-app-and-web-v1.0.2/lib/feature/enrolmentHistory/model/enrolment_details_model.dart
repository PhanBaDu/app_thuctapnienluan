

class EnrolmentDetails {
  String? id;
  String? userId;
  String? paymentMethod;
  String? paymentStatus;
  String? status;
  int? couponDiscount;
  int? promotionalDiscount;
  String? adminDiscount;
  String? instructorDiscount;
  int? tax;
  int? otherCharges;
  int? amount;
  String? createdAt;
  String? updatedAt;
  List<EnrolmentItem>? enrolmentItems;

  EnrolmentDetails(
      {this.id,
        this.userId,
        this.paymentMethod,
        this.paymentStatus,
        this.status,
        this.couponDiscount,
        this.promotionalDiscount,
        this.adminDiscount,
        this.instructorDiscount,
        this.tax,
        this.otherCharges,
        this.amount,
        this.createdAt,
        this.updatedAt,
        this.enrolmentItems});

  EnrolmentDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    userId = json['user_id'];
    paymentMethod = json['payment_method'];
    paymentStatus = json['payment_status'];
    status = json['status'];
    couponDiscount = json['coupon_discount'];
    promotionalDiscount = json['promotional_discount'];
    adminDiscount = json['admin_discount'];
    instructorDiscount = json['instructor_discount'];
    tax = json['tax'];
    otherCharges = json['other_charges'];
    amount = json['amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['details'] != null) {
      enrolmentItems = <EnrolmentItem>[];
      json['details'].forEach((v) {
        enrolmentItems!.add(EnrolmentItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['payment_method'] = paymentMethod;
    data['payment_status'] = paymentStatus;
    data['status'] = status;
    data['coupon_discount'] = couponDiscount;
    data['promotional_discount'] = promotionalDiscount;
    data['admin_discount'] = adminDiscount;
    data['instructor_discount'] = instructorDiscount;
    data['tax'] = tax;
    data['other_charges'] = otherCharges;
    data['amount'] = amount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (enrolmentItems != null) {
      data['enrolmentItem'] =
          enrolmentItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EnrolmentItem {
  int? id;
  String? enrollmentId;
  String? userId;
  String? instructorId;
  String? courseId;
  String? complitionStatus;
  String? price;
  String? discount;
  String? couponDiscount;
  String? createdAt;
  String? updatedAt;
  Course? course;

  EnrolmentItem(
      {this.id,
        this.enrollmentId,
        this.userId,
        this.instructorId,
        this.courseId,
        this.complitionStatus,
        this.price,
        this.discount,
        this.couponDiscount,
        this.createdAt,
        this.updatedAt,
        this.course});

  EnrolmentItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enrollmentId = json['enrollment_id'];
    userId = json['user_id'];
    instructorId = json['instructor_id'];
    courseId = json['course_id'];
    complitionStatus = json['complition_status'];
    price = json['price'];
    discount = json['discount'];
    couponDiscount = json['coupon_discount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    course =
    json['course'] != null ? Course.fromJson(json['course']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['enrollment_id'] = enrollmentId;
    data['user_id'] = userId;
    data['instructor_id'] = instructorId;
    data['course_id'] = courseId;
    data['complition_status'] = complitionStatus;
    data['price'] = price;
    data['discount'] = discount;
    data['coupon_discount'] = couponDiscount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (course != null) {
      data['course'] = course!.toJson();
    }
    return data;
  }
}

class Course {
  int? id;
  String? title;

  Course({this.id, this.title});

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    return data;
  }
}