enum PlayListType { m3u, txt }

class PlayChannelListModel {
  PlayChannelListModel({this.epgUrl, this.type, this.playList, this.playGroupIndex = 0, this.playChannelIndex = 0, this.uaHint});

  PlayChannelListModel.fromJson(dynamic json) {
    playGroupIndex = 0;
    playChannelIndex = 0;
    uaHint = json['uaHint'];
    epgUrl = json['epgUrl'];
    type = PlayListType.values[json['type']];
    if (json['playList'] != null) {
      playList = [];
      json['playList'].forEach((v) {
        playList?.add(PlayModel.fromJson(v));
      });
    }
  }

  String? epgUrl;
  List<PlayModel>? playList;
  PlayListType? type;
  int? playGroupIndex;
  int? playChannelIndex;
  // 自定义UA
  String? uaHint;
}

class PlayModel {
  PlayModel({this.group, this.channel});

  PlayModel.fromJson(dynamic json) {
    group = json['group'];
    if (json['channel'] != null) {
      channel = [];
      json['channel'].forEach((v) {
        channel?.add(Channel.fromJson(v));
      });
    }
  }

  String? group;
  List<Channel>? channel;

  PlayModel copyWith({String? group, List<Channel>? channel}) => PlayModel(group: group ?? this.group, channel: channel ?? this.channel);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['group'] = group;
    if (channel != null) {
      map['channel'] = channel?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Channel {
  Channel({this.id, this.logo, this.title, this.urls, this.serialNum, this.groupIndex, this.channelIndex});

  Channel.fromJson(dynamic json) {
    id = json['id'];
    logo = json['logo'];
    title = json['title'];
    urls = json['urls'] != null ? json['urls'].cast<String>() : [];
    serialNum = json['serialNum'];
    groupIndex = json['groupIndex'];
    channelIndex = json['channelIndex'];
  }
  int? serialNum;
  String? id;
  String? logo;
  String? title;
  List<String>? urls;
  int? groupIndex;
  int? channelIndex;

  Channel copyWith({String? id, String? logo, String? title, List<String>? urls, int? serialNum, int? groupIndex, int? channelIndex}) => Channel(
    id: id ?? this.id,
    logo: logo ?? this.logo,
    title: title ?? this.title,
    urls: urls ?? this.urls,
    serialNum: serialNum ?? this.serialNum,
    groupIndex: groupIndex ?? this.groupIndex,
    channelIndex: channelIndex ?? this.channelIndex,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['logo'] = logo;
    map['title'] = title;
    map['urls'] = urls;
    map['serialNum'] = serialNum;
    map['groupIndex'] = groupIndex;
    map['channelIndex'] = channelIndex;
    return map;
  }
}
