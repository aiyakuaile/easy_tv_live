![logo](https://fastly.jsdelivr.net/gh/aiyakuaile/images/tv-flow.png)

[![English](https://img.shields.io/badge/Language-English-blueviolet?style=for-the-badge)](README-en.md)
[![简体中文](https://img.shields.io/badge/语言-简体中文-blueviolet?style=for-the-badge)](README.md)

# 极简TV

极简TV,一款轻量级，支持全平台及安卓电视大屏的IPTV播放器，简洁易用，欢迎下载体验！

#### TV源
> 本应用自带的节目源，来源自[IPTV-API](https://github.com/Guovin/iptv-api)这个项目，感谢此项目的开源与分享。
同时自带节目源会每日7点和19点自动从[IPTV-API](https://github.com/Guovin/iptv-api)中同步。
由于ipv4节目源质量不高，自带源将仅同步ipv6节目源，使用自带节目源之前，请确认您的网络已支持ipv6。
[ipv6测试地址](https://v6t.ipip.net/)，如果不支持ipv6请联系您的网络运营商解决。

#### 功能

- [x] 全平台支持的IPTV播放器
- [x] 可自主添加直播源链接
- [x] 干净简洁的UI交互
- [x] 增加对.m3u文件的解析支持
- [x] 增加对.txt文件的解析支持(v1.5.0新增)
- [x] 支持Android TV(v2.0.0新增，支持AndroidOS 5.0+)
- [x] 桌面端支持(v2.6.0新增)
- [x] 支持切换字体和字体大小
- [x] 支持使用Bing每日图片作为视频背景
- [x] 相同频道自动合并，自动分组
- [x] 支持数字换台
- [x] 支持上下键换台(需要在'设置->实验设置->上下键切换频道'中手动打开)

### TV版交互

⬆️上键：切换频道或线路

⬇️下键：切换频道或进入设置页面

🆗ok键：确认操作、显示频道列表

### 非TV版交互
![image_4](https://raw.githubusercontent.com/aiyakuaile/easy_tv_live/main/img_4.png)

### 字体
支持切换的字体需要使用[easy_tv_font](https://github.com/aiyakuaile/easy_tv_font)这个项目,
您如果想要添加其他字体，请按照这个项目的提示进行操作。

> ios 支持15.5.0+以上版本，下载ipa后需要自行签名安装，例如：爱思助手,轻松签,巨魔等

> 如果添加的直播源是ipv6地址，请先确认您当前的网络是否可以正常访问ipv6地址
> [ipv6测试地址](https://v6t.ipip.net/)

## 预览

![image_2](https://raw.githubusercontent.com/aiyakuaile/easy_tv_live/main/img_2.jpeg)

![image_1](https://raw.githubusercontent.com/aiyakuaile/easy_tv_live/main/img_1.jpeg) | ![image_3](https://raw.githubusercontent.com/aiyakuaile/easy_tv_live/main/img_3.jpeg)
---|---


## 赞助
为了方便统计打赏名单，推荐使用微信扫一扫直接赞赏，感谢您的支持！

<img src="https://fastly.jsdelivr.net/gh/aiyakuaile/images/appreciate.png" alt="微信赞赏" width="300">


## 贡献

<a href="https://github.com/aiyakuaile/easy_tv_live/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=aiyakuaile/easy_tv_live" />
</a>

## Star History
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
