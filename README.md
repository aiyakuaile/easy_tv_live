![logo](https://fastly.jsdelivr.net/gh/aiyakuaile/images/tv-flow.png)

[![English](https://img.shields.io/badge/Language-English-blueviolet?style=for-the-badge)](README-en.md)
[![简体中文](https://img.shields.io/badge/语言-简体中文-blueviolet?style=for-the-badge)](README.md)

# 极简TV

极简TV,一款轻量级，支持全平台及安卓电视大屏的IPTV播放器，简洁易用，欢迎下载体验！

#### TV源
> 本应用自带的节目源，来源自[IPTV-ORG](https://github.com/iptv-org/iptv)这个项目，感谢此项目的开源与分享。
同时自带节目源会每日7点和19点自动从[IPTV-ORG](https://github.com/iptv-org/iptv)中同步。

#### 功能

- [x] 全平台支持的IPTV播放器
- [x] 增加对.m3u文件的解析支持
- [x] 增加对.txt文件的解析支持
- [x] 支持Android TV(v2.0.0新增，支持AndroidOS 5.0+)
- [x] 桌面端支持(v2.6.0新增)
- [x] 支持切换字体和字体大小
- [x] 支持使用Bing每日图片作为视频背景
- [x] 相同频道自动合并，自动分组
- [x] 支持数字换台
- [x] 支持上下键换台(需要在'设置->实验设置->上下键切换频道'中手动打开)
- [x] 支持[Basic认证](https://github.com/aiyakuaile/easy_tv_live?tab=readme-ov-file#User-Agent)请求订阅源(v2.9.1新增)
- [x] 支持添加本地文件为订阅源(v2.9.5新增)
- [x] 远程配置数据源(v2.9.6新增)
- [x] 支持自定义[User-Agent](https://github.com/aiyakuaile/easy_tv_live?tab=readme-ov-file#User-Agent)(v2.9.7新增)

### TV版交互

⬆️上键：切换频道或线路

⬇️下键：切换频道或进入设置页面

🆗ok键：确认操作、显示频道列表

### 非TV版交互
![image_4](https://raw.githubusercontent.com/aiyakuaile/easy_tv_live/main/img_4.png)

### 远程配置功能
>支持远程配置的字段，您可以前往[极简TV远程配置项](https://aiyakuaile.github.io/tv-setting)页面进行设置。
设置完成后，您可以点击页面下方的`下载数据`或者`复制Json`按钮。
> 
> 拿到Json数据后，您可以在Github或Gitee(码云)新建一个仓库，将Json数据上传到仓库后，获取到上传过文件的Raw链接。
>
> 在添加远程配置链接之前，请先在浏览器尝试，确定链接是可以正常请求和返回Json数据的。
>
> 之后在应用的设置页面，`远程配置`一栏中添加此链接。
>
> TV端可以通过扫码推送添加后，程序会自动应用配置。其他端粘贴链接后，点击`应用远程配置`按钮，即可完成。
> >直接修改Json数据是不会生效的，当需要覆盖应用的设置时，Json字段中的`dtaId`必须改变。如果你使用的是[极简TV远程配置项](https://aiyakuaile.github.io/tv-setting)
来生成的Json数据的，则无需担心，程序会自动修改`dtaId`


### User-Agent
订阅源支持自定义User-Agent，程序会默认解析m3u文件中，如下格式的User-Agent设置
```
#UA-Hint: 请将 User-Agent 设置为 okHttp/Mod-1.0.0 ，否则无法观看
```
> 如果无法正常解析出User-Agent，请按照如何格式配置订阅源：
> ```
> https://xxxxxxxxxxxxx.m3u?ua=okHttp/Mod-1.0.0
> ```
> 如果订阅源已经有其他参数了，请按照如下格式添加：
> ```
> https://xxxxxxxxxxxxx.m3u?other=123&ua=okHttp/Mod-1.0.0
> ```
> 最后把修改后的订阅源添加到App中。应用解析到User-Agent后，会有一个toast提示，如：`User-Agent=okHttp/Mod-1.0.0`

### 自定义订阅源的显示标题
订阅源支持自定义显示标题，需要按照以下方式进行配置
 ```
 https://xxxxxxxxxxxxx.m3u?tl=自定义标题
  > 或者
 https://xxxxxxxxxxxxx.m3u?other=123&tl=自定义标题
 ```

### Basic认证
订阅源支持Basic认证请求，请求格式如下
```
https://username:password@xxxxxxxxx.m3u
例如：https://aiyakuaile:a123456@baidu.com/easy_tv_live/live.m3u
```
### 字体
支持切换的字体需要使用[easy_tv_font](https://github.com/aiyakuaile/easy_tv_font)这个项目,
您如果想要添加其他字体，请按照这个项目的提示进行操作。

> ios 支持12.0+以上版本，下载ipa后需要自行签名安装，例如：爱思助手,轻松签,巨魔等

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
