
class Links {
  String? _url;
  String? _label;
  bool? _active;

  Links({String? url, String? label, bool? active}) {
    if (url != null) {
      _url = url;
    }
    if (label != null) {
      _label = label;
    }
    if (active != null) {
      _active = active;
    }
  }

  String? get url => _url;
  String? get label => _label;
  bool? get active => _active;


  Links.fromJson(Map<String, dynamic> json) {
    _url = json['url'];
    _label = json['label'];
    _active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = _url;
    data['label'] = _label;
    data['active'] = _active;
    return data;
  }
}