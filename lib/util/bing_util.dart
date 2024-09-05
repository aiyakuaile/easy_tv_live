import 'package:easy_tv_live/util/http_util.dart';

class BingUtil {
  static String? bingImgUrl;

  static Future<String?> getBingImgUrl() async {
    if (bingImgUrl != null && bingImgUrl != '') return bingImgUrl;
    final res = await HttpUtil().getRequest('https://bing.biturl.top/', isShowLoading: false);
    if (res != null && res['url'] != null && res['url'] != '') {
      bingImgUrl = res['url'];
      return bingImgUrl;
    }
    return null;
  }
}
