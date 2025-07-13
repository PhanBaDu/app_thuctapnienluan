
class NotificationModel {
  String? id;
  String? title;
  String? description;
  var coverImage;
  int? isActive;
  String? createdAt;
  String? updatedAt;

  NotificationModel(
      {this.id,
        this.title,
        this.description,
        this.coverImage,
});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    title = json['title'];
    description = json['description'];
    coverImage = json['cover_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['cover_image'] = coverImage;
    return data;
  }
}
