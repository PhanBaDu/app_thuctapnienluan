class CouponModel {
  String? status;
  CouponContent? couponContent;

  CouponModel({this.status, this.couponContent});

  CouponModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    couponContent = json['data'] != null
        ? CouponContent.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (couponContent != null) {
      data['data'] = couponContent!.toJson();
    }
    return data;
  }
}

class CouponContent {
  int? limit;
  int? offset;
  int? total;
  List<Coupon>? coupons;

  CouponContent({this.limit, this.offset, this.total, this.coupons});

  CouponContent.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    offset = json['offset'];
    total = json['total'];
    if (json['data'] != null) {
      coupons = <Coupon>[];
      json['data'].forEach((v) {
        coupons!.add(Coupon.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['limit'] = limit;
    data['offset'] = offset;
    data['total'] = total;
    if (coupons != null) {
      data['data'] = coupons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Coupon {
  int? id;
  String? title;
  String? code;
  String? promotionType;
  String? discountOn;
  String? discountType;
  String? amount;
  String? minPurchase;
  String? maxDiscount;
  String? limitPerUser;
  String? startAt;
  String? endAt;
  String? categoryId;
  String? courseId;
  String? status;
  String? createdAt;
  String? updatedAt;

  Coupon(
      {this.id,
        this.title,
        this.code,
        this.promotionType,
        this.discountOn,
        this.discountType,
        this.amount,
        this.minPurchase,
        this.maxDiscount,
        this.limitPerUser,
        this.startAt,
        this.endAt,
        this.categoryId,
        this.courseId,
        this.status,
        this.createdAt,
        this.updatedAt});

  Coupon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    code = json['code'];
    promotionType = json['promotion_type'];
    discountOn = json['discount_on'];
    discountType = json['discount_type'];
    amount = json['amount'];
    minPurchase = json['min_purchase'];
    maxDiscount = json['max_discount'];
    limitPerUser = json['limit_per_user'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    categoryId = json['category_id'];
    courseId = json['course_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['code'] = code;
    data['promotion_type'] = promotionType;
    data['discount_on'] = discountOn;
    data['discount_type'] = discountType;
    data['amount'] = amount;
    data['min_purchase'] = minPurchase;
    data['max_discount'] = maxDiscount;
    data['limit_per_user'] = limitPerUser;
    data['start_at'] = startAt;
    data['end_at'] = endAt;
    data['category_id'] = categoryId;
    data['course_id'] = courseId;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}