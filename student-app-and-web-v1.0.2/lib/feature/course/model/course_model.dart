import 'package:get_lms_flutter/core/common_models/coupon_model.dart';
import 'package:get_lms_flutter/data/model/response/config_model.dart';
import 'package:get_lms_flutter/data/model/response/error_response.dart';
import 'package:get_lms_flutter/feature/home/model/campaign_model.dart';

class CourseModel {
  String? message;
  CourseContent? content;
  List<Errors>? errors;

  CourseModel({ this.message, this.content, this.errors});

  CourseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    content =
    json['data'] != null ? CourseContent.fromJson(json['data']) : null;
    if (json['errors'] != null) {
      errors = <Errors>[];
      json['errors'].forEach((v) {
        errors!.add(Errors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (content != null) {
      data['content'] = content!.toJson();
    }
    if (errors != null) {
      data['errors'] = errors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CourseContent {
  int? currentPage;
  List<Course>? serviceList;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  var nextPageUrl;
  String? path;
  String? perPage;
  var prevPageUrl;
  int? to;
  int? total;

  CourseContent(
      {this.currentPage,
        this.serviceList,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  CourseContent.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      serviceList = <Course>[];
      json['data'].forEach((v) {
        serviceList!.add(Course.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add( Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (serviceList != null) {
      data['data'] = serviceList!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class Course {
  int? id;
  String? thumbnail;
  String? categoryId;
  String? subCategoryId;
  String? title;
  String? subTitle;
  List<String>? learningTopic;
  String? requirements;
  String? description;
  String? totalLessons;
  String? totalEnrolls;
  int? completedLessons;
  String? completedPercentage;
  int? isFree;
  String? totalRating;
  num? price;
  int? isDiscounted;
  String? discountType;
  String? discountedPrice;

  Course(
      {this.id,
        this.thumbnail,
        this.categoryId,
        this.subCategoryId,
        this.title,
        this.subTitle,
        this.learningTopic,
        this.requirements,
        this.description,
        this.totalLessons,
        this.totalEnrolls,
        this.completedLessons,
        this.completedPercentage,
        this.isFree,
        this.totalRating,
        this.price,
        this.isDiscounted,
        this.discountType,
        this.discountedPrice
      });

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    thumbnail = json['thumb'];
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    title = json['title'];
    subTitle = json['sub_title'];
    learningTopic = json['learning_topic'].cast<String>();
    requirements = json['requirements'];
    description = json['description'];
    totalLessons = json['totalLessons'];
    totalEnrolls = json['totalEnrolls'];
    completedLessons = json['completedLessons'];
    completedPercentage = json['completedPercentage'].toString();
    isFree = json['isFree'];
    totalRating = json['totalRating'];
    price = json['price'];
    isDiscounted = json['isDiscounted'];
    discountType = json['discountType'];
    discountedPrice = json['discountedPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['thumb'] = thumbnail;
    data['category_id'] = categoryId;
    data['sub_category_id'] = subCategoryId;
    data['title'] = title;
    data['sub_title'] = subTitle;
    data['learning_topic'] = learningTopic;
    data['requirements'] = requirements;
    data['description'] = description;
    data['totalLessons'] = totalLessons;
    data['totalEnrolls'] = totalEnrolls;
    data['completedLessons'] = completedLessons;
    data['completedPercentage'] = completedPercentage;
    data['isFree'] = isFree;
    data['totalRating'] = totalRating;
    data['price'] = price;
    data['isDiscounted'] = isDiscounted;
    data['discountType'] = discountType;
    data['discountedPrice'] = discountedPrice;
    return data;
  }
}

class ServiceCategory {
  String? id;
  String? parentId;
  String? name;
  String? image;
  int? position;
  var description;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  List<ServiceDiscount>? categoryDiscount;
  List<ServiceDiscount>? campaignDiscount;


  ServiceCategory(
      {this.id,
        this.parentId,
        this.name,
        this.image,
        this.position,
        this.description,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.categoryDiscount,
        this.campaignDiscount,
      });

  ServiceCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    name = json['name'];
    image = json['image'];
    position = json['position'];
    description = json['description'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['category_discount'] != null) {
      categoryDiscount = <ServiceDiscount>[];
      json['category_discount'].forEach((v) {
        categoryDiscount!.add(ServiceDiscount.fromJson(v));
      });
    }
    if (json['campaign_discount'] != null) {
      campaignDiscount = <ServiceDiscount>[];
      json['campaign_discount'].forEach((v) {
        campaignDiscount!.add(ServiceDiscount.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['parent_id'] = parentId;
    data['name'] = name;
    data['image'] = image;
    data['position'] = position;
    data['description'] = description;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (categoryDiscount != null) {
      data['category_discount'] = categoryDiscount!.map((v) => v.toJson()).toList();
    }
    if (campaignDiscount != null) {
      data['campaign_discount'] = campaignDiscount!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class ZonesBasicInfo {
  String? id;
  String? name;
  List<Coordinates>? coordinates;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  ZonesBasicInfo(
      {this.id,
        this.name,
        this.coordinates,
        this.isActive,
        this.createdAt,
        this.updatedAt,
        this.pivot});

  ZonesBasicInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['coordinates'] != null) {
      coordinates = <Coordinates>[];
      json['coordinates'].forEach((v) {
        coordinates!.add(Coordinates.fromJson(v));
      });
    }
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    if (coordinates != null) {
      data['coordinates'] = coordinates!.map((v) => v.toJson()).toList();
    }
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    return data;
  }
}
class Faqs {
  String? id;
  String? question;
  String? answer;
  String? serviceId;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  Faqs(
      {this.id,
        this.question,
        this.answer,
        this.serviceId,
        this.isActive,
        this.createdAt,
        this.updatedAt});

  Faqs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
    serviceId = json['service_id'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['question'] = question;
    data['answer'] = answer;
    data['service_id'] = serviceId;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
class ServiceDiscount {
  int? id;
  String? discountId;
  String? discountType;
  String? typeWiseId;
  String? createdAt;
  String? updatedAt;
  Discount? discount;

  ServiceDiscount(
      {this.id,
        this.discountId,
        this.discountType,
        this.typeWiseId,
        this.createdAt,
        this.updatedAt,
        this.discount});

  ServiceDiscount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    discountId = json['discount_id'];
    discountType = json['discount_type'];
    typeWiseId = json['type_wise_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    discount = json['discount'] != null
        ? Discount.fromJson(json['discount'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['discount_id'] = discountId;
    data['discount_type'] = discountType;
    data['type_wise_id'] = typeWiseId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (discount != null) {
      data['discount'] = discount!.toJson();
    }
    return data;
  }
}
