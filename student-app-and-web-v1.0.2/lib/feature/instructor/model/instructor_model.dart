class InstructorModel {
  String? status;
  InstructorContent? instructorContent;

  InstructorModel({this.status, this.instructorContent});

  InstructorModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    instructorContent = json['data'] != null
        ? InstructorContent.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (instructorContent != null) {
      data['data'] = instructorContent!.toJson();
    }
    return data;
  }
}

class InstructorContent {
  int? limit;
  int? offset;
  int? total;
  List<Instructor>? instructor;

  InstructorContent({this.limit, this.offset, this.total, this.instructor});

  InstructorContent.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    offset = json['offset'];
    total = json['total'];
    if (json['instructor'] != null) {
      instructor = <Instructor>[];
      json['instructor'].forEach((v) {
        instructor!.add(Instructor.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['limit'] = limit;
    data['offset'] = offset;
    data['total'] = total;
    if (instructor != null) {
      data['instructor'] = instructor!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Instructor {
  int? id;
  String? userId;
  String? name;
  String? logo;
  String? email;
  String? phone;
  String? address;
  String? designation;
  SocialLinks? socialLinks;


  Instructor(
      {this.id, this.name, this.logo, this.email, this.phone, this.address, this.socialLinks});

  Instructor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    logo = json['logo'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    designation = json['designation'];
    socialLinks = json['social_links'] != null
        ? SocialLinks.fromJson(json['social_links'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['name'] = name;
    data['logo'] = logo;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    data['designation'] = designation;
    if (socialLinks != null) {
      data['social_links'] = socialLinks!.toJson();
    }
    return data;
  }
}

class SocialLinks {
  String? facebookUrl;
  String? twitterUrl;
  String? linkedinUrl;

  SocialLinks({this.facebookUrl, this.twitterUrl, this.linkedinUrl});

  SocialLinks.fromJson(Map<String, dynamic> json) {
    facebookUrl = json['facebook_url'];
    twitterUrl = json['twitter_url'];
    linkedinUrl = json['linkedin_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['facebook_url'] = facebookUrl;
    data['twitter_url'] = twitterUrl;
    data['linkedin_url'] = linkedinUrl;
    return data;
  }
}