class SubScribeModel {
  SubScribeModel({this.time, this.link, this.selected = false, this.local = false});

  SubScribeModel.fromJson(dynamic json) {
    time = json['time'];
    link = json['link'];
    selected = json['selected'] ?? false;
    local = json['local'] ?? false;
  }
  String? time;
  String? link;
  bool? selected;
  bool? local;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['time'] = time;
    map['link'] = link;
    map['selected'] = selected ?? false;
    map['local'] = local ?? false;
    return map;
  }
}
