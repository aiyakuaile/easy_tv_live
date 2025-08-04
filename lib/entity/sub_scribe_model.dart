class SubScribeModel {
  SubScribeModel({this.time, this.link, this.selected = false});

  SubScribeModel.fromJson(dynamic json) {
    time = json['time'];
    link = json['link'];
    selected = json['selected'] ?? false;
  }
  String? time;
  String? link;
  bool? selected;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['time'] = time;
    map['link'] = link;
    map['selected'] = selected ?? false;
    return map;
  }
}
