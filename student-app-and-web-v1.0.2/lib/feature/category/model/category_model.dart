import 'package:flutter/material.dart';

class CategoryModel {
  String? id;
  String? parentId;
  String? name;
  String? image;
  var description;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  var courseCount;
  GlobalKey? globalKey;

  CategoryModel(
      {this.id,
        this.parentId,
        this.name,
        this.image,
        this.description,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.courseCount,
        this.globalKey,
      });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    parentId = json['parent_id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    isActive = int.tryParse(json['is_active'].toString()) == 1 ? true : false;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    courseCount = json['course_count'];
    globalKey = GlobalKey(debugLabel: json['id'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['parent_id'] = parentId;
    data['name'] = name;
    data['image'] = image;
    data['description'] = description;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['course_count'] = courseCount;
    return data;
  }
}
