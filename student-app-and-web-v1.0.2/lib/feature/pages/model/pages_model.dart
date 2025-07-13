class PagesModel {
  String? status;
  PagesContent? pagesContent;

  PagesModel({this.status, this.pagesContent});

  PagesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    pagesContent = json['data'] != null
        ? PagesContent.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (pagesContent != null) {
      data['data'] = pagesContent!.toJson();
    }
    return data;
  }
}

class PagesContent {
  String? aboutUs;
  String? privacyPolicy;
  String? termsAndConditions;

  PagesContent({this.aboutUs, this.privacyPolicy, this.termsAndConditions});

  PagesContent.fromJson(Map<String, dynamic> json) {
    aboutUs = json['about_us'];
    privacyPolicy = json['privacy_policy'];
    termsAndConditions = json['terms_and_conditions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['about_us'] = aboutUs;
    data['privacy_policy'] = privacyPolicy;
    data['terms_and_conditions'] = termsAndConditions;
    return data;
  }
}