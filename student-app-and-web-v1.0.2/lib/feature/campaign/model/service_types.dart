
import 'package:get_lms_flutter/feature/course/model/course_model.dart';

class ServiceTypesModel {
  int? id;
  String? discountId;
  String? discountType;
  String? typeWiseId;
  String? createdAt;
  String? updatedAt;
  var service;

  ServiceTypesModel(
      {this.id,
        this.discountId,
        this.discountType,
        this.typeWiseId,
        this.createdAt,
        this.updatedAt,
        this.service});

  ServiceTypesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    discountId = json['discount_id'];
    discountType = json['discount_type'];
    typeWiseId = json['type_wise_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    service =
    json['service'] != null ? Course.fromJson(json['service']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['discount_id'] = discountId;
    data['discount_type'] = discountType;
    data['type_wise_id'] = typeWiseId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (service != null) {
      data['service'] = service!.toJson();
    }
    return data;
  }
}
