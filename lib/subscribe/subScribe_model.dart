class SubScribeModel {
  SubScribeModel({this.time, this.link, this.result, this.selected = false});

  SubScribeModel.fromJson(dynamic json) {
    time = json['time'];
    link = json['link'];
    result = json['result'];
    selected = json['selected'] ?? false;
  }
  String? time;
  String? link;
  String? result;
  bool? selected;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['time'] = time;
    map['link'] = link;
    map['result'] = result;
    map['selected'] = selected ?? false;
    return map;
  }
}
