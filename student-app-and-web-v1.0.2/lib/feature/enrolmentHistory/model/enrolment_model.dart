class EnrolmentModel {
  String? status;
  EnrolmentContent? enrolmentContent;

  EnrolmentModel({this.status, this.enrolmentContent});

  EnrolmentModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    enrolmentContent = json['data'] != null
        ? EnrolmentContent.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (enrolmentContent != null) {
      data['data'] = enrolmentContent!.toJson();
    }
    return data;
  }
}

class EnrolmentContent {
  int? limit;
  int? offset;
  int? total;
  List<Enrolment>? enrolment;

  EnrolmentContent({this.limit, this.offset, this.total, this.enrolment});

  EnrolmentContent.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    offset = json['offset'];
    total = json['total'];
    if (json['data'] != null) {
      enrolment = <Enrolment>[];
      json['data'].forEach((v) {
        enrolment!.add(Enrolment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['limit'] = limit;
    data['offset'] = offset;
    data['total'] = total;
    if (enrolment != null) {
      data['data'] = enrolment!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Enrolment {
  String? id;
  String? userId;
  String? paymentMethod;
  String? paymentStatus;
  String? status;
  int? couponDiscount;
  int? promotionalDiscount;
  String? adminDiscount;
  String? instructorDiscount;
  num? tax;
  int? otherCharges;
  num? amount;
  String? createdAt;
  String? updatedAt;
  String? transactionId;

  Enrolment(
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
        this.transactionId});

  Enrolment.fromJson(Map<String, dynamic> json) {
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
    transactionId = json['transaction_id'];
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
    data['transaction_id'] = transactionId;
    return data;
  }
}