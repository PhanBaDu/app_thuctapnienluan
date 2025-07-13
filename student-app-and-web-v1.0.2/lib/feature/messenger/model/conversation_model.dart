class ConversationModel {
  String? status;
  ConversationContent? conversationContent;

  ConversationModel({this.status, this.conversationContent});

  ConversationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    conversationContent = json['data'] != null
        ? ConversationContent.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (conversationContent != null) {
      data['data'] = conversationContent!.toJson();
    }
    return data;
  }
}

class ConversationContent {
  int? limit;
  int? offset;
  int? total;
  List<ConversationData>? conversationData;

  ConversationContent(
      {this.limit, this.offset, this.total, this.conversationData});

  ConversationContent.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    offset = json['offset'];
    total = json['total'];
    if (json['data'] != null) {
      conversationData = <ConversationData>[];
      json['data'].forEach((v) {
        conversationData!.add(ConversationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['limit'] = limit;
    data['offset'] = offset;
    data['total'] = total;
    if (conversationData != null) {
      data['data'] =
          conversationData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ConversationData {
  String? content;
  String? senderId;
  String? receiverId;
  String? conversationId;
  String? createdAt;

  ConversationData(
      {this.content, this.senderId, this.receiverId, this.conversationId, this.createdAt});

  ConversationData.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    conversationId = json['conversation_id'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['content'] = content;
    data['sender_id'] = senderId;
    data['receiver_id'] = receiverId;
    data['conversation_id'] = conversationId;
    data['created_at'] = createdAt;
    return data;
  }
}