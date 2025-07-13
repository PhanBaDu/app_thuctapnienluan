class ChannelModel {
  String? status;
  ChannelContent? channelContent;

  ChannelModel({this.status, this.channelContent});

  ChannelModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    channelContent = json['data'] != null
        ? ChannelContent.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (channelContent != null) {
      data['data'] = channelContent!.toJson();
    }
    return data;
  }
}

class ChannelContent {
  int? limit;
  int? offset;
  int? total;
  List<ChannelData>? channelData;

  ChannelContent({this.limit, this.offset, this.total, this.channelData});

  ChannelContent.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    offset = json['offset'];
    total = json['total'];
    if (json['data'] != null) {
      channelData = <ChannelData>[];
      json['data'].forEach((v) {
        channelData!.add(ChannelData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['limit'] = limit;
    data['offset'] = offset;
    data['total'] = total;
    if (channelData != null) {
      data['data'] = channelData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChannelData {
  int? id;
  int? userId;
  String? userName;
  String? userImage;

  ChannelData({this.id, this.userId, this.userName, this.userImage});

  ChannelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userName = json['user_name'];
    userImage = json['user_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['user_image'] = userImage;
    return data;
  }
}