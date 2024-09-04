class PlaylistModel {
  PlaylistModel({
    this.epgUrl,
    this.playList,
  });

  String? epgUrl;
  // {group-title: {channel:PlayModel}}
  Map<String, Map<String, PlayModel>>? playList;
}

class PlayModel {
  PlayModel({
    this.id,
    this.logo,
    this.urls,
    this.title,
    this.group,
  });

  PlayModel.fromJson(dynamic json) {
    id = json['id'];
    logo = json['logo'];
    title = json['title'];
    group = json['group'];
    urls = json['urls'] != null ? json['urls'].cast<String>() : [];
  }

  // tvg-name,tvg-id
  String? id;
  // group-title
  String? title;
  // tvg-logo
  String? logo;
  String? group;
  List<String>? urls;

  PlayModel copyWith({
    String? id,
    String? logo,
    String? title,
    String? group,
    List<String>? urls,
  }) =>
      PlayModel(
        id: id ?? this.id,
        logo: logo ?? this.logo,
        urls: urls ?? this.urls,
        title: title ?? this.title,
        group: group ?? this.group,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['logo'] = logo;
    map['urls'] = urls;
    map['title'] = title;
    map['group'] = group;
    return map;
  }
}
