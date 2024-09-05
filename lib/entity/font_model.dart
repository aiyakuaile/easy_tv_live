class FontModel {
  FontModel(
      {this.id, this.fontName, this.fontKey, this.fontType, this.progress});
  FontModel.fromJson(dynamic json) {
    id = json['id'];
    fontName = json['font_name'];
    fontKey = json['font_key'];
    fontType = json['font_type'];
    progress = json['progress'] ?? 0.0;
  }
  String? id;
  String? fontName;
  String? fontKey;
  String? fontType;
  double? progress;
}
