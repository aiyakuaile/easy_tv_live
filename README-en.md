![logo](https://fastly.jsdelivr.net/gh/aiyakuaile/images/tv-flow.png)

[![English](https://img.shields.io/badge/Language-English-blueviolet?style=for-the-badge)](README-en.md)
[![简体中文](https://img.shields.io/badge/语言-简体中文-blueviolet?style=for-the-badge)](README.md)

# EasyTV
EasyTV is a lightweight IPTV player that supports all platforms and Android TV large screens. It is simple and easy to use. Welcome to download and experience!

#### TV Sources
> The built-in channel sources of this application come from the [IPTV-API](https://github.
> com/Guovin/iptv-api) project. Thanks for their open-source contribution and sharing.
>Meanwhile, the built-in sources will be automatically fetched from [IPTV-API](https://github.
> com/Guovin/iptv-api) at 7 AM and 7 PM every day.
>Due to the poor quality of IPv4 sources, only IPv6 sources will be synchronized. Please ensure 
> your network supports IPv6 before using the built-in sources.
>[IPv6 test address](https://v6t.ipip.net/). If IPv6 is not supported, please contact your 
> network provider for assistance.

#### Features
- [x] IPTV player that supports all platforms
- [x] Ability to add live source links independently
- [x] Clean and simple UI interaction
- [x] Support for parsing .m3u files
- [x] Support for parsing .txt files (added in v1.5.0)
- [x] Supports Android TV (added in v2.0.0, supports Android OS 5.0+)
- [x] Desktop support (added in v2.6.0)
- [x] Support switching fonts and font sizes
- [x] Support using Bing daily images as video backgrounds
- [x] Automatically merge and group the same channels
- [x] Support channel switching via number keys
- [x] Support channel switching with up and down keys (needs to be manually enabled in '设置->实现设置->上下键切换频道')
- [x] Remote Configuration Feature

#### TV Version Interaction
- Up key: Switch lines
- Down key: Modify or add subscription sources
- OK key: Confirm operation, display channel list

### NOT TV Version Interaction
![image_4](https://raw.githubusercontent.com/aiyakuaile/easy_tv_live/main/img_4.png)

#### Remote Configuration Feature
Fields that support remote configuration can be set on the [极简TV远程配置项](https://aiyakuaile.github.io/tv-setting) page.
After setting, you can click the `下载数据` or `复制Json` button at the bottom of the page.

After obtaining the Json data, you can create a new repository on Github or Gitee, upload the Json data to the repository, and then obtain the Raw link of the uploaded file.

Before adding the remote configuration link, please try it in the browser first to ensure that the link can normally request and return Json data.

Then, add this link in the `远程配置` section of the app's settings page.

For TV versions, you can add it via scanning the push notification, and the program will 
automatically apply the configuration. For other versions, paste the link and click the `应用远程配置` 
button to complete.
>Modifying the JSON data directly will not take effect. When you need to override the app's settings, the `dtaId` field in the JSON must be changed. If you are using the [极简TV远程配置项](https://aiyakuaile.github.io/tv-setting) to generate the JSON data, you don't need to worry, as the program will automatically modify the `dtaId`.

#### Fonts
The fonts that support switching need to use the [easy_tv_font](https://github.com/aiyakuaile/easy_tv_font) project. If you want to add other fonts, please follow the instructions in this project.

> For iOS, after downloading the ipa, you need to sign it for installation using tools.
> If the added live source is an IPv6 address, please confirm that your current network can access IPv6 addresses normally.
> [IPv6 Test Address](https://v6t.ipip.net/)

## Preview

![image_2](https://raw.githubusercontent.com/aiyakuaile/easy_tv_live/main/img_2.jpeg)

![image_1](https://raw.githubusercontent.com/aiyakuaile/easy_tv_live/main/img_1.jpeg) | ![image_3](https://raw.githubusercontent.com/aiyakuaile/easy_tv_live/main/img_3.jpeg)
---|---


## Sponsorship

For easier tracking of sponsors, we recommend using WeChat Scan to make a direct donation. Thank
<img src="https://fastly.jsdelivr.net/gh/aiyakuaile/images/appreciate.png" alt="微信赞赏" width="300">

## 贡献

<a href="https://github.com/aiyakuaile/easy_tv_live/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=aiyakuaile/easy_tv_live" />
</a>

### Star History
<picture>
  <source
    media="(prefers-color-scheme: dark)"
    srcset="
      https://api.star-history.com/svg?repos=aiyakuaile/easy_tv_live&type=Date&theme=dark
    "
  />
  <source
    media="(prefers-color-scheme: light)"
    srcset="
      https://api.star-history.com/svg?repos=aiyakuaile/easy_tv_live&type=Date
    "
  />
  <img
    alt="Star History Chart"
    src="https://api.star-history.com/svg?repos=aiyakuaile/easy_tv_live&type=Date"
  />
</picture>




