import 'package:get_lms_flutter/feature/course/model/course_model.dart';

class CartModel {
  String? _id;
  String? _courseId;
  String? _subCategoryId;
  String? _categoryId;
  String? _courseCost;
  int? _quantity;
  String? _discountAmount;
  String? _campaignDiscountAmount;
  String? _couponDiscountAmount;
  String? _taxAmount;
  String? _totalCost;
  Course? _course;

  CartModel(
      String id,
      String serviceId,
      String categoryId,
      String subCategoryId,
      String courseCost,
      int quantity,
      String discountAmount,
      String campaignDiscountAmount,
      String couponDiscountAmount,
      String taxAmount,
      String totalCost,
      Course service,
      )
  {
  _id = id;
  _courseId = serviceId;
  _categoryId = categoryId;
  _subCategoryId = subCategoryId;
  _courseCost = courseCost;
  _quantity = quantity;
  _discountAmount = discountAmount;
  _campaignDiscountAmount = campaignDiscountAmount;
  _couponDiscountAmount = couponDiscountAmount;
  _taxAmount = taxAmount;
  _totalCost = totalCost;
  _course = service;
  }

  String get id => _id!;
  Course? get course => _course;

  String get serviceId => _courseId!;
  String get categoryId => _categoryId!;
  String get subCategoryId => _subCategoryId!;

  double get price => double.parse(_courseCost!);
  double get discountedPrice => double.parse(_discountAmount??'0');
  double get campaignDiscountPrice => double.parse(_campaignDiscountAmount??'0');
  double get couponDiscountPrice => double.parse(_couponDiscountAmount!);
  double get taxAmount => double.parse(_taxAmount??'0');
  double get totalCost => double.parse(_totalCost!);
  double get courseCost => double.parse(_courseCost!);
  // ignore: unnecessary_getters_setters
  int get quantity => _quantity!;
  // ignore: unnecessary_getters_setters
  set quantity(int qty) => _quantity = qty;

  CartModel copyWith({String? id, int? quantity}) {
    if(id != null) {
      _id = id;
    }

    if(quantity != null) {
      _quantity = quantity;
    }
    return this;
}

  CartModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'].toString();
    _courseId = json['course_id'].toString();
    _categoryId = json['category_id'];
    _subCategoryId = json['sub_category_id'];
    _courseCost = json['course_cost'].toString();
    _quantity = json['quantity'];
    _discountAmount = json['discount_amount'];
    _campaignDiscountAmount = json['campaign_discount'];
    _couponDiscountAmount = json['coupon_discount'].toString();
    _taxAmount = json['tax_amount'];
    _totalCost = json['total_cost'].toString();
    _course = json['course'] != null ? Course.fromJson(json['course']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['course_id'] = _courseId;
    data['category_id'] = _categoryId;
    data['sub_category_id'] = _subCategoryId;
    data['course_cost'] = _courseCost;
    data['quantity'] = _quantity;
    data['discount_amount'] = _discountAmount;
    data['campaign_discount'] = _campaignDiscountAmount;
    data['coupon_discount'] = _couponDiscountAmount;
    data['tax_amount'] = _taxAmount;
    data['total_cost'] = _totalCost;
    data['course'] = _course;
    data['course'] = course?.toJson();
    return data;
  }
}
