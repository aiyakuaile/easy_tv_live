// ==UserScript==
// @name         全网VIP视频破解去广告免费看+全网音乐下载+知乎增强+短视频无水印下载
// @namespace    http://www.zhmdy.top
// @version      6.4.1
// @description  本脚本精选解析线路为大家提供优酷、爱奇艺、腾讯、B站(bilibili)、乐视、芒果等各大视频网站(PC+移动端)视频解析服务，让你省去购买视频VIP费用，同时提供知乎增强(知乎视频下载、去广告、去除侧边栏、关键词屏蔽等会员功能)，全网音乐和有声书免客户端下载(网易云音乐、QQ音乐、酷狗、酷我、虾米、蜻蜓FM、荔枝FM、喜马拉雅等)，视频无水印下载(bilibili、抖音、快手、西瓜、youtube)，自动查券功能，所有功能互不影响，可独立开关。
// @author       zhmai
// @icon         data:image/png;base64,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
// @match        *://*.youku.com/*
// @match        *://*.iqiyi.com/*
// @match        *://*.iq.com/*
// @match        *://*.le.com/*
// @match        *://v.qq.com/*
// @match        *://m.v.qq.com/*
// @match        *://*.tudou.com/*
// @match        *://*.mgtv.com/*
// @match        *://tv.sohu.com/*
// @match        *://*.1905.com/*
// @match        *://film.sohu.com/*
// @match        *://*.bilibili.com/*
// @exclude      *://*.bilibili.com/bangumi/*
// @match        *://*.pptv.com/*
// @match        *://item.taobao.com/*
// @match        *://chaoshi.detail.tmall.com/*
// @match        *://detail.tmall.com/*
// @match        *://detail.tmall.hk/*
// @match        *://item.jd.com/*
// @match        *://*.yiyaojd.com/*
// @match        *://*.liangxinyao.com/*
// @match        *://music.163.com/*
// @match        *://y.qq.com/*
// @match        *://*.kugou.com/*
// @match        *://*.kuwo.cn/*
// @match        *://*.ximalaya.com/*
// @match        *://*.zhihu.com/*
// @match        *://*.douyin.com/*
// @match        *://*.kuaishou.com/*
// @match        *://*.ixigua.com/*
// @match        *://*.youtube.com/*
// @exclude      *://*.zhmdy.top/*
// @exclude      *://*.eggvod.cn/*
// @antifeature  referral-link 此提示为GreasyFork代码规范要求含有查券功能的脚本必须添加，实际使用无任何强制跳转，代码可查，请知悉。
// @require      https://lf26-cdn-tos.bytecdntp.com/cdn/expire-1-M/crypto-js/4.1.1/crypto-js.min.js
// @grant        GM_registerMenuCommand
// @grant        GM_unregisterMenuCommand
// @grant        GM_setValue
// @grant        GM_getValue
// @grant        GM_deleteValue
// @grant        GM_download
// @grant        GM_xmlhttpRequest
// @grant        GM_setClipboard
// @connect      iesdouyin.com
// @connect      47.99.158.118
// ==/UserScript==

(function() {
    'use strict';

    var domHead = document.getElementsByTagName('head')[0];

    var domStyle = document.createElement('style');

    domStyle.type = 'text/css';

    domStyle.rel = 'stylesheet';
    //平台判断
    var isMobile = /Android|webOS|iPhone|iPod|BlackBerry/i.test(navigator.userAgent);

    if(isMobile){

        let playLine = [
            {"name":"纯净1","url":"https://z1.m1907.top/?jx="},
            {"name":"B站1","url":"https://jx.bozrc.com:4433/player/?url="},
            {"name":"爱豆","url":"https://jx.aidouer.net/?url="},
            {"name":"CHok","url":"https://www.gai4.com/?url="},
            {"name":"OK","url":"https://okjx.cc/?url="},
            {"name":"RDHK","url":"https://jx.rdhk.net/?v="},
            {"name":"人人迷","url":"https://jx.blbo.cc:4433/?url="},
            {"name":"思古3","url":"https://jsap.attakids.com/?url="},
            {"name":"听乐","url":"https://jx.dj6u.com/?url="},
        ];

        let useWeb = ['m.bilibili.com','youku.com','www.youku.com','m.youku.com','m.v.qq.com','m.iqiyi.com','m.mgtv.com','m.tv.sohu.com','m.1905.com','m.pptv.com','m.le.com'];

        if(useWeb.indexOf(location.host) == -1){
            console.log('不是应用网站');return;
        }

        function setCookie(cname,cvalue,exdays){

            var d = new Date();

            d.setTime(d.getTime()+(exdays*24*60*60*1000));

            var expires = "expires="+d.toGMTString();

            document.cookie = cname+"="+cvalue+"; "+expires;
        }

        function getCookie(cname){
            var name = cname + "=";
            var ca = document.cookie.split(';');
            for(var i=0; i<ca.length; i++) {
                var c = ca[i].trim();
                if (c.indexOf(name)==0) { return c.substring(name.length,c.length); }
            }
            return "";
        }

        function createElement(dom,domId){

            var rootElement = document.body;

            var newElement = document.createElement(dom);

            newElement.id = domId;

            var newElementHtmlContent = document.createTextNode('');

            rootElement.appendChild(newElement);

            newElement.appendChild(newElementHtmlContent);

        }

        function toast(msg,duration){

            duration=isNaN(duration)?3000:duration;

            let toastDom = document.createElement('div');

            toastDom.innerHTML = msg;

            toastDom.style.cssText='padding:2px 15px;min-height: 36px;line-height: 36px;text-align: center;transform: translate(-50%);border-radius: 4px;color: rgb(255, 255, 255);position: fixed;top: 50%;left: 50%;z-index: 9999999;background: rgb(0, 0, 0);font-size: 16px;'

            document.body.appendChild(toastDom);

            setTimeout(function() {

                var d = 0.5;

                toastDom.style.webkitTransition = '-webkit-transform ' + d + 's ease-in, opacity ' + d + 's ease-in';

                toastDom.style.opacity = '0';

                setTimeout(function() { document.body.removeChild(toastDom) }, d * 1000);

            }, duration);

        }

        function playVideoFunc(){
            //css
            let playVideoStyle = `
            .zhm_play_vidoe_icon{
                padding-top:2px;cursor:pointer;
                z-index:9999999;
                display:block;
                position:fixed;let:0px;top:360px;text-align:center;overflow:visible
            }
            .zhm_play_video_wrap{
                position:fixed;left:40px;top:360px;
                z-index:9999999;
                overflow: hidden;
                width:300px;
            }
            .zhm_play_video_line{
                width:320px;
                height:316px;
                overflow-y:scroll;
                overflow-x:hidden;
            }
            .zhm_play_vide_line_ul{
                width:300px;
                display: flex;
                justify-content: flex-start;
                flex-flow: row wrap;
                list-style: none;
                padding:0px;
                margin:0px;

            }
            .zhm_play_video_line_ul_li{
                padding:4px 0px;
                margin:2px;
                width:30%;
                color:#FFF;
                text-align:center;
                background-color:#f24443;
                box-shadow:0px 0px 10px #fff;
                font-size:14px;
            }
            .zhm_play_video_line_ul_li:hover{
                color:#260033;
                background-color:#fcc0c0
            }
            .zhm_line_selected{
                color:#260033;
                background-color:#fcc0c0
            }

            .zhm_play_video_jx{
                width:100%;
                height:100%;
                z-index:999999;
                position: absolute;top:0px;padding:0px;
            }
            `;

            domStyle.appendChild(document.createTextNode(playVideoStyle));

            domHead.appendChild(domStyle);

            //template:icon,playLine;
            let playWrapHtml = "<div href='javascript:void(0)' target='_blank' style='' class='playButton zhm_play_vidoe_icon' id='zhmlogo'><img class='iconLogo' src='data:image/gif;base64,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' title='点击主图标弹出解析，点击右侧列表站内解析' style='width:40px'>";

            playWrapHtml += "<div class='playLineDiv zhm_play_video_wrap' style='display:none;'>"

            playWrapHtml += "<div class='zhm_play_video_line'>";

            playWrapHtml +="<div><ul class='zhm_play_vide_line_ul'>";

            playLine.forEach(function(item){

                let selected = '';

                if(getCookie('playLineAction') == item.url){

                    selected='zhm_line_selected';

                }

                playWrapHtml +=`<li class='playLineTd zhm_play_video_line_ul_li ${selected}' url='${item.url}' >${item.name}</li>`;

            })

            playWrapHtml +="</div></div></div>";

            //template:node;播放区域

            let playJxHtml = "<div class='zhm_play_video_jx'>";

            playJxHtml += "<iframe allowtransparency=true frameborder='0' scrolling='no' allowfullscreen=true allowtransparency=true name='jx_play' style='height:100%;width:100%' id='playIframe'></iframe></div>";

            //循环判断是否在播放页，是则执行下面
            let jxVideoData = [
                {funcName:"playVideo", node:".player__container" ,match:/https:\/\/v.qq.com\/x\/cover\/[a-zA-Z0-9]+.html/,areaClassName:'mod_episode',name:'qqPC'},
                {funcName:"playVideo", node:"#player-container" ,match:/https:\/\/v.qq.com\/x\/cover\/[a-zA-Z0-9]+\/[a-zA-Z0-9]+.html/,areaClassName:'mod_episode',name:'qqPC'},
                {funcName:"playVideo", node:".container-player" ,match:/v\.qq\.com\/x\/page/,areaClassName:'mod_episode'},
                {funcName:"playVideo", node:"#player",match:/m\.v\.qq\.com\/x\/m\/play\?cid/},
                {funcName:"playVideo", node:"#player",match:/m\.v\.qq\.com\/x\/play\.html\?cid=/},
                {funcName:"playVideo", node:"#player",match:/m\.v\.qq\.com\/play\.html\?cid\=/},
                {funcName:"playVideo", node:"#player",match:/m\.v\.qq\.com\/cover\/.*html/},

                {funcName:"playVideo", node:"#flashbox",match:/^https:\/\/www\.iqiyi\.com\/[vwa]\_/,areaClassName:'qy-episode-num',name:'iqiyiPc'},
                {funcName:"playVideo", node:".m-video-player-wrap",match:/^https:\/\/m.iqiyi\.com\/[vwa]\_/,areaClassName:'m-sliding-list'},
                {funcName:"playVideo", node:".intl-video-wrap",match:/^https:\/\/www\.iq\.com\/play\//,areaClassName:'m-sliding-list'},

                {funcName:"playVideo", node:"#player",match:/m\.youku\.com\/alipay_video\/id_/},
                {funcName:"playVideo", node:"#player",match:/m\.youku\.com\/video\/id_/},
                {funcName:"playVideo", node:"#player",match:/v\.youku\.com\/v_show\/id_/},

                {funcName:"playVideo", node:"#bilibili-player",nodeType:'id',match:/www\.bilibili\.com\/video/,name:'biliPc',areaClassName:'video-episode-card'},
                {funcName:"playVideo", node:"#player_module",nodeType:'id',match:/www\.bilibili\.com\/bangumi/,areaClassName:'ep-list-wrapper report-wrap-module'},
                {funcName:"playVideo", node:".player-container",nodeType:'class',match:/m\.bilibili\.com\/bangumi/,areaClassName:'ep-list-pre-container no-wrap'},
                {funcName:"playVideo", node:".mplayer",nodeType:'class',match:/m\.bilibili\.com\/video\//},

                {funcName:"playVideo", node:".video-area",nodeType:'class',match:/m\.mgtv\.com\/b/},
                {funcName:"playVideo", node:"#mgtv-player-wrap",nodeType:'id',match:/mgtv\.com\/b/,areaClassName:'episode-items clearfix'},
                {funcName:"playVideo", node:".x-player",nodeType:'class',match:/tv\.sohu\.com\/v/},
                {funcName:"playVideo", node:".x-cover-playbtn-wrap",nodeType:'class',match:/m\.tv\.sohu\.com/},
                {funcName:"playVideo", node:"#playerWrap",nodeType:'id',match:/film\.sohu\.com\/album\//},

                {funcName:"playVideo", node:"#le_playbox",nodeType:'id',match:/le\.com\/ptv\/vplay\//,areaClassName:'juji_grid'},

                {funcName:"playVideo", node:"#player",nodeType:'id',match:/play\.tudou\.com\/v_show\/id_/},

                {funcName:"playVideo", node:"#pptv_playpage_box",nodeType:'id',match:/v\.pptv\.com\/show\//},

                {funcName:"playVideo", node:"#player",nodeType:'id',match:/vip\.1905.com\/play\//},

                {funcName:"playVideo", node:"#vodPlayer",nodeType:'id',match:/www\.1905.com\/vod\/play\//},
            ];

            //创建logo_icon
            createElement('div','zhmIcon');

            let zhmPlay = document.getElementById('zhmIcon');

            zhmPlay.innerHTML = playWrapHtml;

            let jxVideoWeb = jxVideoData.filter(function(item){

                return location.href.match(item.match);

            })

            document.querySelector('#zhmlogo').addEventListener('click',function(){

                let jxVideoWeb = jxVideoData.filter(function(item){

                    return location.href.match(item.match);

                })

                if(jxVideoWeb.length == 0){

                    toast('请在视频播放页点击图标');

                }else{

                    var {funcName,match:nowMatch,node:nowNode,name:nowName} = jxVideoWeb[0];

                    let playLineDiv = document.querySelector('.zhm_play_video_wrap');

                    let playShow = playLineDiv.style.display;

                    playShow == 'none'? playLineDiv.style.display = 'block':playLineDiv.style.display = 'none';

                    var playLineTd = document.querySelectorAll('.playLineTd');

                    playLineTd.forEach(function(item){

                        item.addEventListener('click',function(){

                            playLineTd.forEach(function(e){

                                e.setAttribute('class','playLineTd zhm_play_video_line_ul_li');
                            })

                            this.setAttribute('class','playLineTd zhm_play_video_line_ul_li zhm_line_selected');

                            setCookie('playLineAction',this.getAttribute('url'),30);

                            let nowWebNode = document.querySelector(nowNode);

                            if(nowWebNode){

                                nowWebNode.innerHTML = playJxHtml;

                                let playIframe = document.querySelector('#playIframe');

                                playIframe.src= item.getAttribute('url')+location.href;

                            }else{

                                console.log('视频网站结点不存在');
                            }

                        })

                    })

                    return false;
                }

            })

            document.addEventListener('click',function(e){

                let i=0;

                e.path.forEach(function(item){

                    if(item.className=='iconLogo'){

                        i=1;

                        console.log(i);
                    }

                })

                if(i==0){

                    let isShow = document.querySelector('.zhm_play_video_wrap').style.display;

                    if(isShow == 'block'){

                        document.querySelector('.zhm_play_video_wrap').style.display='none';
                    }
                }
            })
        }

        playVideoFunc();

    }else{
        /*--config--*/
        var Config ={

        couponUrl:window.location.href,

        couponHost:window.location.host,

        zhmApiUrl:'https://www.eggvod.cn/',

        iconVipTop:360,

        iconVipPosition : 'left',

        iconVipWidth : 40,

        jxCodeInfo : {'in':81516699,'code':4},

        couponTimerNum : 100,//100次等于10秒

        couponWaitTime : 100,

        iconWaitTime : 100,

        selectedLeft:'selected',

        selectedRight:'',

        videoPlayLineAdd:GM_getValue('videoPlayLineAdd',0),

        dyVideoDownload:GM_getValue('dyVideoDownload',22),

        ksVideoDownload:GM_getValue('ksVideoDownload',22),

        xiguaVideoDownload:GM_getValue('xiguaVideoDownload',22),

        biliVideoDownload:GM_getValue('biliVideoDownload',22),

        youtubeVideoDownload:GM_getValue('youtubeVideoDownload',22),

        }

        var {couponUrl,
            couponHost,
            zhmApiUrl,
            iconVipTop,
            iconVipPosition,
            iconVipWidth,
            jxCodeInfo,
            couponTimerNum,
            couponWaitTime,
            iconWaitTime,
            selectedLeft,
            selectedRight,
            videoPlayLineAdd,
            dyVideoDownload,
            ksVideoDownload,
            xiguaVideoDownload,
            biliVideoDownload,
            youtubeVideoDownload
        } = Config;
        /*--lang--*/
        var lang = {
            set:'设置',
            iconPosition:'图标位置',
            playVideo:'视频解析',
            playMusic:'音乐下载',
            zhNice:'知乎增强',
            videoDownload:'视频下载',
            iconHeight:'图标高度',
            iconWidth:'图标大小',
            iconLine:'水平位置',
            iconWaitTime:'等待时间',
            iconLeft:'靠左',
            iconRight:'靠右',
            tipIconHeight:'默认360,建议1~500',
            tipIconWidth:'默认40,建议20~50',
            tipErrorIconHeight:'<图标位置>中的<图标高度>应为1000以内正整数，建议1~500',
            tipErrorIconWidth:'<图标位置>中的<图标大小>应为100以内正整数，建议20~50',
            setPlayVideo:'解析设置',
            playVideoLineAdd:'添加线路',
            tipPlayVideoLineAdd:'请输入线路名称和解析地址，例:"线路六https://jx.zdy.com/?url="，每线路一行。',
            zhSet:'知乎设置',
            zhVideoClose:'屏蔽视频',
            zhVideoDownload:'视频下载',
            zhADClose:'屏蔽广告',
            zhCloseLeft:'关闭侧边栏',
            zhChangeLink:'链接直接跳转',
            specialColumn:'标记文章',
            videoTitle:'标记视频',
            zhKeywordClose:'屏蔽关键词',
            tipKeyword:'请输入关键词,用","号隔开',
            authorNameClose:'屏蔽用户',
            tipAuthorName:'请输入用户名,用","号隔开',
            yanxuanClose:'屏蔽盐选',
            dyVideoDownload:'抖音下载',
            ksVideoDownload:'快手下载',
            xiguaVideoDownload:'西瓜下载',
            biliVideoDownload:'B站 (bilibili) 下载',
            youtubeVideoDownload:'youtube下载',
            question:'常见问题',
            qqGroup:'交流群',
            reward:'打赏',
            redReward:'红包',
            thank:'感谢',

        };

        /*--datas--*/
        var datas = {

            getCoupon:[{isOpen:22,web:[
                {funcName:"coupon",name:"taobao",node:".J_LinkAdd",match:/item\.taobao\.com/},
                {funcName:"coupon",name:"tmallCaoshi",node:"#J_LinkBuy",match:/^https?:\/\/chaoshi.detail.tmall.com\//},
                {funcName:"coupon",name:"tmall",node:".BasicContent--actions--1co8sx8",match:/^https?:\/\/detail\.tmall\.com/},
                {funcName:"coupon",name:"tmall",node:"#J_LinkBuy",match:/^https?:\/\/detail\.tmall\.com/},
                {funcName:"coupon",name:"tmallOther",node:".tm-msg-box",match:/^https?:\/\/detail\.tmall\.com/},
                {funcName:"coupon",name:"tmall",node:"#J_LinkBuy",match:/^https?:\/\/detail\.tmall\.hk/},
                {funcName:"coupon",name:"jd",node:"#choose-btns",match:/item\.jd\.com/},
                {funcName:"coupon",name:"jd",node:"#choose-btns",match:/\.yiyaojd\.com/},
            ]}],
            jxVideo:[{isOpen:GM_getValue('movieList','22'),web:[
                {funcName:"playVideo",match:/https?:\/\/v\.qq\.com/,name:'qqPC'},
                {funcName:"playVideo", match:/https?:\/\/m\.v\.qq\.com/,name:'qqMobile'},

                {funcName:"playVideo", match:/^https?:\/\/www\.iqiyi\.com/,name:'iqiyiPc'},
                {funcName:"playVideo", match:/^https?:\/\/www\.iq\.com/},
                {funcName:"playVideo", node:".m-video-player-wrap",match:/^https?:\/\/m.iqiyi\.com/,areaClassName:'m-sliding-list'},

                {funcName:"playVideo", node:"#player",nodeType:'id',match:/m\.youku\.com\/alipay_video\/id_/},
                {funcName:"playVideo", node:"#player",nodeType:'id',match:/m\.youku\.com\/video\/id_/},
                {funcName:"playVideo", match:/^https?:\/\/.*youku\.com/},

                {funcName:"playVideo", match:/^https?:\/\/www\.bilibili\.com/},
                {funcName:"playVideo", match:/^https?:\/\/m\.bilibili\.com/},

                {funcName:"playVideo", node:".video-area",nodeType:'class',match:/m\.mgtv\.com\/b/},
                {funcName:"playVideo", match:/mgtv\.com/,areaClassName:'episode-items clearfix'},
                {funcName:"playVideo", node:".x-cover-playbtn-wrap",nodeType:'class',match:/.tv\.sohu\.com/},
                {funcName:"playVideo", node:".x-cover-playbtn-wrap",nodeType:'class',match:/m\.tv\.sohu\.com/},
                {funcName:"playVideo", node:"#playerWrap",nodeType:'id',match:/film\.sohu\.com/},

                {funcName:"playVideo", match:/tudou\.com/},

                {funcName:"playVideo",match:/le\.com/},

                {funcName:"playVideo",match:/pptv\.com/},

                {funcName:"playVideo",match:/1905\.com/},

            ]}],
            /*
                bakjxVideo:[{isOpen:GM_getValue('movieList','22'),web:[
                    //{funcName:"playVideo", node:"#mod_player" ,nodeType:'id' ,match:/v\.qq\.com\/x\/cover/,areaClassName:'mod_episode'},
                    {funcName:"playVideo", node:"#mod_player" ,nodeType:'id' ,match:/https:\/\/v.qq.com\/x\/cover\/[a-zA-Z0-9]+.html/,areaClassName:'mod_episode',name:'qqPC'},
                    {funcName:"playVideo", node:"#mod_player" ,nodeType:'id' ,match:/https:\/\/v.qq.com\/x\/cover\/[a-zA-Z0-9]+\/[a-zA-Z0-9]+.html/,areaClassName:'mod_episode',name:'qqPC'},
                    {funcName:"playVideo", node:".container-player" ,nodeType:'class', match:/v\.qq\.com\/x\/page/,areaClassName:'mod_episode'},
                    {funcName:"playVideo", node:"#player",nodeType:'id',match:/m\.v\.qq\.com\/x\/m\/play\?cid/},
                    {funcName:"playVideo", node:"#player",nodeType:'id',match:/m\.v\.qq\.com\/x\/play\.html\?cid=/},
                    {funcName:"playVideo", node:"#player",nodeType:'id',match:/m\.v\.qq\.com\/play\.html\?cid\=/},
                    {funcName:"playVideo", node:"#player",nodeType:'id',match:/m\.v\.qq\.com\/cover\/.*html/},

                    {funcName:"playVideo", node:"#flashbox",nodeType:'id',match:/^https:\/\/www\.iqiyi\.com\/[vwa]\_/,areaClassName:'qy-episode-num',name:'iqiyiPc'},
                    {funcName:"playVideo", node:".m-video-player-wrap",nodeType:'class',match:/^https:\/\/m.iqiyi\.com\/[vwa]\_/,areaClassName:'m-sliding-list'},
                    {funcName:"playVideo", node:".intl-video-wrap",nodeType:'class',match:/^https:\/\/www\.iq\.com\/play\//,areaClassName:'m-sliding-list'},

                    {funcName:"playVideo", node:"#player",nodeType:'id',match:/m\.youku\.com\/alipay_video\/id_/},
                    {funcName:"playVideo", node:"#player",nodeType:'id',match:/m\.youku\.com\/video\/id_/},
                    {funcName:"playVideo", node:"#player",nodeType:'id',match:/v\.youku\.com\/v_show\/id_/},

                    {funcName:"playVideo", node:"#bilibiliPlayer",nodeType:'id',match:/www\.bilibili\.com\/video/},
                    {funcName:"playVideo", node:"#player_module",nodeType:'id',match:/www\.bilibili\.com\/bangumi/,areaClassName:'ep-list-wrapper report-wrap-module'},
                    {funcName:"playVideo", node:".player-container",nodeType:'class',match:/m\.bilibili\.com\/bangumi/,areaClassName:'ep-list-pre-container no-wrap'},
                    {funcName:"playVideo", node:".mplayer",nodeType:'class',match:/m\.bilibili\.com\/video\//},

                    {funcName:"playVideo", node:".video-area",nodeType:'class',match:/m\.mgtv\.com\/b/},
                    {funcName:"playVideo", node:"#mgtv-player-wrap",nodeType:'id',match:/mgtv\.com\/b/,areaClassName:'episode-items clearfix'},

                    {funcName:"playVideo", node:".x-cover-playbtn-wrap",nodeType:'class',match:/m\.tv\.sohu\.com/},
                    {funcName:"playVideo", node:"#playerWrap",nodeType:'id',match:/film\.sohu\.com\/album\//},

                    {funcName:"playVideo", node:"#le_playbox",nodeType:'id',match:/le\.com\/ptv\/vplay\//,areaClassName:'juji_grid'},
                    //无单独播放页{funcName:"playVideo", node:"j-player",nodeType:'id',match:/m\.le\.com\/vplay_\//},

                    {funcName:"playVideo", node:"#player",nodeType:'id',match:/play\.tudou\.com\/v_show\/id_/},

                    {funcName:"playVideo", node:"#pptv_playpage_box",nodeType:'id',match:/v\.pptv\.com\/show\//},
                    //{funcName:"playVideo", node:"pptv_playpage_box",nodeType:'id',match:/vip\.pptv\.com\/show\//},
                    //图标未显示{funcName:"playVideo", node:"pplive-player",nodeType:'id',match:/m\.pptv\.com\/show\//},

                    {funcName:"playVideo", node:"#player",nodeType:'id',match:/vip\.1905.com\/play\//},
                ]}],
        */
            jxMusic:[{isOpen:GM_getValue('musicList','22'),web:[
                {funcName:"playMusic",name:'netease',match:/^https?:\/\/music\.163\.com/,tip:'请在音乐单曲页点击图标下载'},

                {funcName:"playMusic",name:'qq',match:/^https?:\/\/y\.qq\.com/,tip:'请点击播放需要下载的歌曲，在播放页点击图标下载'},

                {funcName:"playMusic",name:'kugou',match:/kugou\.com/,tip:'请点击播放需要下载的歌曲，然后在网页下方播放器内点击"下载"'},

                {funcName:"playMusic",name:'kuwo',match:/kuwo\.cn/,tip:'请点击播放需要下载的歌曲，然后在网页下方播放器内点击"下载"'},

                {funcName:"playMusic",name:'ximalaya',match:/^https?:\/\/www\.ximalaya\.com/,tip:'请点击播放需要下载的歌曲，然后在网页下方播放器内点击"下载"'}
            ]}],

            playLine:[
                {"name":"纯净1","url":"https://z1.m1907.top/?jx=","mobile":1},
                {"name":"B站1","url":"https://jx.bozrc.com:4433/player/?url=","mobile":1},
                {"name":"爱豆","url":"https://jx.aidouer.net/?url=","mobile":1},
                {"name":"BL","url":"https://vip.bljiex.com/?v=","mobile":0},
                {"name":"冰豆","url":"https://api.qianqi.net/vip/?url=","mobile":0},
                {"name":"百域","url":"https://jx.618g.com/?url=","mobile":0},
                {"name":"CK","url":"https://www.ckplayer.vip/jiexi/?url=","mobile":0},
                {"name":"CHok","url":"https://www.gai4.com/?url=","mobile":1},
                {"name":"ckmov","url":"https://www.ckmov.vip/api.php?url=","mobile":0},
                {"name":"H8","url":"https://www.h8jx.com/jiexi.php?url=","mobile":0},
                {"name":"JY","url":"https://jx.playerjy.com/?url=","mobile":0},
                {"name":"解析","url":"https://ckmov.ccyjjd.com/ckmov/?url=","mobile":0},
                {"name":"解析la","url":"https://api.jiexi.la/?url=","mobile":0},
                {"name":"老板","url":"https://vip.laobandq.com/jiexi.php?url=","mobile":0},
                {"name":"MAO","url":"https://www.mtosz.com/m3u8.php?url=","mobile":0},
                {"name":"M3U8","url":"https://jx.m3u8.tv/jiexi/?url=","mobile":0},
                {"name":"诺讯","url":"https://www.nxflv.com/?url=","mobile":0},
                {"name":"OK","url":"https://okjx.cc/?url=","mobile":1},
                {"name":"PM","url":"https://www.playm3u8.cn/jiexi.php?url=","mobile":0},
                {"name":"盘古","url":"https://www.pangujiexi.cc/jiexi.php?url=","mobile":0},
                {"name":"七哥","url":"https://jx.nnxv.cn/tv.php?url=","mobile":0},
                {"name":"RDHK","url":"https://jx.rdhk.net/?v=","mobile":1},
                {"name":"人人迷","url":"https://jx.blbo.cc:4433/?url=","mobile":1},
                {"name":"思云","url":"https://jx.ap2p.cn/?url=","mobile":0},
                {"name":"思古3","url":"https://jsap.attakids.com/?url=","mobile":1},
                {"name":"听乐","url":"https://jx.dj6u.com/?url=","mobile":1},
                {"name":"维多","url":"https://jx.ivito.cn/?url=","mobile":0},
                {"name":"虾米","url":"https://jx.xmflv.com/?url=","mobile":0},
                {"name":"云端","url":"https://sb.5gseo.net/?url=","mobile":0},
                {"name":"云析","url":"https://jx.yparse.com/index.php?url=","mobile":0},
                {"name":"0523","url":"https://go.yh0523.cn/y.cy?url=","mobile":0},
                {"name":"17云","url":"https://www.1717yun.com/jx/ty.php?url=","mobile":0},
                {"name":"180","url":"https://jx.000180.top/jx/?url=","mobile":0},
                {"name":"4K","url":"https://jx.4kdv.com/?url=","mobile":1},
                {"name":"8090","url":"https://www.8090g.cn/?url=","mobile":0}
            ],

            zhNice:[{isOpen:GM_getValue('zhihuList','22'),web:[
                {funcName:'zhNice',match:/^https?:\/\/[a-z]+\.zhihu\.com/}
            ]}],
            /*
                douYin:[{isOpen:GM_getValue('douyinList','22'),web:[
                    {funcName:'douyinDownload',match:/^https?:\/\/www\.douyin\.com\/?[^.+]$/},
                    {funcName:'douyinDownload',match:/^https?:\/\/www\.douyin\.com\/\?enter\=guide$/},
                ]}],
        */
            videoDownload:[{isOpen:GM_getValue('videoDownloadList','22'),web:[
                /*
                    {funcName:'videoDownload',name:'dyVideoDownload',match:/^https?:\/\/www\.douyin\.com\/?[^.+]$/},
                    {funcName:'videoDownload',name:'dyVideoDownload',match:/^https?:\/\/www\.douyin\.com\/\?enter\=guide$/},
                    {funcName:'videoDownload',name:'dyVideoDownload',match:/^https?:\/\/www\.douyin\.com\/follow$/},
                    {funcName:'videoDownload',name:'dyVideoDownload',match:/^https?:\/\/www\.douyin\.com\/vs$/},
                    {funcName:'videoDownload',name:'dyVideoDownload',match:/^https?:\/\/www\.douyin\.com\/discover\?modal_id=.+$/}
                    */
                {funcName:'videoDownload',name:'dyVideoDownload',match:/^https?:\/\/www\.douyin\.com\/?.+$/,isWebOpen:dyVideoDownload},
                {funcName:'videoDownload',name:'ksVideoDownload',match:/^https?:\/\/www\.kuaishou\.com\/?.+$/,isWebOpen:ksVideoDownload},
                //{funcName:'videoDownload',name:'xiguaVideoDownload',match:/^https?:\/\/www\.ixigua\.com\/[0-9]+\?.+$/,isWebOpen:xiguaVideoDownload},
                {funcName:'videoDownload',name:'xiguaVideoDownload',match:/^https?:\/\/www\.ixigua\.com\//,isWebOpen:xiguaVideoDownload},
                {funcName:'videoDownload',name:'biliVideoDownload',match:/^https?:\/\/www\.bilibili\.com\//,isWebOpen:biliVideoDownload},
                {funcName:'videoDownload',name:'youtubeVideoDownload',match:/^https?:\/\/www\.youtube\.com/,isWebOpen:youtubeVideoDownload},
            ]}],

            keyCode:[
                {code:48,isShift:false,value:'0'},
                {code:48,isShift:true,value:')'},
                {code:49,isShift:false,value:'1'},
                {code:49,isShift:true,value:'!'},
                {code:50,isShift:false,value:'2'},
                {code:50,isShift:true,value:'@'},
                {code:51,isShift:false,value:'3'},
                {code:51,isShift:true,value:'#'},
                {code:52,isShift:false,value:'4'},
                {code:52,isShift:true,value:'$'},
                {code:53,isShift:false,value:'5'},
                {code:53,isShift:true,value:'%'},
                {code:54,isShift:false,value:'6'},
                {code:54,isShift:true,value:'^'},
                {code:55,isShift:false,value:'7'},
                {code:55,isShift:true,value:'&'},
                {code:56,isShift:false,value:'8'},
                {code:56,isShift:true,value:'*'},
                {code:57,isShift:false,value:'9'},
                {code:57,isShift:true,value:'('},
                {code:70,isShift:false,value:'f'},
                {code:70,isShift:true,value:'F'},
                {code:74,isShift:false,value:'j'},
                {code:74,isShift:true,value:'J'},
                {code:75,isShift:false,value:'k'},
                {code:75,isShift:true,value:'K'},
                {code:76,isShift:false,value:'l'},
                {code:76,isShift:true,value:'L'},
            ],

            downloadOption:[{name:'直接下载',id:'toDownload'},{name:'复制链接',id:'toCopy'},{name:'打开文件',id:'toLink'}]

        }

        var {getCoupon,jxVideo,jxMusic,playLine,zhNice,videoDownload,keyCode,downloadOption} = datas;

        /*--Class--*/
        class BaseClass{

            constructor(){

                if(GM_getValue('iconPositionSetPage') != 0){

                    iconVipTop = this.getCookie('iconTop')?this.getCookie('iconTop'):iconVipTop;

                    iconVipPosition = this.getCookie('iconPosition')?this.getCookie('iconPosition'):iconVipPosition;

                    selectedLeft = iconVipPosition=='left'?'selected':'';

                    selectedRight = iconVipPosition=='right'?'selected':'';

                    iconVipWidth = this.getCookie('iconWidth')?this.getCookie('iconWidth'):iconVipWidth;

                    iconWaitTime = GM_getValue('iconWaitTime')?GM_getValue('iconWaitTime')*1000:iconWaitTime;

                }

                GM_registerMenuCommand("设置", () => this.menuSet());

            }

            menuSet(){

                var _this = this;

                let menuSetStyle = `
                        .zhmMask{
                            z-index:999999999;
                            background-color:#000;
                            position: fixed;top: 0;right: 0;bottom: 0;left: 0;
                            opacity:0.8;
                        }
                        .wrap-box{
                            z-index:1000000000;
                            position:fixed;;top: 50%;left: 50%;transform: translate(-50%, -200px);
                            width: 300px;
                            color: #555;
                            background-color: #fff;
                            border-radius: 5px;
                            overflow:hidden;
                            font:16px numFont,PingFangSC-Regular,Tahoma,Microsoft Yahei,sans-serif !important;
                            font-weight:400 !important;
                        }
                        .setWrapHead{
                            background-color:#f24443;height:40px;color:#fff;text-align:center;line-height:40px;
                        }
                        .setWrapLi{
                            margin:0px;padding:0px;
                        }
                        .setWrapLi li{
                            background-color: #fff;
                            border-bottom:1px solid #eee;
                            margin:0px !important;
                            padding:12px 20px;
                            display: flex;
                            justify-content: space-between;align-items: center;
                            list-style: none;
                        }

                        .setWrapLiContent{
                            display: flex;justify-content: space-between;align-items: center;
                        }
                        .setWrapSave{
                            position:absolute;top:-2px;right:10px;font-size:24px;cursor:pointer
                        }
                        .iconSetFoot{
                            position:absolute;bottom:0px;padding:10px 20px;width:100%;
                        z-index:1000000009;background:#fef9ef;
                        }
                        .iconSetFootLi{
                            margin:0px;padding:0px;
                        }

                        .iconSetFootLi li{
                            display: inline-flex;
                            padding:0px 2px;
                            justify-content: space-between;align-items: center;
                            font-size: 12px;
                        }
                        .iconSetFootLi li a{
                            color:#555;
                        }
                        .iconSetFootLi a:hover {
                            color:#fe6d73;
                        }
                        .iconSetPage{
                            z-index:1000000001;
                            position:absolute;top:0px;left:300px;
                            background:#fff;
                            width:300px;
                            height:100%;
                        }
                        .iconSetUlHead{
                        padding:0px;
                        margin:0px;
                        }
                        .iconSetPageHead{
                            border-bottom:1px solid #ccc;
                            height:40px;
                            line-height:40px;
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                            background-color:#fe6d73;
                            color:#fff;
                            font-size: 15px;
                        }
                        .iconSetPageLi{
                            margin:0px;padding:0px;
                        }
                        .iconSetPageLi li{
                            list-style: none;
                            padding:8px 20px;
                        }
                        .zhihuSetPage{
                            z-index:1000000002;position:absolute;top:0px;left:300px;background:#fff;width:300px;height:100%;
                        }
                        .iconSetPageInput{
                            display: flex !important;justify-content: space-between;align-items: center;
                        }
                        .zhihuSetPageLi{
                            margin:0px;padding:0px;
                            height:258px;
                            overflow-y: scroll;
                        }
                        .zhihuSetPageLi::-webkit-scrollbar {
                            /*滚动条整体样式*/
                            width : 2px;  /*高宽分别对应横竖滚动条的尺寸*/
                            height: 1px;
                        }
                        .zhihuSetPageLi::-webkit-scrollbar-thumb {
                            /*滚动条里面小方块*/
                            border-radius   : 2px;
                            background-color: #fe6d73;
                        }
                        .zhihuSetPageLi::-webkit-scrollbar-track {
                            /*滚动条里面轨道*/
                            box-shadow   : inset 0 0 5px rgba(0, 0, 0, 0.2);
                            background   : #ededed;
                            border-radius: 10px;
                        }
                        .zhihuSetPageLi li{
                            border-bottom:1px solid #eee;padding:12px 20px;display:block;
                        }
                        .zhihuSetPageContent{
                            display: flex !important;justify-content: space-between;align-items: center;
                        }

                        .circular{
                            width: 40px;height: 20px;border-radius: 16px;transition: .3s;cursor: pointer;box-shadow: 0 0 3px #999 inset;
                        }
                        .round-button{
                            width: 20px;height: 20px;;border-radius: 50%;box-shadow: 0 1px 5px rgba(0,0,0,.5);transition: .3s;position: relative;
                        }
                        .back{
                            border: solid #FFF; border-width: 0 3px 3px 0; display: inline-block; padding: 3px;transform: rotate(135deg);  -webkit-transform: rotate(135deg);margin-left:10px;cursor:pointer;
                        }
                        .to-right{
                            margin-left:20px; display: inline-block; padding: 3px;transform: rotate(-45deg); -webkit-transform: rotate(-45deg);cursor:pointer;

                        }
                        .iconSetSave{
                            font-size:24px;cursor:pointer;margin-right:5px;margin-bottom:4px;color:#FFF;
                        }
                        .zhm_set_page{
                            z-index:1000000003;
                            position:absolute;
                            top:0px;left:300px;
                            background:#fff;
                            width:300px;
                            height:100%;
                        }
                        .zhm_set_page_header{
                            border-bottom:1px solid #ccc;
                            height:40px;
                            line-height:40px;
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                            background-color:#fe6d73;
                            color:#fff;
                            font-size: 15px;
                        }
                        .zhm_set_page_content{
                            display: flex !important;justify-content: space-between;align-items: center;
                        }
                        .zhm_set_page_list{
                            margin:0px;padding:0px;
                        }
                        .zhm_set_page_list li{
                            /*border-bottom:1px solid #ccc;*/
                            padding:12px 20px;
                            display:block;
                            border-bottom:1px solid #eee;
                        }
                        li:last-child{
                            border-bottom:none;
                        }
                        /*-form-*/
                        :root {
                            --base-color: #434a56;
                            --white-color-primary: #f7f8f8;
                            --white-color-secondary: #fefefe;
                            --gray-color-primary: #c2c2c2;
                            --gray-color-secondary: #c2c2c2;
                            --gray-color-tertiary: #676f79;
                            --active-color: #227c9d;
                            --valid-color: #c2c2c2;
                            --invalid-color: #f72f47;
                            --invalid-icon: url("data:image/svg+xml;charset=utf8,%3Csvg%20xmlns%3D%22http%3A%2F%2Fwww.w3.org%2F2000%2Fsvg%22%20width%3D%2224%22%20height%3D%2224%22%20viewBox%3D%220%200%2024%2024%22%3E%20%3Cpath%20d%3D%22M13.41%2012l4.3-4.29a1%201%200%201%200-1.42-1.42L12%2010.59l-4.29-4.3a1%201%200%200%200-1.42%201.42l4.3%204.29-4.3%204.29a1%201%200%200%200%200%201.42%201%201%200%200%200%201.42%200l4.29-4.3%204.29%204.3a1%201%200%200%200%201.42%200%201%201%200%200%200%200-1.42z%22%20fill%3D%22%23f72f47%22%20%2F%3E%3C%2Fsvg%3E");
                        }
                        .text-input {
                            font-size: 16px;
                            position: relative;
                            right:0px;
                            z-index: 0;
                        }
                        .text-input__body {
                            -webkit-appearance: none;
                            -moz-appearance: none;
                            appearance: none;
                            background-color: transparent;
                            border: 1px solid var(--gray-color-primary);
                            border-radius: 3px;
                            height: 1.7em;
                            line-height: 1.7;
                            overflow: hidden;
                            padding: 2px 1em;
                            text-overflow: ellipsis;
                            transition: background-color 0.3s;
                            width:55%;
                            font-size:14px;
                        }
                        .text-input__body:-ms-input-placeholder {
                            color: var(--gray-color-secondary);
                        }
                        .text-input__body::-moz-placeholder {
                            color: var(--gray-color-secondary);
                        }
                        .text-input__body::placeholder {
                            color: var(--gray-color-secondary);
                        }
                        *, ::after, ::before {
                        box-sizing: initial !important;
                        }
                        .text-input__body[data-is-valid] {
                            padding-right: 1em;
                        }
                        .text-input__body[data-is-valid=true] {
                            border-color: var(--valid-color);
                        }
                        .text-input__body[data-is-valid=false] {
                            border-color: var(--invalid-color);
                            box-shadow: inset 0 0 0 1px var(--invalid-color);
                        }
                        .text-input__body:focus {
                            border-color: var(--active-color);
                            box-shadow: inset 0 0 0 1px var(--active-color);
                            outline: none;
                        }
                        .text-input__body:-webkit-autofill {
                            transition-delay: 9999s;
                            -webkit-transition-property: background-color;
                            transition-property: background-color;
                        }
                        .text-input__validator {
                            background-position: right 0.5em center;
                            background-repeat: no-repeat;
                            background-size: 1.5em;
                            display: inline-block;
                            height: 100%;
                            left: 0;
                            position: absolute;
                            top: 0;
                            width: 100%;
                            z-index: -1;
                        }
                        .text-input__body[data-is-valid=false] + .text-input__validator {
                            background-image: var(--invalid-icon);
                        }
                        .select-box {
                            box-sizing: inherit;
                            font-size: 16px;
                            position: relative;
                            transition: background-color 0.5s ease-out;
                            width:90px;
                        }
                        .select-box::after {
                            border-color: var(--gray-color-secondary) transparent transparent transparent;
                            border-style: solid;
                            border-width: 6px 4px 0;
                            bottom: 0;
                            content: "";
                            display: inline-block;
                            height: 0;
                            margin: auto 0;
                            pointer-events: none;
                            position: absolute;
                            right: -72px;
                            top: 0;
                            width: 0;
                            z-index: 1;
                        }
                        .select-box__body {
                            box-sizing: inherit;
                            -webkit-appearance: none;
                            -moz-appearance: none;
                            appearance: none;
                            background-color: transparent;
                            border: 1px solid var(--gray-color-primary);
                            border-radius: 3px;
                            cursor: pointer;
                            height: 1.7em;
                            line-height: 1.7;
                            padding-left: 1em;
                            padding-right: calc(1em + 16px);
                            width: 140%;
                            font-size:14px;
                            padding-top:2px;
                            padding-bottom:2px;
                        }
                        .select-box__body[data-is-valid=true] {
                            border-color: var(--valid-color);
                            box-shadow: inset 0 0 0 1px var(--valid-color);
                        }
                        .select-box__body[data-is-valid=false] {
                            border-color: var(--invalid-color);
                            box-shadow: inset 0 0 0 1px var(--invalid-color);
                        }
                        .select-box__body.focus-visible {
                            border-color: var(--active-color);
                            box-shadow: inset 0 0 0 1px var(--active-color);
                            outline: none;
                        }
                        .select-box__body:-webkit-autofill {
                            transition-delay: 9999s;
                            -webkit-transition-property: background-color;
                            transition-property: background-color;
                        }
                        .textarea__body {
                            -webkit-appearance: none;
                            -moz-appearance: none;
                            appearance: none;
                            background-color: transparent;
                            border: 1px solid var(--gray-color-primary);
                            border-radius: 0;
                            box-sizing: border-box;
                            font: inherit;
                            left: 0;
                            letter-spacing: inherit;
                            overflow: hidden;
                            padding: 1em;
                            position: absolute;
                            resize: none;
                            top: 0;
                            transition: background-color 0.5s ease-out;
                            width: 100%;
                            }
                        .textarea__body:only-child {
                            position: relative;
                            resize: vertical;
                        }
                        .textarea__body:focus {
                            border-color: var(--active-color);
                            box-shadow: inset 0 0 0 1px var(--active-color);
                            outline: none;
                        }
                        .textarea__body[data-is-valid=true] {
                            border-color: var(--valid-color);
                            box-shadow: inset 0 0 0 1px var(--valid-color);
                        }
                        .textarea__body[data-is-valid=false] {
                            border-color: var(--invalid-color);
                            box-shadow: inset 0 0 0 1px var(--invalid-color);
                        }

                        .textarea ._dummy-box {
                            border: 1px solid;
                            box-sizing: border-box;
                            min-height: 240px;
                            overflow: hidden;
                            overflow-wrap: break-word;
                            padding: 1em;
                            visibility: hidden;
                            white-space: pre-wrap;
                            word-wrap: break-word;
                        }
                        .toLeftMove{
                            nimation:moveToLeft 0.5s infinite;
                            -webkit-animation:moveToLeft 0.5s infinite; /*Safari and Chrome*/
                            animation-iteration-count:1;
                            animation-fill-mode: forwards;
                        }

                        @keyframes moveToLeft{
                            from {left:200px;}
                            to {left:0px;}
                        }

                        @-webkit-keyframes moveToLeft /*Safari and Chrome*/{
                            from {left:200px;}
                            to {left:0px;}
                        }

                        .toRightMove{
                            nimation:moveToRight 2s infinite;
                            -webkit-animation:moveToRight 2s infinite; /*Safari and Chrome*/
                            animation-iteration-count:1;
                            animation-fill-mode: forwards;
                        }
                        @keyframes moveToRight{
                            from {left:0px;}
                            to {left:2000px;}
                        }

                        @-webkit-keyframes moveToRight /*Safari and Chrome*/{
                            from {left:0px;}
                            to {left:200px;}
                        }
                    `;

                domStyle .appendChild(document.createTextNode(menuSetStyle));

                domHead.appendChild(domStyle);

                var setListJson= [
                    {'listName':lang.iconPosition,'setListID':'iconPositionSetPage','setPageID':'movieIconSetPage','takePlace':'0px'},
                    {'listName':lang.playVideo,'setListID':'movieList','setPageID':'movieVideoSetPage','takePlace':'0px'},
                    {'listName':lang.playMusic,'setListID':'musicList','setPageID':'','takePlace':''},
                    {'listName':lang.zhNice,'setListID':'zhihuList','setPageID':'zhihuIconSetPage','takePlace':'220px'},
                    {'listName':lang.videoDownload,'setListID':'videoDownloadList','setPageID':'videoDownloadSetPage','takePlace':'0px'},
                ];

                var zhihuOptionJson = [
                    {'optionName':lang.zhVideoClose,'optionID':'removeVideo','default':'0'},
                    {'optionName':lang.zhVideoDownload,'optionID':'downloadVideo','default':'22'},
                    {'optionName':lang.zhADClose,'optionID':'removeAD','default':'22'},
                    {'optionName':lang.zhCloseLeft,'optionID':'removeRight','default':'0'},
                    {'optionName':lang.zhChangeLink,'optionID':'changeLink','default':'22'},
                    {'optionName':lang.specialColumn,'optionID':'specialColumn','default':22},
                    {'optionName':lang.videoTitle,'optionID':'videoTitle','default':22},
                    {'optionName':lang.zhKeywordClose,'optionID':'removeKeyword','default':'0'},
                    {'optionName':lang.authorNameClose,'optionID':'removeAuthorName','default':'0'},
                    {'optionName':lang.yanxuanClose,'optionID':'removeYanxuan','default':'0'}
                ];

                var playVideoOptionJson = [{'optionName':'添加线路','optionID':'videoPlayLineAdd','default':videoPlayLineAdd}];

                var videoDownloadOptionJson = [
                    {'optionName':lang.dyVideoDownload,'optionID':'dyVideoDownload','default':dyVideoDownload},
                    {'optionName':lang.ksVideoDownload,'optionID':'ksVideoDownload','default':ksVideoDownload},
                    {'optionName':lang.xiguaVideoDownload,'optionID':'xiguaVideoDownload','default':xiguaVideoDownload},
                    {'optionName':lang.biliVideoDownload,'optionID':'biliVideoDownload','default':biliVideoDownload},
                    {'optionName':lang.youtubeVideoDownload,'optionID':'youtubeVideoDownload','default':youtubeVideoDownload},
                ];

                var setHtml = "<div id='setMask' class='zhmMask'></div>";

                setHtml +="<div class='wrap-box' id='setWrap'>";

                setHtml +="<div class='iconSetPage' id='movieIconSetPage'>";

                setHtml +="<ul class='iconSetUlHead'><li class='iconSetPageHead'><span class='back'></span><span>"+lang.iconPosition+"</span><span class='iconSetSave'>×</span></li></ul>";

                setHtml +="<ul class='iconSetPageLi'>";

                setHtml +="<li>"+lang.iconHeight+"：<span class='text-input'><input class='text-input__body' id='iconTop' value='"+iconVipTop+"' placeholder='"+lang.tipIconHeight+"'><span class='text-input__validator'></span></span></li>";

                setHtml += "<li  style='display: inline-flex;'><span style='padding-top:4px;'>"+lang.iconLine+"：</span><div class='select-box'><select class='select-box__body' id='iconPosition'>";

                setHtml +="<option value='left' "+selectedLeft+">"+lang.iconLeft+"</option><option value='right' "+selectedRight+">"+lang.iconRight+"</option>";

                setHtml +="</select></div></li>"

                setHtml +="<li>"+lang.iconWidth+"：<span class='text-input'><input class='text-input__body' id='iconWidth' value='"+iconVipWidth+"' placeholder='"+lang.tipIconWidth+"'><span class='text-input__validator'></span></span></li>";

                setHtml += "<li  style='display: inline-flex;'><span style='padding-top:4px;'>"+lang.iconWaitTime+"：</span><div class='select-box'><select class='select-box__body' id='iconWaitTime'>";

                for(let i =1;i<=8;i++){

                    let iconSelected = GM_getValue('iconWaitTime')==i/2?'selected':'';

                    setHtml +="<option value="+i/2+" "+iconSelected+">"+i/2+"秒</option>";

                }

                setHtml +="</select></div></li>"

                setHtml +="</ul></div>";

                setHtml +="<div class='zhm_set_page' id='videoDownloadSetPage'>";

                setHtml +="<ul class='iconSetUlHead'><li class='zhm_set_page_header'><span class='back'></span><span>"+lang.videoDownload+"</span><span  class='iconSetSave'>×</li></ul>";

                setHtml +="<ul class='zhm_set_page_list'>";

                for(let i=0;i<videoDownloadOptionJson.length;i++){

                    let backColor,switchBackCorlor,display;

                    let optionValue = GM_getValue(videoDownloadOptionJson[i].optionID,videoDownloadOptionJson[i].default);

                    if(optionValue != '22'){

                        backColor = '#fff';

                        switchBackCorlor = '#FFF';

                        display = 'none';

                    }else{

                        backColor = '#fe6d73';

                        switchBackCorlor = '#FFE5E5';

                        display = 'block';

                    }

                    setHtml +="<li>";

                    setHtml +="<div class='zhm_set_page_content'>";

                    setHtml += "<span>"+videoDownloadOptionJson[i].optionName+"</span>";

                    setHtml +="<div class='circular' style='background-color:"+switchBackCorlor+"' id='"+videoDownloadOptionJson[i].optionID+"'>";

                    setHtml +="<div class='round-button' style='background: "+backColor+"; left: "+optionValue+"px;'></div>";

                    setHtml += "</div></div>";

                    setHtml += "</li>";
                }

                setHtml +="</ul>"

                setHtml +="</div>"

                setHtml +="<div class='zhm_set_page' id='movieVideoSetPage'>";

                setHtml +="<ul class='iconSetUlHead'><li class='zhm_set_page_header'><span class='back'></span><span>"+lang.setPlayVideo+"</span><span  class='iconSetSave'>×</li></ul>";

                setHtml +="<ul class='zhm_set_page_list'>";

                for(let i=0;i<playVideoOptionJson.length;i++){

                    let backColor,switchBackCorlor,display;

                    let optionValue = GM_getValue(playVideoOptionJson[i].optionID,playVideoOptionJson[i].default);

                    if(optionValue != '22'){

                        backColor = '#fff';

                        switchBackCorlor = '#FFF';

                        display = 'none';

                    }else{

                        backColor = '#fe6d73';

                        switchBackCorlor = '#FFE5E5';

                        display = 'block';

                    }

                    setHtml +="<li>";

                    setHtml +="<div class='zhm_set_page_content'>";

                    setHtml += "<span>"+lang.playVideoLineAdd+"</span>";

                    setHtml +="<div class='circular' style='background-color:"+switchBackCorlor+"' id='"+playVideoOptionJson[i].optionID+"'>";

                    setHtml +="<div class='round-button' style='background: "+backColor+"; left: "+optionValue+"px;'></div>";

                    setHtml += "</div></div>";

                    setHtml +="<div class='form__textarea'>";

                    setHtml +="<div class='textarea js-flexible-textarea' style='margin-top: 10px; display: "+display+"; padding: 5px 0px;' id='videoPlayLineAddTextarea'>";

                    setHtml +="<textarea rows='5' class='textarea__body' placeholder='"+lang.tipPlayVideoLineAdd+"' style='width:250px;font-size:14px;padding:4px;resize:none;' id='playVideoLineTextarea'>"+GM_getValue('playVideoLineText','')+"</textarea>";

                    setHtml +="</div></div></li>";
                }

                setHtml +="</ul>"

                setHtml +="</div>"

                setHtml +="<div class='zhihuSetPage' id='zhihuIconSetPage'>";

                setHtml +="<ul class='iconSetUlHead'><li class='iconSetPageHead'><span class='back'></span><span>"+lang.zhSet+"</span><span  class='iconSetSave'>×</li></ul>";

                setHtml +="<ul class='zhihuSetPageLi'>";

                for(var optionN=0;optionN<zhihuOptionJson.length;optionN++){

                    let backColor,switchBackCorlor;

                    let optionValue = GM_getValue(zhihuOptionJson[optionN].optionID,zhihuOptionJson[optionN].default);

                    if(optionValue != '22'){

                        backColor = '#fff';

                        switchBackCorlor = '#FFF';

                    }else{

                        backColor = '#fe6d73';

                        switchBackCorlor = '#FFE5E5';

                    }

                    setHtml +="<li ><div class='zhihuSetPageContent'><span>"+zhihuOptionJson[optionN].optionName+"</span>";

                    setHtml +="<div class='circular' style='background-color: "+switchBackCorlor+";' id="+zhihuOptionJson[optionN].optionID+"><div class='round-button' style='background: "+backColor+";left: "+optionValue+"px;'></div></div></div>";

                    if(zhihuOptionJson[optionN].optionID == 'removeKeyword'){

                        var keywordShow;

                        if(GM_getValue('removeKeyword','0') == '22'){

                            keywordShow = 'block';

                        }else{
                            keywordShow = 'none';
                        }

                        setHtml +="<div style='margin-top:10px;display:"+keywordShow+";padding:5px 0px;' id='zhihuKeyword'><span class='text-input'><input value='"+GM_getValue('inputZhKeyword','')+"' id='inputZhKeyword' class='text-input__body' placeholder='"+lang.tipKeyword+"' style='width:88%'><span></div>";
                    }

                    if(zhihuOptionJson[optionN].optionID == 'removeAuthorName'){

                        var authorNameShow;

                        if(GM_getValue('removeAuthorName','0') == '22'){

                            authorNameShow = 'block';

                        }else{
                            authorNameShow = 'none';
                        }

                        setHtml +="<div style='margin-top:10px;display:"+authorNameShow+";padding:5px 0px;' id='zhihuAuthorName'><span class='text-input'><input value='"+GM_getValue('inputZhAuthorName','')+"' id='inputZhAuthorName' class='text-input__body' placeholder='"+lang.tipAuthorName+"' style='width:88%'><span></div>";
                    }
                    setHtml +="</li>";
                }

                setHtml +="</ul>"

                setHtml +="</div>";

                setHtml +="<ul class='iconSetUlHead'><li class='iconSetPageHead'><span></span><span>"+lang.set+"</span><span class='iconSetSave'>×</span></li></ul>";

                setHtml +="<ul class='setWrapLi'>";

                for(var setN=0;setN<setListJson.length;setN++){

                    var listValue = GM_getValue(setListJson[setN].setListID,'22');

                    let backColor,arrowColor,switchBackCorlor;

                    if(listValue != 22){
                        backColor = '#fff';
                        arrowColor= '#EEE';
                        switchBackCorlor = '#FFF';

                    }else{
                        backColor = '#fe6d73';
                        arrowColor = '#CCC';
                        switchBackCorlor = '#FFE5E5';
                    }

                    if(setListJson[setN].setPageID == ''){
                        arrowColor = '#EEE';
                    };
                    setHtml +="<li><span>"+setListJson[setN].listName+"</span>";

                    setHtml +="<div class='setWrapLiContent'>";

                    setHtml +="<div class='circular' id='"+setListJson[setN].setListID+"' style='background-color: "+switchBackCorlor+";'><div class='round-button' style='background: "+backColor+";left: "+listValue+"px'></div></div>";

                    setHtml +="<span class='to-right' data='"+setListJson[setN].setPageID+"' takePlace='"+setListJson[setN].takePlace+"' style='border: solid "+arrowColor+"; border-width: 0 3px 3px 0;'></span></div></li>";
                }

                setHtml +="</ul>";

                setHtml +="<div style='height:40px;' id='zhmTakePlace'></div>";

                setHtml +="<div class='iconSetFoot' style=''>";

                setHtml +="<ul class='iconSetFootLi'>";

                setHtml +="<li><a href='https://80note.com/2019/05/782.html' target='_blank'>"+lang.question+"</a></li>・<li><a href='https://www.zuihuimai.net/t/qq.html' target='_blank'>交流群</a></li>・<li><a href='https://cdn.80note.com/ds.jpg' target='_blank'>"+lang.reward+"</a></li>・<li><a href='https://cdn.80note.com/erwwma.png' target='_blank'>"+lang.redReward+"</a></li>・<li><a href='https://80note.com/2022/03/323.html' target='_blank'>"+lang.thank+"</a></li>";

                setHtml +='</ul>';

                setHtml +='</div>';

                setHtml += "</div>";

                if(document.querySelector('#setMask')) return;

                this.createElement('div','zhmMenu');

                let zhmMenu = document.getElementById('zhmMenu');

                zhmMenu.innerHTML = setHtml;

                let timerZhmIcon = setInterval(function(){

                    if (document.querySelector('#zhmMenu')){

                        clearInterval(timerZhmIcon); // 取消定时器

                        let circular = document.querySelectorAll('.circular');

                        circular.forEach(function(item){

                            item.addEventListener('click', function(_e){

                                let buttonStyle = item.children[0].style;

                                let left = buttonStyle.left;

                                left = parseInt(left);

                                let listLeftValue;

                                if(left==0){

                                    buttonStyle.left = '22px';

                                    buttonStyle.background = '#fe6d73';

                                    item.style.background='#ffE5E5';

                                    if(item.nextSibling && item.nextSibling.getAttribute('data')){

                                        item.nextSibling.setAttribute('style','border: solid #ccc;border-width: 0 3px 3px 0;')
                                    }

                                    listLeftValue = 22;

                                }else{

                                    buttonStyle.left = '0px';

                                    buttonStyle.background = '#fff';

                                    item.style.background='#fff';

                                    if(item.nextSibling){

                                        item.nextSibling.setAttribute('style','border: solid #EEE;border-width: 0 3px 3px 0;')

                                    }

                                    listLeftValue = 0;
                                }

                                let setListID = item.id;

                                if(setListID == 'removeKeyword' && listLeftValue==22){

                                    document.querySelector('#zhihuKeyword').style.display='block';

                                    //document.querySelector('#zhmTakePlace').style= 'height:220px';
                                }

                                if(setListID == 'removeKeyword' && listLeftValue==0){

                                    document.querySelector('#zhihuKeyword').style.display='none';

                                    //document.querySelector('#zhmTakePlace').style= 'height:180px';
                                }

                                if(setListID == 'removeAuthorName' && listLeftValue==22){

                                    document.querySelector('#zhihuAuthorName').style.display='block';

                                    //document.querySelector('#zhmTakePlace').style= 'height:260px';
                                }

                                if(setListID == 'removeAuthorName' && listLeftValue==0){

                                    document.querySelector('#zhihuAuthorName').style.display='none';

                                    //document.querySelector('#zhmTakePlace').style= 'height:120px';
                                }

                                if(setListID == 'videoPlayLineAdd' && listLeftValue==22){

                                    document.querySelector('#videoPlayLineAddTextarea').style.display='block';
                                }

                                if(setListID == 'videoPlayLineAdd' && listLeftValue==0){

                                    document.querySelector('#videoPlayLineAddTextarea').style.display='none';
                                }

                                GM_setValue(setListID,listLeftValue);

                            })

                        });

                        let toRight = document.querySelectorAll('.to-right');

                        toRight.forEach(function(item){

                            item.addEventListener('click', function(e){

                                let left = item.previousSibling.children[0].style.left;

                                left = parseInt(left);

                                if(left != 22) return;

                                let setPageID = item.getAttribute('data');

                                let pageId = document.getElementById(setPageID);

                                pageId.className='iconSetPage toLeftMove';

                                //知乎设置暂位高度



                                if(setPageID=='zhihuIconSetPage'){

                                    document.querySelector('#zhmTakePlace').style= `height:68px`;

                                }

                            })

                        })

                        let toBack = document.querySelectorAll('.back');

                        toBack.forEach(function(item){

                            item.addEventListener('click', function(e){

                                let parentDom = item.parentNode.parentNode.parentNode;

                                parentDom.className='iconSetPage toRightMove';

                                document.querySelector('#zhmTakePlace').style='height:40px;'

                            })

                        })

                        let setSave = document.querySelectorAll('.iconSetSave');

                        setSave.forEach(function(item){

                            item.addEventListener('click',()=>{

                                let iconTop = document.getElementById('iconTop').value;

                                let iconPosition = document.getElementById('iconPosition').value;

                                let iconWidth = document.getElementById('iconWidth').value;

                                let iconWaitTime = document.getElementById('iconWaitTime').value;

                                let playVideoLineText = document.querySelector('#playVideoLineTextarea').value;

                                let playVideoLineLeft = document.querySelector('#videoPlayLineAdd').children[0].style.left;

                                let inputZhKeyword = document.getElementById('inputZhKeyword').value;

                                let inputAuthorName = document.getElementById('inputZhAuthorName').value;

                                if(iconTop != ''){

                                    if(!(/(^[1-9][0-9]{0,2}$)/.test(iconTop))){

                                        alert(lang.tipErrorIconHeight);

                                        return false;
                                    }

                                    _this.setCookie('iconTop',iconTop,30)
                                }

                                if(iconPosition != ''){

                                    _this.setCookie('iconPosition',iconPosition,30)
                                }

                                if(iconWaitTime != ''){

                                    GM_setValue('iconWaitTime',iconWaitTime);
                                }

                                if(iconWidth !=''){

                                    if(!(/(^([1-9][0-9]?)$)/.test(iconWidth))){

                                        alert(lang.tipErrorIconWidth);

                                        return false;
                                    }

                                    _this.setCookie('iconWidth',iconWidth,30);
                                }

                                if(GM_getValue('videoPlayLineAdd') == 22){

                                    if(playVideoLineText){

                                        let lineObj = _this.getLine(playVideoLineText);

                                        if(lineObj.length>0){

                                            GM_setValue('playVideoLineText',playVideoLineText);

                                        }else{
                                            alert('线路输入不正确');
                                            return;
                                        }

                                    }else{

                                        GM_setValue('playVideoLineText','');
                                    }

                                }else{

                                    GM_setValue('playVideoLineText',playVideoLineText);
                                }

                                if(inputZhKeyword != ''){

                                    GM_setValue('inputZhKeyword',inputZhKeyword);

                                }else{

                                    if(GM_getValue('inputZhKeyword')){

                                        GM_deleteValue('inputZhKeyword');
                                    }

                                }

                                if(inputAuthorName != ''){

                                    GM_setValue('inputZhAuthorName',inputAuthorName);

                                }else{

                                    if(GM_getValue('inputZhAuthorName')){

                                        GM_deleteValue('inputZhAuthorName');
                                    }

                                }

                                history.go(0);
                            })
                        })

                        document.getElementById('iconTop').addEventListener('change',function(){

                            let iconTop = this.value;

                            if(!(/(^[1-9]\d*$)/.test(iconTop))){

                                this.setAttribute('data-is-valid','false')


                            }else{

                                this.setAttribute('data-is-valid','true')
                            }

                            return false;

                        })

                        document.getElementById('iconWidth').addEventListener('change',function(){

                            let iconWidth = this.value;

                            if(!(/(^[1-9]\d*$)/.test(iconWidth))){

                                this.setAttribute('data-is-valid','false')


                            }else{

                                this.setAttribute('data-is-valid','true')
                            }

                            return false;

                        })
                        //腾讯视频快捷键冲突
                        if(couponUrl.match(/v\.qq\.com\/x\/cover/)){

                            let addLineText =document.querySelector('#playVideoLineTextarea');

                            addLineText.addEventListener('keydown',function(e){

                                let startPos = addLineText.selectionStart;

                                let endPos = addLineText.selectionEnd;

                                if (startPos === undefined || endPos === undefined) return;

                                keyCode.forEach(function(item){

                                    if(e.keyCode == item.code && e.shiftKey==item.isShift){

                                        let textValue = addLineText.value;

                                        let startValue = textValue.substring(0,startPos);

                                        let endValue = textValue.substring(startPos);

                                        let allValue = startValue+item.value+endValue;

                                        addLineText.value=allValue;

                                        addLineText.selectionStart = startPos+1;

                                        addLineText.selectionEnd = endPos+1;

                                    }
                                })

                            })
                        }
                    }

                })

                }

            createElement(dom,domId){

                var rootElement = document.body;

                var newElement = document.createElement(dom);

                newElement.id = domId;

                var newElementHtmlContent = document.createTextNode('');

                rootElement.appendChild(newElement);

                newElement.appendChild(newElementHtmlContent);

            }

            request(method,url,data){

                let request = new XMLHttpRequest();

                return new Promise((resolve,reject)=>{

                    request.onreadystatechange=function(){

                        if(request.readyState==4){

                            if(request.status==200){

                                resolve(request.responseText);

                            }else{

                                reject(request.status);
                            }

                        }
                    }

                    request.open(method,url);
                    request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                    request.send(data);

                })

            }

            setCookie(cname,cvalue,exdays){

                var d = new Date();

                d.setTime(d.getTime()+(exdays*24*60*60*1000));

                var expires = "expires="+d.toGMTString();

                document.cookie = cname+"="+cvalue+"; "+expires;
            }

            getCookie(cname){
                var name = cname + "=";
                var ca = document.cookie.split(';');
                for(var i=0; i<ca.length; i++) {
                    var c = ca[i].trim();
                    if (c.indexOf(name)==0) { return c.substring(name.length,c.length); }
                }
                return "";
            }

            getQueryString(e) {
                var t = new RegExp("(^|&)" + e + "=([^&]*)(&|$)");
                var a = window.location.search.substr(1).match(t);
                if (a != null) return a[2];
                return "";
            }

            getUrlParams(url){
                let reg = /([^?&+#]+)=([^?&+#]+)/g;
                let obj={};
                url.replace(reg,(res,$1,$2)=>{obj[$1]=$2});
                return obj;
            }

            getLine(text){

                let textArr = text.split('\n');

                if(textArr.length > 0){

                    let lineObj = [];

                    let match = /^(.+)(https?:\/\/.+)$/;

                    textArr.forEach(function(item){

                        item = item.replace(/\s*,*/g,'');

                        if(!item) return true;

                        let lineMatch = item.match(match);

                        if(lineMatch){

                            lineObj.push({'name':lineMatch[1].substring(0,4),'url':lineMatch[2]});

                        }else{

                            lineObj=[];

                            return false;
                        }

                    })

                    return lineObj;

                }
            }

            static getElement(css){

                return new Promise((resolve,reject)=>{

                    let num = 0;

                    let timer = setInterval(function(){

                        num++

                        let dom = document.querySelector(css);

                        if(dom){

                            clearInterval(timer);

                            resolve(dom);

                        }else{

                            if(num==20){clearInterval(timer);resolve(false);}
                        }

                    },300)

                    })


            }

            static toast(msg,duration){

                duration=isNaN(duration)?3000:duration;

                let toastDom = document.createElement('div');

                toastDom.innerHTML = msg;

                //toastDom.style.cssText="width: 60%;min-width: 150px;opacity: 0.7;height: 30px;color: rgb(255, 255, 255);line-height: 30px;text-align: center;border-radius: 5px;position: fixed;top: 40%;left: 20%;z-index: 999999;background: rgb(0, 0, 0);font-size: 12px;";
                toastDom.style.cssText='padding:2px 15px;min-height: 36px;line-height: 36px;text-align: center;transform: translate(-50%);border-radius: 4px;color: rgb(255, 255, 255);position: fixed;top: 50%;left: 50%;z-index: 9999999;background: rgb(0, 0, 0);font-size: 16px;'

                document.body.appendChild(toastDom);

                setTimeout(function() {

                    var d = 0.5;

                    toastDom.style.webkitTransition = '-webkit-transform ' + d + 's ease-in, opacity ' + d + 's ease-in';

                    toastDom.style.opacity = '0';

                    setTimeout(function() { document.body.removeChild(toastDom) }, d * 1000);

                }, duration);

            }

        }

        class CouponClass extends BaseClass{

            constructor(){

                super();

                this.divElement = document.createElement("div");

                this.divElement.id='zhm_div_s';

            }
            taobao(){

                let node = document.querySelector('#J_juValid');

                node.style='overflow:inherit;'

                let className = 'zhm_tab_taobao';

                this.getCouponInfo(node,className);
            }
            tmall(){

                let node = document.querySelector('.Actions--leftButtons--1M3KkF7')?document.querySelector('.Actions--leftButtons--1M3KkF7'):document.querySelector('#J_LinkBuy').parentNode;

                let className = 'zhm_tab_tmall';

                this.getCouponInfo(node,className);
            }
            tmallCaoshi(){

                let node = document.querySelector('#J_LinkBuy').parentNode;

                let className = 'zhm_tab_tmall';

                this.getCouponInfo(node,className);
            }
            tmallOther(){

                let node = document.querySelector('.tm-msg-box');

                let className = 'zhm_tab_tmall';

                this.getCouponInfo(node,className);
            }
            jd(){
                setTimeout(()=>{

                    let jdGoodsId = couponUrl.match(/jd\.com\/(\S*).html/);

                    let node= document.querySelector('#choose-btns');

                    node.before(this.divElement);

                    this.request('get',`https://zuihuimai.net/vrhr/index_jd_new.php?goods_id=${jdGoodsId[1]}`).then((result)=>{

                        let resp= JSON.parse(result);

                        let html='';

                        resp.forEach(function(item){

                            html +=
                                `
        <div class="zhm_coupon" style="margin-left:10px;">
            <div class="zhm_left">
                <div class="zhm_img_icon">
        <img src="data:image/gif;base64,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" >        </div>
                <div class="zhm_content">
                    <div class="zhm_money" style='margin-top:7px;'>
                        <div class="zhm_amount_money">
                            <div class="zhm_money_sign" style='margin-top:-10px;'>¥</div>
                            <div class="zhm_money_num">${item.discount}</div>
                        </div>
                        <div class="zhm_condition">满${item.quota}元可用</div>
                    </div>
                    <div class="zhm_time" style='margin-top:10px;'>
                        <div class="zhm_term">有效期</div>
                        <div class="zhm_date">${item.endTime}</div>
                    </div>
                </div>
            </div>
            <div class="zhm_circle"></div>
            <div class="zhm_link_coupon">
                <a class="zhm_link_text" href="${item.coupon_link}" target='_blank' rel='noopener noreferrer nofollow' style="margin-left:16px;width:34px;">领取</a>
            </div>
        </div>
        `
                        });

                        document.getElementById('zhm_div_s').innerHTML = html;

                    })



                },couponWaitTime)
            }

            getCouponInfo(node,className){

                setTimeout(()=>{

                    let goods_id = this.getQueryString('id');

                    if(!goods_id){console.log('goods_id');return};

                    if(className == 'zhm_tab_taobao'){

                        node.querySelector('div:nth-of-type(1)').before(this.divElement);

                    }else{
                        node.before(this.divElement);
                    }

                    this.request('get',`https://www.zuihuimai.net/vrhr/index_new.php?goods_id=${goods_id}`).then((result)=>{

                        if(result){

                            let resp= JSON.parse(result);

                            let html =
                                `
        <div class="zhm_coupon">
            <div class="zhm_left">
                <div class="zhm_img_icon">
        <img src="data:image/gif;base64,R0lGODlhZABkAHj/ACH/C05FVFNDQVBFMi4wAwEAAAAh+QQJLAH/ACwAAAAAZABkAKf6BDn6BDn6BDn6BDn6BDn6BDn6BDn6BDn6BDn6BDn6BDr6BTr6BTr6BTr6BTr6BTr6BTr6Bjr6Bjr6Bjv6Bjv6Bjv6Bjv6Bzv6Bzv6CDz6CDz6CT36CT36CT36Cj76Cz76Cz/6Cz/6DD/6DED6DUD6DUD6DkH6DkH6DkH6D0L6EEL6EUP6EUT6EkT7E0X7FEX7FEb7FEb7FUb7FUf7FUf7Fkf7Fkf7F0j7F0j7F0j7F0j7GEj7GEn7GUr7Gkv7G0v7HEz7HU37H0/7IVD7I1H7JFL7JlT7J1T7KFb7KVb7Klf7K1j7Llr7MFz7Ml37NF/8NmD8OGL8OmT8PGX8P2f8QWn8Q2r8RGv8Rm38Rm38R278SG/8SXD8SnD8THL8TnP8T3T8UHX8Unf8VHj8V3v8W378YIL8ZIX8aon8b438cY/7cI76bYv4a4n1aYfuZ4TjZH/UZHzHZnu8aXqtbHqib3qWc3qId3uAeHp5eXl6enp7e3t8fHx9fX1+fn5/f3+AgICBgYGCgoKDg4OEhISFhYWGhoaHh4eIiIiJiYmKioqLi4uMjIyNjY2Ojo6Pj4+QkJCRkZGSkpKTk5OUlJSVlZWWlpaXl5eYmJiZmZmampqbm5ucnJydnZ2enp6fn5+goKChoaGioqKjo6OkpKSlpaWrpqe2qKvAqa7JqrHQq7PXrLXdrLfirbjorLnuqrnyqLj1p7j3pbf5pLb6orb7orX8obX8oLT9oLT9oLT9obX9orb9o7f9pbj9prn9p7n9qLr9qLv9qbv9qbv9qrz9qrz9qrz9q7z9q739q739rb79rr/9sMH8ssL8tMT8tsX8uMf7usn6vcr6wMz5ws74w8/4xdD3x9H3yNL2ytT1y9X0zdbz0Nfy0tnx1Nrx1Nvx1dvx1tzx193w2N3x2d/w29/v3OHv3uLv4OPv4uXu5efu5+nu6uvt7e3u7u7v7+/w8PDx8fHy8vLz8/P09PT19fX29vb4+Pj5+fn7+/v8/Pz9/f3+/v7+/v7+/v4yzTII/gD/CRxIsKDBgwgTKlzIsKHDhxAZqlvSJKLFixgz/itD5MQJI2o0ihxJMgkHBwo8PCHJsuVDYkIcyJRQxJ/LmzgL4oo5k4jNnEBd4hoi04EEn0GTGjQHRUmSLw6HFj36k2GXJUmgVFUKsUkKChh6jGkotefWhGJ8aKCQwgnXiGV6FMVQk2FZo0gX+juiQaaCHrjePqTioqiDFFcYbiMqkwKShlZWKJBZIEdIwQ23EaFQlIIQZwyjqKBAQcUUu0I4Nx5yFnPCKisMg4jCsBsUIkWkNIRSwrCKLa4d+jOCwXCPyyzR/DCM4Ujwh1wKFx1RxeWYFgWKwijz/KGSkw4K/sAw45IMjOwpK3Z3SCbI2hTqW/pbUoKChyHI1zMsU2SIVpy/NDFEEmnohxMuVECRRRZYXCEEFr4Y6JoaUhjhwwwseABCCSWIoIELLgiRxBS8SAiUP1MQMcMIGkhg2IsOUKBBCTwkEYaJBZHT2kNSCJFCcTAGaRgHLRghRkb+xJOcEjPYwERgEHUxxFdCVvkiBi4skV9DaCyRgw1LQKnREiDIBMIPVOxokD9Q2ABkkBJwBlaMLgrJgQ+JNWTNEzx4IJMI8WGknGEUnECEFwupcURvQc7YQg9GnFCCCjAg0QMMJ/QFIwUtPKHmQFUEMcKLOcCj0aBXuqAbQmcQ4eeL/hSM0MMRU2w5kBpUGJHDCKoZdsISnzbBQq9F8fCpQ0yUCeNxB50hhKaGlSBEFMpEBUUQjBomwhHmHFRGDkGeQJtIaiTRwptmjksQGs++qEEOUhyLkD9R8ACtTB8Aa5AXKmRXlAYwOKENS1oMcYJqCrhARkHgHAFeUSIUcYZGZhiRrUziGvTtZDGqYMRYN0kBxAkgsLBSQU2M6msT8jbkj1cvuoBoQU6oAMIJQlQHVDBUPMGFQV3A8GIKULj0RGydAbHlOlU4kWZ3twyBrghu3dTECUMygSNBvBmmgREtC6SGrQkp8apMLcyMoxpBvPgD2QaRQUQOORwBd0FqpDaX/hFb/xPFxSfovNAyRGhQQEpJOJRFC0UpwMKRJpKzWWd5LTSGC/5WdndBfP2rtYlduMCxAyp04dAYLGS+nUNeSCcTD5sL5sTZErB2OnaUycCdy8RNJ/h6/gzRqwfqMnRd5jKQ51AVWMuEwRISftu4C7s3dHzuyjd0Bg+G+ZCOgWGwMDoQ39+OfPYM+TN5eDOwYeAT2ToG0fXhJd/VwyNogZMZTinhv1NJQJ9AnPAwDnzOfNiDCPymkwWDfCEJ//NfEpoQO7ERgQOkySAFOICfgkABWiXQ30PoVwD7PQQMqZOJAQsyBvdokDQgMEI2GJKEEoyuKAWgDspACJUR4q5+/gJcCBl+KAEgePBsL/JADxhig3vJZlUDWcKbStBDBAIRIkP0VxEL8oSHwYoDDAkDuBRAxjIqoAUgG8gTQKg26/2whEFUiBdWoEUjEoQKLTBjGR2QgyoqRAo/AJEgXZCDk3ENWiCAohvPB5FkFWWFBHkZDwYJIh9Q4SFq2AIWNokFLZDNJHub3xvH0xVojQALB1EDgzjZBTG5hAop4BgFiiBKRgpnfQ4QASr1AwbRFcUGFRyIeTIHu4egQS65Q4OB2OarnznkG0h4lQeg95AqxLIoPwhbUpDwJg1Q0yFmOAIMZoAEVzIECdB6nomkcDHLRGQb5RuhDaIlQgOdAZky/lEJV5iARB+Ycz1LuBcP3OcyKBjBCIq0HLg8t7XQeS1x6fMKWFRQtPQZ4V7U61vnipKCSy4EDOfxiw3iWJAoNE8mGlBC3/7xhXkah6QDQcIHDDOCNh4kCzN40QxgqhR/EOMgTlCW84ggDYVA4QQcU0AKwKAQNASBWCCoaEGCoU2MVCMKP7DBEBZGEDVIzTAfCJRB2CAEDJARA0Oo1rxASTlmFMQLQ8gBEOKVEyoIoTcKwIAQzBkGlxYlbQrpghBUoAIhQA4hU1ABqbh6q7IqgALSsoJLvEAEKvmlBMApiBRSQCghHEMh6JDC0xJiBh8M7TQFCZ+/OlaE6mmkCjlA/hdKTpDZSJpNNlLNyBK86IEDEkQMP/xXDw6LkV0ID0YaKMJPDZKGpxrGBhPLiEM7s9dUFg5GGCCCSOJyQ7ZI7DVIQ+k3LeKPIqDLBcQtCBmMMJqYzTAjvNCbmdDEkO8YxgVpjEhkRgdJhVhBCCqLkRCqihAp2EAEI8iBE7rRkDJw718qJa95DfO2hkzjCTkQgQh6YFOMjEEKUgjmQJogVAfAQJkR6UIeIZbQhZwBxK59ThpM+y8bvPDGNw7LvYDQjJU+xAkztZKQYSSCFvuYtAsdspId4M8jPwSdSx4yB8TqZIVUQQU3jPKLzsjYKi+Eu3P5AAjGTOYyl9kDbypA/g+A4eWGlHZ8TliCnOdMZzpDAZ8F4MFy26yQN8+Elg7pBmPC04M98xkhfsaLNu+iZkMf2iCJpkpUBt3oR5PWBxyTNFkoXWhLI5rGeHmIMzjtaE8LpLSGEUIYroCFBS2Ik5y8whXE0DbK6NnUkAa1Azhg5l6X2UM4vDWuCYJqLQspz6U29RkwbewgKcAGbh32QHbS7CB5hsBOhkIL6lRtB2jABvWUtkBQ9IPhzUACGEi3utMtgRzQDggxFvcAocWB3BokoEXxgL3lLZC/GSYH0TXIGPyqVD/yWyD3ZM4QClSQMpTVMECI9sEJwgQvaoAHTnCfP87QhNiCdd8TjwuMSUDgAg94wAVBnorSJn6QKYRXyS6oLctRdlIhq8DIM//Hy1pAgSwzBwbFy7lBrDAl2XpbBUNgqtAV4g8qFKHmLTjCLpdO9aonJCAAIfkECTIA/wAsBgABAFgAYQCnAAAAAQEBAgICAwMDBAQEBQUFBgYGBwcHCAgICQkJCgoKCwsLDAwMDQ0NDg4ODw8PEBAQEREREhISExMTFBQUFRUVFhYWFxcXGBgYGRkZGhoaGxsbHBwcHR0dHh4eHx8fICAgISEhIiIiIyMjJCQkJSUlJiYmJycnKCgoKSkpKioqKysrLCwsLS0tLi4uLy8vMDAwMTExMjIyMzMzNDQ0NTU1NjY2Nzc3ODg4OTk5Ojo6Ozs7PDw8PT09Pj4+Pz8/QEBAQUFBQkJCQ0NDRERERUVFRkZGR0dHSEhISUlJSkpKS0tLTExMTU1NTk5OT09PUFBQUVFRUlJSU1NTVFRUVVVVVlZWV1dXWFhYWVlZWlpaW1tbXFxcXV1dXl5eX19fYGBgYWFhYmJiY2NjZGRkZWVlZmZmZ2dnaGhoaWlpampqa2trbGxsbW1tbm5ub29vcHBwcXFxcnJyc3NzdHR0dXV1dnZ2d3d3eHh4eXl5enp6e3t7fHx8fX19fn5+f39/gICAgYGBgoKCg4ODhISEhYWFhoaGh4eHiIiIiYmJioqKi4uLjIyMjY2Njo6Oj4+PkJCQkZGRkpKSk5OTlJSUlZWVlpaWl5eXmJiYn52TqqSKuK1+zLpr3sVY6cxN7s9H8NBF8NBF8NBE8NBE8NBE8NBE8NBE8NBE8NBE8NBE8NBE8NBE8NBE8NFE8NFE8NFE8NFE8NFE8NFF8NFF8NFF8NFF8NFF8NFF8NFF8NFF8NFF8NFF8NFG8dFG8dFG8dFG8dFH8dFH8dFH8dFI8dFI8dFJ8dJJ8dJJ8dJK8dJK8dJL8dJL8dJM8dJM8dNN8dNO8dNP8dNP8dNQ8dNQ8dNR8tRS8tRS8tRT8tRV8tVW8tVY8tZZ8tZb8tde89dg89hi89hj89hj89hk89lm89lo9Npq9Npr9Nps9Ntt9Ntw9Nxy9Nxz9N119N129N139N159d579d9+9d+A9eCD9eGG9uKK9uON9uOQ9+WX+Oik+Ouu+e24+u/C+vHJ+vHIMs0yCP4A/wkcSLCgwYMIDfYLNy6hw4cQI0qcWI/bMmfd8k3cyLHjRm/HcuU6Vs6jyZMn+W0TKbJbP5QwYz7cx41lLm4vZerc+Y+mTZc8gxLsZ+7bt3gSfbLEKRHeN2/lcgp1OM5ZL2DZ5kVUKpIpRHnZgPVyVnJqQnrZWPYCOrPmUqkJ+3kDxjKbPrMI1UWz6awdxH5uc/XyFpHdM5axrmnEq5BbL7Xb4CI0Z3VsOoj6tj0W2csr44LqDrNMhu5vOW7dSkMsp4wvvM8H+3WjW3exTnxpWQLrBhshPGs2k6njOe9ZLJbW6PVG+C1krljJedKzdnxkw+UH6WkTNvb6zn7flP71OsbNNvaC9LpxiyqU3zhu3/Cdh7lPHTp47tq14+aO33y8+KDTTTbWPHNMMsook4ww0VizzTfp+PdfTP2k0401ytBm04bjLZPNN/LM149kG6GzjVUbpqjiMdF0E6JJI0p0zzfWWDPOXRvBww2KKvaYojDWhGNeRPjQaM03+0AUTjIiHZONOiTGVo41Gqr4WC9X+jhSNuxI1E851ziXjHcI3ZMbSxi95lA+3rSmojDKRJNNN84484w13hC4TJVqRcOeQ+tsw6RN10Q5kJkp9mKNagfZw41zNvWiTDbeoCPfQfmo0801yWzGVziG/jPOM57WFapAS6qYzZAC2bONMP4pKrMNOhJiZs42y6SYjDdRTqeiM+ZAlM830ZSai3AG3cMNrDYBcw06pyLUDzrXMMvSMd+QCI8z1YkEjDV/QqQjj7lENxRIGybTjT0o1dONm2gGix5wnGGkFUfoZLPMMc+URdA48IrkzDjRRtRPVRtao+a/zhyzzDZdmsSPOuQsPNBvGwLLUzmicbbNkP2sMw6UU+njWHBk6oTwteHMZ07AwrAFET6sStucTdEgtRw+2myYzaUPzcPNNdd4U7NB+GimFm/LoROwM8NB5M+yTX4jkTt7sfTMi58B5ulaBf8zD3UiJQb0Q3Pp1jJs8GQtsMUOyWMccspFhDFLisFGDv6kN4X9jzzRdGvuX914mkzEeHl9LaNfBU73ROo4o5vVjNVDr0jW1DMR4ILXHVE919iUjd8myS066Zw/7uXJz1lztlCsqUXY5nNj7nlE40CaDNyfG+W77+wWtPe1KT8kd+cbxS5SMn4VFM/vvpOjET6PYmn9eOUVVA6kyvAet+O2bxRPx8eIU9A8r16P5TG8htejMusUNI613W80D/jl3g4RPR3nso32fLPJMbRhDWtt6BiM+8c3NKQMnUnkfsibCARZog0A9mg88bjchqJxr4GUg37eS8gEwzcRePSvggTRS4+sgZR81eiF1riGvzyou8tIEH+Di4g4BjUS8w1lHP7XsEaDotGgJw0kH/nRTzvc8TqB3Iwzs5NI6kgokfmNxh0HwUcS9QOPJHUkHZLjDNMeWLv8TURxywuhTuLhtnLhKCJjq04sVjURRCGniTzJx0rQpEaFoGsklJPIOsIoktF9Jm3eCuTnvFEjb7wxIojMBTDWxhinEQqPDomR/TS4jD7qxB5nGskMzSIOvtmlN98w4M+8ZA5vpEaCGhSGD9nWRmEoMi5VwZIzEiit2dgkh4esEtQgkkHBBc8h6CCkJG/5mQz6THMO+aNI6ucQd2iwXNAUSj9q9S8eSlJmBylHrtDkwIPcQ2mjGaVA+EG62JiDQNzooEDywbomFY8gSf7bTGe4WRDw8K0z/nAeN6yRDWh5RB3bcBMwtvHIv10zZw6Bx4mcEU+HgDFh+ksaXXrxMMTZbUel6qRBkhkpbvCzn+kgWUJAmTEbEmR83RpLN/SHkHVQKUXO4J0/g6POjjyxSbN8Kf5EIoystMVYuYjZSf/Bs1JZ4x4ouZvHvFgQehpQjA9BC4cwkk2DhMYmwqBkR2RTJRaehU7Gssap9oHOYxnxIT81o0cMI8Cg1lRQavEMQtBhjWQkQ4ZhAx1YmWmwwonuaP0Ek1+z4UmBzAMdltpI7n6JyYj2jzQbuQdkuyoU3ID1GlgChmhHS9rSYqVK2gjohB4yWS25VlcuXf5tQgT72toWsqGyPUgkbeujY9wztwUZJG9dy0HgZjV0ujmGcpfL3OYew1NzXKpxB8LSupDjG+HIrna3m91vlCOU2ZDudP9R3a6cMTC5CO94EVLeviUFvepdr0Haq1eHcCW94p0uff123/jKlyD0Pa/o8mvc9m5DHkt0h4IXzOD8yKNneCMwcNt7IL9a+MIYXhChJJzbeoRyuCny739b9WEQ/1K1IxZIZkxspcikmCDlaCOLv4XFFw+kQtnw1DGuYVrShskm2qCpjclhrWPIizlFPrKNCfIyQkH1IGPjSzmXTOJmcaOJ9dgGalFM5YGUEqzZKAc+RnQPcvBYgD2lsjlW02UN5bY5xIhdMjr699po1LjLBxGHMrW0SzzjslhaUhQv/VwQdoA0RcCg6JQJHRtNKbNFHv1MQAAAIf4VTWFkZSB3aXRoIFNjcmVlblRvR2lmADs=" >        </div>
                <div class="zhm_content">
                    <div class="zhm_money">
                        <div class="zhm_amount_money">
                            <div class="zhm_money_sign">¥</div>
                            <div class="zhm_money_num">${resp.youhuiquan}</div>
                        </div>
                        <div class="zhm_condition">${resp.coupon_info}</div>
                    </div>
                    <div class="zhm_time">
                        <div class="zhm_term">有效期</div>
                        <div class="zhm_date">${resp.coupon_end_time}</div>
                    </div>
                </div>
            </div>
            <div class="zhm_circle"></div>
            <div class="zhm_link_coupon" style="margin-right:">
                <a class="zhm_link_text" onclick="window.open('${resp.coupon_link}')">领取</a>
            </div>
        </div>
        `;
                            document.getElementById('zhm_div_s').innerHTML=html;

                        }

                    })

                },couponWaitTime);
            }

        }

        class PlayVideoClass extends BaseClass{
            constructor(){
                super();
            }

        }

        class PlayMusicClass extends BaseClass{
            constructor(){
                super();
            }

            xmlyCreateCheckbox(){

                let soundListli = document.querySelectorAll('.sound-list ul li');

                soundListli.forEach(function(item){

                    let checkboxed = item.querySelector('input');

                    if(checkboxed){
                        return;
                    }

                    let title = item.querySelector('.text');

                    if(!title){
                        return;
                    };

                    title.style = "width:360px";

                    let src = title.querySelector('a').getAttribute('href');

                    let firstDom = item.querySelector('.icon-wrapper');

                    let inputDom = firstDom.cloneNode(true);

                    inputDom.style= 'min-width: 0px;';

                    inputDom.innerHTML = "<input type='checkbox' name='zhmCheckbox' value="+src+" >";

                    firstDom.before(inputDom);

                })

            }
        }

        class ZhClass extends BaseClass{

            constructor(){
                super();
            }
            showSpecialColumn(){

                if(location.href == 'https://www.zhihu.com/'){

                    let cardRecommend = document.querySelectorAll('.Feed');

                    if(cardRecommend.length >0){

                        cardRecommend.forEach(function(item){

                            if(item.querySelector('.specialColumn')){
                                return;
                            }

                            let dataZop = JSON.parse(item.getAttribute(''));

                            if(!dataZop)return;

                            let type = dataZop.card.content.type;

                            if(type == 'Post'){

                                let title = item.querySelector('div>div>h2>span>a');

                                if(!title)return;

                                let newElement = document.createElement('button');

                                newElement.className = 'specialColumn Button VoteButton VoteButton--up';

                                newElement.style = 'line-height:20px;padding:0px 5px;margin-right:5px;border-radius:2px;';

                                newElement.innerText = '文章';

                                title.before(newElement);

                            }
                        })
                    }

                }

                if(location.href.match(/https?:\/\/www.zhihu.com\/search/)){
                    let n=0;

                    let timer= setInterval(function(){

                        let cardSearch = document.querySelectorAll('.SearchResult-Card');

                        if(n++>600){
                            clearInterval(timer);
                        }

                        if(cardSearch.length >0){

                            clearInterval(timer);

                            cardSearch.forEach(function(item){

                                if(item.querySelector('.specialColumn')){
                                    return;
                                }

                                let dataZop = JSON.parse(item.getAttribute('data-za-extra-module'));

                                if(!dataZop)return;

                                let type = dataZop.card.content.type;

                                 console.log('search',type);

                                if(type == 'Post'){

                                    let title = item.querySelector('div>div>h2>span>div>a');

                                    if(!title)return;

                                    let newElement = document.createElement('button');

                                    newElement.className = 'specialColumn Button VoteButton VoteButton--up';

                                    newElement.style = 'line-height:20px;padding:0px 5px;margin-right:5px;';

                                    newElement.innerText = '文章';

                                    title.before(newElement);

                                }
                            })
                        }


                    })
                    }
            }
            showVideoTitle(){

                if(location.href == 'https://www.zhihu.com/'){

                    let cardRecommend = document.querySelectorAll('.Feed');

                    if(cardRecommend.length >0){

                        cardRecommend.forEach(function(item){

                            if(item.querySelector('.videoTitle')){
                                return;
                            }

                            let dataZop = JSON.parse(item.getAttribute('data-za-extra-module'));

                            if(!dataZop)return;

                            let hasVideo = dataZop.card.has_video;

                            if(hasVideo == true){

                                let title;

                                if(item.querySelector('div>div>h2>div>a')){

                                    title = item.querySelector('div>div>h2>div>a');

                                }else if(item.querySelector('div>div>h2>span>a')){

                                    title = item.querySelector('div>div>h2>span>a');

                                }else{

                                    return;
                                }

                                let newElement = document.createElement('button');

                                newElement.className = 'videoTitle';

                                newElement.style = 'background: rgba(255, 131, 86, 0.12);color: rgb(255, 73, 12);line-height:20px;padding:1px 6px;margin-right:5px;border-radius:2px;font-size:14px;';

                                newElement.innerText = '视频';

                                title.before(newElement);

                            }
                        })
                    }

                }

                if(location.href.match(/https?:\/\/www.zhihu.com\/search/)){

                    let n=0;

                    let timer= setInterval(function(){

                        let cardSearch = document.querySelectorAll('.SearchResult-Card');

                        if(n++>600){
                            clearInterval(timer);
                        }

                        if(cardSearch.length >0){

                            clearInterval(timer);

                            cardSearch.forEach(function(item){

                                if(item.querySelector('.videoTitle')){
                                    return;
                                }

                                let dataZop = JSON.parse(item.getAttribute('data-za-extra-module'));

                                if(!dataZop)return;

                                let type = dataZop.card.content.type;

                                if(type == 'Zvideo' ){

                                    let title = item.querySelector('div>div>h2>span>div>a');

                                    if(!title)return;

                                    let newElement = document.createElement('button');

                                    newElement.className = 'videoTitle';

                                    newElement.style = 'background: rgba(255, 131, 86, 0.12);color: rgb(255, 73, 12);line-height:20px;padding:1px 6px;margin-right:5px;border-radius:2px;font-size:14px;';

                                    newElement.innerText = '视频';

                                    title.before(newElement);

                                }
                            })
                        }


                    })
                    }

            }
            removeVideo(){

                let card = document.querySelectorAll('.Feed');

                card.forEach(function(item){

                    let dataZop = JSON.parse(item.getAttribute('data-za-extra-module'));

                    let video = dataZop.card.content.video_id;

                    if(video){

                        item.parentNode.style='display:none;';

                    }
                })

            }
            removeAD(){

                let zhHideAD = `.Pc-card,.Pc-word{display:none !important;}.TopstoryItem--advertCard{display:none !important}`;

                domStyle .appendChild(document.createTextNode(zhHideAD));

                domHead.appendChild(domStyle);

            }
            downloadVideo(){

                window.addEventListener('click',(e)=>{

                    if(e.target.innerText == '下载'){

                        var videoId;

                        if(document.querySelector('.ZVideo-player')){

                            let zVideo = document.querySelector('.ZVideo');

                            let videoData = JSON.parse(zVideo.getAttribute('data-za-extra-module'));

                            videoId = videoData.card.content.video_id;

                        }else{

                            let videoUrl = window.location.href;

                            let videoObj = videoUrl.split('?');

                            videoId = videoObj[0].split('/').pop();
                        }

                        let url = 'https://lens.zhihu.com/api/v4/videos/'+videoId;

                        this.request('get',url).then((result)=>{

                            let data = JSON.parse(result);

                            if(data.playlist != undefined){

                                let play_url = data.playlist.LD.play_url;

                                let videoName = videoId+".mp4";

                                GM_download(play_url,videoName);

                            }else{

                                BaseClass.toast('下载失败！');

                            }
                        });
                    }
                })

                document.addEventListener('DOMNodeInserted',(e) => {

                    if(!e.relatedNode.querySelector) return;

                    var playBar = e.relatedNode.querySelector(':scope > div:last-child > div:first-child > div:nth-of-type(2)');

                    if(!playBar || playBar.querySelector('.zhmDownload')) return;

                    var playBut = playBar.querySelector(':scope > div:last-child');

                    if(!playBut) return;

                    var playButLi = playBut.querySelector('div:first-child');

                    if(!playButLi) return;

                    var downloadBut = playButLi.cloneNode(true);

                    downloadBut.className = playButLi.className + ' zhmDownload';

                    if(!downloadBut.querySelector('._1tg8oir')) return;

                    downloadBut.querySelector('._1tg8oir').innerText='下载';

                    playButLi.before(downloadBut);

                })

            }
            removeRight(){
                if(location.href.match(/^https?:\/\/www\.zhihu\.com\/people\/.*/)){
                    return false;
                }
                let zhFullScreen = `.GlobalSideBar {display: none !important;}
                    .css-1qyytj7{display: none !important;}
                    .Question-sideColumn{display:none !important}
                    .Topstory-mainColumn{width:100% !important}
                    .Question-mainColumn{width:1000px !important}
                    .css-cazg48{margin: 0px 16px 0px 0px !important;}
                    .QuestionWaiting-mainColumn{width:100% !important;}
                    .css-1j5d3ll{padding-left:10px;}
                    .css-yhjwoe{justify-content: space-between !important;}
                    `;
                domStyle .appendChild(document.createTextNode(zhFullScreen));

                domHead.appendChild(domStyle);
            }
            changeLink(){

                if(couponUrl.indexOf('target') != -1){

                    let obj = this.getUrlParams(couponUrl);

                    if(obj.target == undefined) return;

                    let link = decodeURIComponent(obj.target);

                    location.href=link;
                }
            }
            removeKeyword(){

                var GMKeyword = GM_getValue('inputZhKeyword','0');

                if(GMKeyword == '0' || GMKeyword == '') return;

                let keyword = GMKeyword.split(',');

                let content = document.querySelectorAll('.ContentItem');

                keyword.forEach(function(item){

                    content.forEach(function(value){

                        let dataZop = JSON.parse(value.getAttribute('data-zop'));

                        if(dataZop && dataZop.title.indexOf(item) != -1){

                            let itemCard = value.parentNode.parentNode.parentNode;

                            let itemCardClass= itemCard.className;

                            if(itemCardClass.indexOf('TopstoryItem-isRecommend') != -1){

                                itemCard.style='display:none';
                            }
                        }

                    })
                })
            }
            removeAuthorName(){

                var GMAuthorName = GM_getValue('inputZhAuthorName','0');

                if(GMAuthorName == '0' || GMAuthorName == '') return;

                let authorName = GMAuthorName.split(',');

                //搜索页
                if(location.href.match(/^https?:\/\/www.zhihu.com\/search/)){

                    let n=0;

                    let timer = setInterval(function(){

                        let userLink = document.querySelectorAll('.Card');

                        if(userLink.length > 5){

                            clearInterval(timer);

                            userLink.forEach(function(item){

                            let author = item.querySelector('b');

                            if(author){

                                if(authorName.indexOf(author.innerText) != -1){

                                    item.style = 'display:none';
                                }

                            }

                        })

                        }else if(n>30){

                            clearInterval(timer);

                        }else{

                            n++;
                        }

                    },100)

                }
                //回答页
                if(location.href.match(/^https?:\/\/www.zhihu.com\/question\/.*/)){

                    let itemDom = document.querySelectorAll('.List-item');

                    if(itemDom.length>0){

                        itemDom.forEach(function(item){

                            let content = item.querySelector('.ContentItem');

                            if(content){

                                let dataZop = JSON.parse(content.getAttribute('data-zop'));

                                if(authorName.indexOf(dataZop.authorName) != -1){

                                    item.style = 'display:none';

                                }

                            }

                        })

                    }

                }
                //等你回答页
                if(location.href == 'https://www.zhihu.com/question/waiting'){

                    setTimeout(function(){

                        let questionList = document.querySelectorAll('.jsNavigable');

                        if(questionList.length>0){

                            questionList.forEach(function(item){

                                let authorDomText = item.querySelector('.css-tnsaxh').innerText;

                                if(authorDomText){

                                    let author = authorDomText.replace('"','').replace('的提问','').replace(/(^\s+)|(\s+$)/g,'');

                                    if(author){

                                        if(authorName.indexOf(author) != -1){

                                            item.style='display:none;';

                                        }

                                    }

                                }

                            })

                        }

                    },300)
                }
                //推荐页
                if(location.href == 'https://www.zhihu.com/'){

                    let content = document.querySelectorAll('.ContentItem');

                    content.forEach(function(value){

                        let dataZop = JSON.parse(value.getAttribute('data-zop'));

                        if(authorName.indexOf(dataZop.authorName) != -1){

                            let itemCard = value.parentNode.parentNode.parentNode;

                            if(itemCard){

                                itemCard.style='display:none';
                            }
                        }

                    })

                }

            }
            removeYanxuan(){

                //回答页
                if(location.href.match(/^https?:\/\/www.zhihu.com\/question\/.*/)){

                    let itemDom = document.querySelectorAll('.List-item');

                    if(itemDom.length>0){

                        itemDom.forEach(function(item){

                            let content = item.querySelector('.KfeCollection-OrdinaryLabel-content');

                            if(content && content.innerText.indexOf('盐选') != -1){

                                item.style = 'display:none';

                            }
                        })

                    }

                    let answerCard = document.querySelector('.AnswerCard');

                    if(answerCard){

                        let content = answerCard.querySelector('.KfeCollection-OrdinaryLabel-content');

                        if(content && content.innerText.indexOf('盐选') != -1){

                            answerCard.style = 'display:none';
                        }
                    }

                }

                //搜索页
                if(location.href.match(/^https?:\/\/www.zhihu.com\/search/)){

                   let num = 0;

                   let timer = setInterval(function(){

                        let cardList = document.querySelectorAll('.Card');

                        if(cardList.length > 5){

                            clearInterval(timer);

                            cardList.forEach(function(item){

                                let type = item.querySelector('.KfeCollection-PcCollegeCard-type');

                                if(type && type.innerText.indexOf('盐选专栏') != -1){

                                    item.style = 'display:none';
                                }

                                let author = item.querySelector('b');

                                let authorYanxuan = ['故事档案局', '盐选推荐', '盐选科普', '盐选成长计划', '知乎盐选会员', '知乎盐选创作者', '盐选心理', '盐选健康必修课', '盐选奇妙物语', '盐选生活馆', '盐选职场', '盐选文学甄选', '盐选作者小管家', '盐选博物馆', '盐选点金', '盐选测评室', '盐选科技前沿', '盐选会员精品', '历史环游记'];

                                if(author && authorYanxuan.indexOf(author.innerText) != -1){

                                    item.style = 'display:none';

                                }

                            })

                        }else if(num>30){

                            clearInterval(timer);

                        }else{

                            num++;
                        }

                    },100)

                }

                //推荐页
                if(location.href == 'https://www.zhihu.com/'){

                    let content = document.querySelectorAll('.ContentItem');

                    content.forEach(function(item){

                        let content = item.querySelector('.KfeCollection-OrdinaryLabel-content');

                        if(content && content.innerText.indexOf('盐选') != -1){

                            item.style = 'display:none';

                        }

                    })
                }
            }
        }

        class VideoDownloadClass extends BaseClass{

            constructor(){

                super();
            }

            dyVideoDownload(){

                var _this = this;

                window.addEventListener('load',function(){

                    async function getControls(){

                        let videoDom = await BaseClass.getElement('.xg-video-container');

                        if(!videoDom){

                            console.log('没有找到DOM');return;
                        }

                        let vsNav = document.querySelector('.fuy_wmct:nth-of-type(5)');

                        if((vsNav && vsNav.className.indexOf('LXX79le5') != -1) || couponUrl.indexOf('vsdetail') != -1){
                            console.log('综艺栏目关闭下载');return;
                        }

                        _this.createDyVideoDownload();

                        let videoPlayDomAll = document.querySelectorAll('video');

                        let videoIndex = videoPlayDomAll.length>1?videoPlayDomAll.length-2:videoPlayDomAll.length-1;

                        let videoPlayDom = videoPlayDomAll[videoIndex];

                        //let videoPlayDom = videoPlayDomAll.length>1?videoPlayDomAll[videoPlayDomAll.length-2]:videoPlayDomAll[videoPlayDomAll.length-1];

                        videoPlayDom.addEventListener('ended',function(){ //结束

                            console.log("播放结束");

                            let autoPlay = document.querySelector('.xg-switch-checked');

                            if(autoPlay){

                                getControls();
                                return;
                            }

                        }, false);

                        document.querySelector('#toDownload').addEventListener('click',function(){

                            BaseClass.toast('正在下载请稍侯');

                            let dataUrl = document.querySelector('#zhmDouyinDownload').getAttribute('data-url');

                            let match = /[https]?:?\/\/www\.douyin\.com\/.+\/([0-9]+)/;

                            let video = dataUrl.match(match);

                            let videoId = video[1];

                            let url = 'https://www.iesdouyin.com/web/api/v2/aweme/iteminfo/?item_ids='+video[1];

                            GM_xmlhttpRequest({
                                method: "get",
                                url: url,
                                data: '',
                                headers: {'Accept': 'text/plain, text/html,application/json'},
                                onload: function(result) {

                                    let resp = JSON.parse(result.response);

                                    if(resp.item_list.length > 0){

                                        let uriId = resp.item_list[0].video.play_addr.uri;

                                        let playUrl = `https://aweme.snssdk.com/aweme/v1/play/?video_id=${uriId}&line=0&ratio=540p&media_type=4&vr_type=0&improve_bitrate=0&is_play_url=1&is_support_h265=0&source=PackSourceEnum_PUBLISH`;

                                        let info = document.querySelectorAll('.Nu66P_ba');

                                        let account = info[videoIndex*2].innerText;

                                        let titleArr = info[videoIndex*2+1].innerText.split('#');

                                        let title = titleArr[0]?titleArr[0]:titleArr[1];

                                        //console.log(account,title);

                                        GM_download(playUrl,title+account+".mp4");

                                    }else{
                                        console.log('API没有获取视频ID');
                                    }
                                }
                            });
                            /*
                                let uri = _this.request('get',url).then((result)=>{

                                    let resp = JSON.parse(result);

                                    //let playUrl = resp.item_list[0].video.play_addr.url_list[0];//下载有水印

                                    if(resp.item_list.length > 0){

                                        let uriId = resp.item_list[0].video.play_addr.uri;

                                        let playUrl = `https://aweme.snssdk.com/aweme/v1/play/?video_id=${uriId}&line=0&ratio=540p&media_type=4&vr_type=0&improve_bitrate=0&is_play_url=1&is_support_h265=0&source=PackSourceEnum_PUBLISH`;

                                        let info = document.querySelectorAll('.Nu66P_ba');

                                        let account = info[videoIndex*2].innerText;

                                        let titleArr = info[videoIndex*2+1].innerText.split('#');

                                        let title = titleArr[0]?titleArr[0]:titleArr[1];

                                        //console.log(account,title);

                                        GM_download(playUrl,title+account+".mp4");

                                    }else{
                                        console.log('API没有获取视频ID');
                                    }

                                }).catch((error)=>{ console.log(error);})
                                */
                        })

                        document.querySelector('#toCopy').addEventListener('click',function(){

                            BaseClass.toast('已复制到剪贴板');

                            GM_setClipboard(videoPlayDom.children[0].src);
                        })

                        document.querySelector('.toLink').addEventListener('click',function(){

                            window.open(videoPlayDom.children[0].src);

                        })

                        return;
                    }

                    getControls();

                    window.addEventListener("wheel",getControls);

                    window.addEventListener('keydown',function(e){

                        if(e.code=='ArrowDown' || e.code=='ArrowUp'){

                            getControls();
                        }

                    })

                    async function insertedDom(){

                        let videoDom = await BaseClass.getElement('video');

                        if(!videoDom){

                            console.log('没有找到DOM');return;
                        }

                        videoDom.addEventListener('DOMNodeInserted',(e) => {

                            getControls();

                        })

                    }

                    insertedDom();

                    window.addEventListener('click',getControls);

                })

            }

            createDyVideoDownload(){

                let controlAll = document.querySelectorAll('.xg-right-grid');

                let controls = controlAll.length>1?controlAll[controlAll.length-2]:controlAll[controlAll.length-1];

                let videoDownloadDom = document.querySelector('#zhmDouyinDownload');

                if(videoDownloadDom){

                    videoDownloadDom.parentNode.parentNode.removeChild(videoDownloadDom.parentNode);

                    //videoDownloadDom.parentNode.parentNode.parentNode.removeChild(videoDownloadDom.parentNode.parentNode)
                }

                let playSeting = controls.querySelector('.xgplayer-playback-setting');

                let downloadDom = playSeting.cloneNode(true);

                downloadDom.style='margin-right:20px;';

                //let downloadText = downloadDom.querySelector('div:first-child > span:first-child');

                let downloadText = downloadDom.querySelector('div:first-child');

                downloadText.innerText='下载';

                downloadText.style = 'font-size:12px;font-weight:400;';

                downloadText.setAttribute('id','zhmDouyinDownload');

                let detail = controls.querySelector('xg-icon:nth-of-type(1)').children[0];

                let linkUrl = detail.getAttribute('href')?detail.getAttribute('href'):location.href;

                if(linkUrl.indexOf('www.douyin.com')==-1){

                    linkUrl='//www.douyin.com'+linkUrl;
                }

                downloadText.setAttribute('data-url',linkUrl);

                downloadText.removeAttribute('target');

                downloadText.setAttribute('href','javascript:void(0);');

                downloadDom.onmouseover=function(){

                    downloadDom.className='xgplayer-playback-setting slide-show';

                }

                downloadDom.onmouseout=function(){

                    downloadDom.className='xgplayer-playback-setting';
                }

                let downloadHtml = '';

                downloadOption.forEach(function(item){

                    downloadHtml += `<div class="xgplayer-playratio-item ${item.id}" id="${item.id}">${item.name}</div>`;

                })

                downloadDom.querySelector('.xgplayer-playratio-wrap').innerHTML = downloadHtml;

                downloadDom.querySelector('.xgplayer-slider').style='width:60px important;';

                let autoPlay = document.querySelector('.xgplayer-autoplay-setting');

                autoPlay.after(downloadDom);

                let divDom = document.createElement('div');

                divDom.style="position: absolute;z-index:-999;height:80px;width:40px;margin-top:-80px;"

                downloadDom.appendChild(divDom);

                /*
                    let detailDom = controls.querySelector('xg-icon:nth-of-type(1)');

                    let xgIcon = detailDom.cloneNode(true);

                    if(xgIcon.children[1] && xgIcon.children[1].className=='xg-tips'){

                        xgIcon.children[1].innerHTML='下载视频';
                    }

                    xgIcon.className='xgplayer-detail-entry';

                    xgIcon.children[0].style='margin-right:16px;';

                    xgIcon.children[0].setAttribute('id','zhmDouyinDownload');

                    let linkUrl = xgIcon.children[0].getAttribute('href')?xgIcon.children[0].getAttribute('href'):location.href;

                    xgIcon.children[0].setAttribute('data-url',linkUrl);

                    xgIcon.children[0].removeAttribute('target');

                    xgIcon.children[0].setAttribute('href','javascript:void(0);');

                    xgIcon.children[0].innerHTML="<div class='desc' style='font-size:12px;line-height:20px;'>下载</div>";

                    let autoPlay = document.querySelector('.xgplayer-autoplay-setting');

                    autoPlay.after(xgIcon);
                    */

            }

            ksVideoDownload(){

                var _this = this;

                window.addEventListener('load',function(){

                    async function getControls(){

                        let videoDom = await BaseClass.getElement('.player-video');

                        if(!videoDom){

                            console.log('没有找到DOM');return;

                        }

                        if(videoDom.getAttribute('src').match(/^blob/)){
                            console.log('blob视频无法下载');return;
                        }

                        _this.createKsVideoDownload(videoDom);

                        videoDom.addEventListener('playing',function(){ //播放中
                            console.log("播放中");
                        });

                        videoDom.addEventListener('ended',function(){ //结束

                            console.log("播放结束");

                            let autoPlay = document.querySelector('.auto-warpper').getAttribute('autoplay');

                            if(autoPlay){
                                getControls();
                                return;

                            }

                        }, false);

                        document.querySelector('#toDownload').addEventListener('click',function(){

                            BaseClass.toast('正在下载请稍侯');

                            let playTimeTotal = document.querySelector('.total').innerText;

                            let second = playTimeTotal.match(/(.+):(.+)/);

                            let secondTotal = second[1]*60+parseInt(second[2]);

                            let dataUrl = document.querySelector('#zhmKsDownload').getAttribute('data-url');

                            let account = document.querySelector('.profile-user-name-title').innerText;

                            let title = document.querySelector('.video-info-title').innerText;

                            let videoFileName = (account && title)?account+'-'+title+'.mp4':new Date().getTime()+'.mp4';

                            GM_download(dataUrl,videoFileName);

                            /*

                                if(secondTotal<30){

                                    let videoFileName = new Date().getTime()+'.mp4';

                                    GM_download(dataUrl,videoFileName);

                                }else{

                                    window.open(dataUrl);
                                }
                                */
                        })

                        document.querySelector('#toCopy').addEventListener('click',function(){

                            BaseClass.toast('已复制到剪贴板');

                            GM_setClipboard(videoDom.getAttribute('src'));
                        })

                        document.querySelector('#toLink').addEventListener('click',function(){

                            window.open(videoDom.getAttribute('src'));

                        })

                    }

                    getControls();

                    document.addEventListener('click',function(e){

                        getControls();


                    })

                })


            }

            createKsVideoDownload(videoDom){

                let match = /^https?:\/\/www\.kuaishou\.com\/(.+)\/.+/;

                let resp = location.href.match(match);

                if(!resp || (resp[1] != 'short-video' && resp[1] != 'video')){

                    console.log('当前不是视频播放页');return;
                }

                if(resp[1] == 'short-video'){

                    let playerArea = document.querySelector('.video-container-player');

                    let playerAreaWidth = playerArea.style.width.match(/(.+)px/);

                    let playerBarProgress = document.querySelector('.player-bar-progress');

                    playerBarProgress.style.width = playerAreaWidth[1]-260+'px';

                    let timeTotal = document.querySelector('.total');

                    timeTotal.style.right='120px';
                }

                let controls = document.querySelector('.right');

                let videoDownloadDom = document.querySelector('#zhmKsDownload');

                if(videoDownloadDom){

                    videoDownloadDom.parentNode.removeChild(videoDownloadDom);
                }

                let detailDom = controls.querySelector('div:nth-of-type(1)');

                let xgIcon = detailDom.cloneNode(true);

                let linkUrl = videoDom.getAttribute('src');

                xgIcon.querySelector('.kwai-player-volume-sound').innerHTML="<div style='cursor:pointer;'>下载</div>";

                let slider = xgIcon.querySelector('.pl-slider');

                slider.style = 'width:49px;padding:10px 5px 20px;';

                let downloadList = '';

                downloadOption.forEach(function(item){

                    downloadList += `<div style="margin-top:10px;color:#FFF;cursor:pointer;" id="${item.id}">${item.name}</div>`;

                })

                slider.innerHTML = downloadList;

                xgIcon.setAttribute('data-url',linkUrl);

                xgIcon.setAttribute('id','zhmKsDownload');

                //console.log(xgIcon);

                //xgIcon.innerHTML="<div style='cursor:pointer;'>下载</div>";

                detailDom.before(xgIcon);

                //重构播放操作按钮

                let zhmKsButton = document.querySelector('#zhmKsButton');

                //console.log(zhmKsButton);

                if(zhmKsButton){

                    //zhmKsButton.parentNode.removeChild(zhmKsButton);

                    return false;
                }

                let buttonIcon = detailDom.cloneNode(true);
                //console.log(buttonIcon);
                buttonIcon.setAttribute('id','zhmKsButton');

                let buttonIconImg = buttonIcon.querySelector('.unmuted-icon');

                buttonIconImg.style = 'background: url(https://s2-10623.kwimgs.com/udata/pkg/cloudcdn/img/player-setting.ad1f5ce8.svg) no-repeat';

                detailDom.after(buttonIcon);

                let plSlider = buttonIcon.querySelector('.pl-slider');

                plSlider.style='width:auto;padding:10px 10px 25px 10px;';

                plSlider.innerHTML = "";

                let buttonFour = controls.querySelector('div:nth-of-type(4)');

                buttonFour.style.margin='0px';

                let autoPlay = document.querySelector('.play-setting-container');

                autoPlay.style.margin='0px 40px 0px 0px';

                let buttonFive = controls.querySelector('div:nth-of-type(5)');

                buttonFive.style.margin='15px 0px';

                buttonFive.onmouseover=function(){

                    setTimeout(function(){

                        let toolTip = document.querySelector('.kwai-player-rotate-tooltip');

                        if(toolTip){

                            toolTip.parentNode.removeChild(toolTip);
                        }


                    },30)

                }

                let buttonSix = controls.querySelector('div:nth-of-type(6)');

                buttonSix.style.margin='15px 0px';

                let toolTip = document.querySelector('.kwai-player-fullscreen-tooltip');

                buttonSix.onmouseover=function(){

                    setTimeout(function(){

                        let toolTip = document.querySelector('.kwai-player-fullscreen-tooltip');

                        if(toolTip){

                            toolTip.parentNode.removeChild(toolTip);

                        }

                    },30)

                }

                plSlider.appendChild(buttonFour);

                plSlider.appendChild(buttonFive);

                plSlider.appendChild(buttonSix);

            }

            xiguaVideoDownload(){

                var _this = this;

                window.addEventListener('load',function(){

                    async function getControls(){

                        let videoDom = await BaseClass.getElement('video');

                        if(!videoDom){

                            console.log('没有找到DOM');return;

                        }

                        _this.createXiguaVideoDownload();

                        GM_xmlhttpRequest({

                            method: "get",

                            url: 'http://47.99.158.118/video-crack/v2/parse?content='+encodeURIComponent(location.href),

                            data: '',

                            headers: {'Accept': 'text/plain, text/html,application/json'},

                            onload: function(res){

                                if(res.status==200){

                                     let resp = JSON.parse(res.responseText)

                                     let videoSrc = '';

                                    if(resp.code == 0){

                                        videoSrc = resp.data.url;

                                    }

                                    document.querySelector('#toDownload').addEventListener('click',function(){

                                        if(!videoSrc){

                                            BaseClass.toast('该视频无法下载');

                                            return;
                                        }

                                        let videoTitle = document.querySelector('.videoTitle h1').innerText;

                                        let videoAuthor = document.querySelector('.author__userName').title;

                                        BaseClass.toast('正在下载请稍侯');

                                        GM_download(videoSrc,videoTitle+'@'+videoAuthor+'.mp4');
                                    })

                                    document.querySelector('#toCopy').addEventListener('click',function(){

                                        if(!videoSrc){

                                            BaseClass.toast('该视频不能复制地址');

                                            return;
                                        }

                                        BaseClass.toast('已复制到剪贴板');

                                        GM_setClipboard(videoSrc);
                                    })

                                    document.querySelector('#toLink').addEventListener('click',function(){

                                        if(!videoSrc){

                                            BaseClass.toast('该视频不能直接打开');

                                            return;
                                        }

                                        window.open(videoSrc);

                                    })

                                    document.addEventListener('click',function(e){

                                        e.path.forEach(function(item){

                                            if(item.className == 'xgplayer-control-item control_playnext common-control-item'){

                                                setTimeout(function(){

                                                    location.reload();

                                                    return;

                                                },1000)

                                            };

                                        })

                                        var objLink = {};

                                        e.path.forEach(function(item){

                                            if(item.href){

                                                objLink.href = item.href?item.href:'';

                                                objLink.target = item.target?item.target:'';

                                                return;
                                            }

                                        })

                                        if(objLink.href && objLink.target != '_blank'){

                                            location.href = objLink.href;

                                            return;
                                        }
                                    })
                                }

                            },
                            onerror : function(err){
                                console.log('error')
                                console.log(err)
                            }
                        });

                        document.querySelector('video').addEventListener('ended',function(){ //结束

                            console.log("播放结束");
                            /*
                                let autoPlay = document.querySelector('.xg-switch-checked');

                                if(autoPlay){

                                    getControls();
                                    return;
                                }
        */
                            setTimeout(function(){

                                location.reload();

                            },5500);

                        }, false);

                    }

                    getControls();
                })
            }

            createXiguaVideoDownload(){

                let rightGrid = document.querySelector('.xg-right-grid');

                let playControl = rightGrid.querySelector('div:nth-of-type(2)');

                let control = playControl.cloneNode(true);

                let entry= control.querySelector('.xgplayer-control-item__entry');

                entry.innerHTML = '<div class="xgpcPlayer_textEntry"><span>下载</span></div>';

                let popover = control.querySelector('.xgplayer-control-item__popover');

                let downloadList = '<ul>';

                downloadOption.forEach(function(item){

                    downloadList += `<li tabindex="0" role="menuitemradio" aria-checked="false" id="${item.id}">${item.name}</li>`;

                })

                downloadList += '</ul>';

                popover.innerHTML = downloadList;

                playControl.before(control);

                let divDom = document.createElement('div');

                divDom.style="width: 80px; height: 140px;position:absolute;bottom:40px;left:20px;z-index:-1";

                control.appendChild(divDom);

                control.onmouseover=function(){

                    popover.style.display='block';

                }

                control.onmouseout=function(){

                    popover.style.display='none';

                }


            }

            biliVideoDownload(){

                var _this = this;

                window.addEventListener('load',function(){

                    async function getControls(){

                        if(location.href.indexOf('bangumi') != -1){

                            let rightControl = await BaseClass.getElement('.squirtle-controller-wrap-right');

                            if(!rightControl){

                                console.log('没有找到DOM');return;
                            }

                            _this.createBiliVideoDownload();

                        }else{

                            let n=0;

                            let timer = setInterval(function(){

                                let dom = document.querySelector('.bilibili-player-video-btn-quality');

                                let domOther = document.querySelector('.bpx-player-ctrl-quality');

                                if(dom){

                                    clearInterval(timer);

                                    _this.createBiliVideoDownload();

                                    return;

                                }else if(domOther){

                                    clearInterval(timer);

                                    _this.createBiliVideoDownloadOther();

                                    return;

                                }else{
                                    if(n++>30)clearInterval(timer);
                                }

                            },100)

                            return;

                        }

                        //_this.createBiliVideoDownload();

                        let timerZhmIcon = setInterval(function(){

                            let videoDom = [{name:'video',type:'dom'},{name:'bwp_video',type:'dom'},{name:'.bilibili-player-video',type:'class'}];

                            for(let i = 0;i<videoDom.length;i++){

                                let video = videoDom[i].type == 'dom'?document.querySelector(videoDom[i].name):document.querySelector(videoDom[i].name).firstChild;

                                if(video){

                                    clearInterval(timerZhmIcon); //取消定时器

                                    video.addEventListener('play',function(){

                                        console.log("播放开始");

                                        _this.createBiliVideoDownload();
                                    });

                                    video.addEventListener('ended',function(){ //结束

                                        if(location.href.indexOf('bangumi') != -1){

                                            let biliDownload = document.querySelector('#biliDownload');

                                            console.log(biliDownload);

                                            biliDownload.parentNode.removeChild(biliDownload);

                                        }
                                    })

                                    break;

                                }

                            };

                        })

                        }

                    getControls();

                })

            }

            createBiliVideoDownload(){

                var _this = this;

                async function getControls(){

                    let downloadIcon = document.querySelector('#biliDownload');

                    if(downloadIcon){
                        console.log('下载按钮已存在');return;
                    }

                    if(location.href.indexOf('bangumi') != -1){

                        let quality = await BaseClass.getElement('.squirtle-quality-wrap');

                        if(!quality){

                            console.log('没有找到DOM');return;
                        }

                        let control = quality.cloneNode(true);

                        console.log(control.querySelector('.squirtle-video-quality-text'));

                        control.querySelector('.squirtle-video-quality-text').innerText='下载';

                        control.setAttribute('id','biliDownload');

                        quality.before(control);

                    }else if(location.href.indexOf('video') != -1){

                        let autoIconDom = await BaseClass.getElement('.bilibili-player-video-btn-quality');

                        if(!autoIconDom){

                            console.log('没有找到DOM');return;

                        }

                        let control = autoIconDom.cloneNode(true);

                        control.style='margin-right:20px;';

                        control.querySelector('.bui-select-result').innerText='下载';

                        control.querySelector('.bui-select-result').setAttribute('id','biliDownload');

                        autoIconDom.before(control);

                    }else{

                        console.log('当前页面不是视频或番剧');return;

                    }

                    document.querySelector('#biliDownload').addEventListener('click',function(){

                        let bvid = '',avid='';

                        if(location.href.indexOf('bangumi') != -1){

                            bvid = document.querySelector('.av-link').innerText;

                        }else if(location.href.indexOf('video') != -1){

                            let params = location.href.match(/https:\/\/www.bilibili.com\/video\/(.+)\?/);

                            if(params[1].indexOf('av') !=-1){

                                avid = params[1].replace('av','');

                            }else{

                                bvid = params[1].substring(params[1].length-1)=='/'?params[1].substring(0,params[1].length-1):params[1];
                            }

                        }else{

                            BaseClass.toast('当前页面无法下载');return;
                        }

                        if(!bvid && !avid){

                            console.log('未获取bvid或avid');return;
                        }

                        let url = "https://api.bilibili.com/x/web-interface/view?bvid="+bvid+"&aid="+avid;

                        let uri = _this.request('get',url).then((result)=>{

                            let resp = JSON.parse(result);

                            if(resp.code < 0){

                                BaseClass.toast('该视频无法下载');

                                console.log('视频信息接口返回数据错误');return;
                            }

                            //选集cid

                            let pageId = _this.getQueryString('p');

                            let cid = '';

                            if(pageId){

                                cid = resp.data.pages[pageId-1].cid;

                            }else{

                                cid = resp.data.cid;
                            }

                            console.log(cid);

                            let link = 'https://api.bilibili.com/x/player/playurl?avid='+resp.data.aid+'&cid='+cid+'&qn=112';

                            let res = _this.request('get',link).then((result)=>{

                                let data = JSON.parse(result);

                                if(data.code < 0){
                                    BaseClass.toast('该视频无法下载');
                                    console.log('视频地址接口返回数据错误');return;
                                }

                                let downloadUrl = data.data.durl[0].url;

                                //GM_download(downloadUrl);

                                window.open(downloadUrl);

                            })

                            })
                        })

                }

                getControls();

            }

            createBiliVideoDownloadOther(){

                var _this = this;

                async function getControls(){

                    let downloadIcon = document.querySelector('#biliDownload');

                    if(downloadIcon){
                        console.log('下载按钮已存在');return;
                    }

                    if(location.href.indexOf('bangumi') != -1){

                        let quality = await BaseClass.getElement('.squirtle-quality-wrap');

                        if(!quality){

                            console.log('没有找到DOM');return;
                        }

                        let control = quality.cloneNode(true);

                        console.log(control.querySelector('.squirtle-video-quality-text'));

                        control.querySelector('.squirtle-video-quality-text').innerText='下载';

                        control.setAttribute('id','biliDownload');

                        quality.before(control);

                    }else if(location.href.indexOf('video') != -1){

                        let autoIconDom = await BaseClass.getElement('.bpx-player-ctrl-quality');

                        if(!autoIconDom){

                            console.log('没有找到DOM');return;

                        }

                        let control = autoIconDom.cloneNode(true);

                        control.style='margin-right:20px;';

                        control.querySelector('.bpx-player-ctrl-quality-result').innerText='下载';

                        control.querySelector('.bpx-player-ctrl-quality-result').setAttribute('id','biliDownload');

                        autoIconDom.before(control);

                    }else{

                        console.log('当前页面不是视频或番剧');return;

                    }

                    document.querySelector('#biliDownload').addEventListener('click',function(){

                        let bvid = '',avid='';

                        if(location.href.indexOf('bangumi') != -1){

                            bvid = document.querySelector('.av-link').innerText;

                        }else if(location.href.indexOf('video') != -1){

                            let nowUrl = location.href.split('?');

                            console.log(nowUrl);

                            let params = nowUrl[0].match(/https:\/\/www.bilibili.com\/video\/(.+)/);

                            if(params[1].indexOf('av') !=-1){

                                avid = params[1].replace('av','');

                            }else{

                                bvid = params[1].substring(params[1].length-1)=='/'?params[1].substring(0,params[1].length-1):params[1];
                            }

                        }else{

                            BaseClass.toast('当前页面无法下载');return;
                        }

                        if(!bvid && !avid){

                            console.log('未获取bvid或avid');return;
                        }

                        let url = "https://api.bilibili.com/x/web-interface/view?bvid="+bvid+"&aid="+avid;

                        let uri = _this.request('get',url).then((result)=>{

                            let resp = JSON.parse(result);

                            if(resp.code < 0){

                                BaseClass.toast('该视频无法下载');

                                console.log('视频信息接口返回数据错误');return;
                            }

                            //选集cid

                            let pageId = _this.getQueryString('p');

                            let cid = '';

                            if(pageId){

                                cid = resp.data.pages[pageId-1].cid;

                            }else{

                                cid = resp.data.cid;
                            }

                            console.log(cid);

                            let link = 'https://api.bilibili.com/x/player/playurl?avid='+resp.data.aid+'&cid='+cid+'&qn=112';

                            let res = _this.request('get',link).then((result)=>{

                                let data = JSON.parse(result);

                                if(data.code < 0){
                                    BaseClass.toast('该视频无法下载');
                                    console.log('视频地址接口返回数据错误');return;
                                }

                                let downloadUrl = data.data.durl[0].url;

                                //GM_download(downloadUrl);

                                window.open(downloadUrl);

                            })

                            })
                        })

                }

                getControls();

            }

            youtubeVideoDownload(){

                let timer = setInterval(function(){

                    let url = location.href.match(/^https?:\/\/www\.youtube\.com\/(watch\?v=.+|shorts\/.+)/);

                    if(url){

                        let youtubeIcon = document.querySelector('#youtubeIcon');

                        if(youtubeIcon)return;

                        let css =
                        `:root{
                            --widthLeft--:40px;
                            --top--:200px;
                        }
                        .zhm_play_vidoe_icon{
                            padding-top:2px;cursor:pointer;
                            z-index:9999999;
                            display : flex;
                            flex-direction: row;
                            position:fixed;
                            left:0px;
                            top:var(--top--);
                            text-align:center;
                            overflow:visible;
                        }
                        .zhm_play_video_wrap{
                            overflow: hidden;
                            width:300px;
                            display:none;
                        }
                        .zhm_play_video_line{
                            width:320px;
                            overflow-y:scroll;
                            overflow-x:hidden;
                        }
                        .zhm_play_vide_line_ul{
                            width:300px;
                            display: flex;
                            justify-content: flex-start;
                            flex-flow: row wrap;
                            list-style: none;
                            padding:0px;
                            margin:0px;
                        }
                        .zhm_play_video_line_ul_li{
                            padding:4px 0px;
                            margin:2px;
                            width:30%;
                            color:#FFF;
                            text-align:center;
                            background-color:#f24443;
                            box-shadow:0px 0px 10px #fff;
                            font-size:14px;
                        }
                        .zhm_play_video_line_ul_li:hover{
                            color:#260033;
                            background-color:#fcc0c0
                        }
                        .zhm_line_selected{
                            color:#260033;
                            background-color:#fcc0c0
                        }
                        .iconLogo{
                            width:var(--widthLeft--);
                        }
                        .zhm_play_video_jx{
                            width:100%;
                            height:100%;
                            z-index:999999;
                            position: absolute;top:0px;padding:0px;
                        }`;

                        var domStyle = document.createElement('style');

                        domStyle .appendChild(document.createTextNode(css));

                        document.querySelector('head').appendChild(domStyle);

                        let playWrapHtml =
                            `<div class='playButton zhm_play_vidoe_icon' id='zhmlogo'"><img class='iconLogo' src='data:image/gif;base64,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'>`;

                        playWrapHtml += "<div class='playLineDiv zhm_play_video_wrap'>"

                        playWrapHtml += "<div class='zhm_play_video_line'>";

                        playWrapHtml +="<ul class='zhm_play_vide_line_ul'>";

                        let playLine = [
                            {name:'下载线路1',url:'https://zh.savefrom.net/176/#url='},
                            {name:'下载线路2',url:'https://mydowndown.com/y2#'},
                            {name:'下载线路3',url:'https://www.ytdownfk.com/search?url='},
                            {name:'下载线路4',url:'https://yout.com/video/?url='}
                        ];

                        playLine.forEach(function(item){

                            playWrapHtml +=`<li class='playLineTd zhm_play_video_line_ul_li' url='${item.url}' >${item.name}</li>`;

                        })

                        playWrapHtml +="</ul></div></div></div>";

                        let divDom = document.createElement('div');

                        divDom.id="youtubeIcon";

                        divDom.innerHTML=playWrapHtml;

                        document.querySelector('body').appendChild(divDom);

                        let playLineTd = document.querySelectorAll('.playLineTd');

                        playLineTd.forEach(function(item){

                            item.addEventListener('click',function(){

                                window.open(item.getAttribute('url')+location.href);

                            })

                        })

                        document.querySelector('.zhm_play_vidoe_icon').onmouseover=()=>{

                            document.querySelector(".playLineDiv").style.display='block';

                        }

                        document.querySelector('.zhm_play_vidoe_icon').onmouseout=()=>{

                            document.querySelector(".playLineDiv").style.display='none';

                        }

                    }else{

                        let youtubeIcon = document.querySelector('#youtubeIcon');

                        if(youtubeIcon){

                            youtubeIcon.parentNode.removeChild(youtubeIcon);
                        }

                    }

                },500)

            }

        }

        var allWeb = [...getCoupon,...jxVideo,...jxMusic,...zhNice,...videoDownload];

        var nowWeb=[];

        allWeb.forEach(function(item){

            if(item.isOpen == 0) return true;

            item.web.forEach(function(val){

                let result = location.href.match(val.match);

                if(result){

                    nowWeb.push(val);

                }
            })

        })

        if(nowWeb.length==0){

            let baseClass = new BaseClass();

            console.log('没有匹配该网站或该模块已关闭');return;
        }

        nowWeb.forEach(function(item){

            switch(item.funcName){
                case 'coupon':

                    couponFunc(item);
                    break;
                case 'playVideo':
                    playVideoFunc();
                    break;
                case 'playMusic':
                    playMusicFunc(item);
                    break;
                case 'zhNice':
                    zhNiceFunc();
                    break;
                case 'videoDownload':

                    var videoDownloadClass = new VideoDownloadClass();

                    var {funcName,match:nowMatch,node:nowNode,name:nowName} = item;

                    if(item.isWebOpen == 0){

                        console.log(item.name+'已关闭');return;

                    }else{

                        videoDownloadClass[nowName]();
                    }

                    break;

            }

        })

        function couponFunc(item){

            var couponClass = new CouponClass();

            var {funcName,match:nowMatch,node:nowNode,name:nowName} = item;

            var couponStyle =`
                    html{
                    --right:100%;
                    --left:100%;
                }
                .zhm_coupon{
                    width:fit-content;
                    display: flex;
                    flex-direction:row;
                    justify-content: space-between;
                    align-items:flex-start;
                    font-size:14px;
                    position: relative;
                    margin-bottom:15px;
                }
                .zhm_left{
                    display: flex;
                    flex-direction:row;
                    justify-content:flex-start;
                    align-items: center;
                    font-size:14px;
                    background: radial-gradient(circle at right top, transparent 8px,#fff 0) top left /var(--right) 51% no-repeat,
                                radial-gradient(circle at right bottom, transparent 8px, #fff 0) bottom left /var(--right) 51% no-repeat;
                    filter: drop-shadow(2px 2px 3px #888);
                    height:84px;
                    width:100%;
                }
                .zhm_img_icon{
                    padding:4px 0px 0px 5px;
                    margin-right:5px;
                }
                .zhm_img_icon img{
                    width:47px;
                }
                .zhm_content{
                    display: flex;
                    flex-direction:column;
                    margin-right: 18px;
                }
                .zhm_money{
                    display: flex;
                    flex-direction:row;
                    justify-content: flex-start;
                    align-items: center;
                }
                .zhm_amount_money{
                    display: flex;
                    align-items: flex-start;
                }
                .zhm_money_sign{
                    color:#f23030;
                    font-size: 20px;
                    font-family: Arial;
                }
                .zhm_money_num{
                    color:#f23030;
                    font-size:36px;
                    margin-left: 2px;
                }
                .zhm_condition{
                    color:#fb0f3a;
                    background-color: #fff4ec;
                    margin-top:5px;
                    margin-left: 5px;
                    padding:2px 5px;
                    font-size:12px;
                }
                .zhm_time{
                    display: flex;
                    flex-direction:row;
                    margin-top: -5px;
                    padding:2px 4px;
                }
                .zhm_term{
                    color:#fb0f3a;
                    border: 1px solid #fb0f3a;
                    border-radius:2px;
                    align-items: center;
                    padding:0px 4px;
                    font-size:12px;
                    height: 18px;
                }
                .zhm_date{
                    font-size: 14px;
                    font-weight: 500;
                    padding-left:8px;

                }
                .zhm_circle{
                    background: #fb0f3a url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAgAAAAICAYAAADED76LAAAACXBIWXMAAAsSAAALEgHS3X78AAAAzUlEQVQYlS3NMUoDQRiG4Xcmu9lAXBQbq+1CCqucwsbOO3gAS29h4Qm8gRdIMKVglQVBFiSFjYKBqWZ2d/7PIvYPPE6SMCHvcD8HuLzBUsIKDyY8AN4RU+J9/8nH8oLYJ3wWchxBjJHtZkN1fsbp9omvhzv6ccDjQJLatlXXdZIk5awkKVzdKk9W8gBFUVDXNQA2jJTA7GSOmR2LpmkIIWA546spvO5wL29Qz3GSBBCHnnwIzO4f0fMaYoKy/Acm8A6+fxkX15ANqimY8QemCm920r1aUAAAAABJRU5ErkJggg==) repeat-y;
                    margin-top:10px;
                    width: 10px;
                    height:66px;
                    position: absolute;
                    right:44px;
                    z-index:2;
                    filter:none;
                }
                .zhm_link_coupon{
                    display: flex;
                    flex-direction:row;
                    align-items:center;
                    filter: drop-shadow(2px 2px 3px #888);
                    background: radial-gradient(circle at left top, transparent 8px, #fb053a 0) top right /var(--left) 50% no-repeat,
                                radial-gradient(circle at left bottom, transparent 8px, #fb053a 0) bottom right /var(--left) 50% no-repeat;
                    height: 84px;

                }
                .zhm_link_text{
                    cursor:pointer;
                    margin-top: 10px;
                    margin-left: 12px;
                    writing-mode:vertical-lr;
                    letter-spacing:10px;
                    color: #fff !important;
                    font-size:16px;
                    font-family:"Microsoft YaHei";
                    text-decoration:none;
                    width:38px;
                    background: radial-gradient(circle at left top, transparent 8px, #fb053a 0) top right /var(--left) 50% no-repeat,
                                radial-gradient(circle at left bottom, transparent 8px, #fb053a 0) bottom right /var(--left) 50% no-repeat;

                }
                .zhm_link_text:hover{
                text-decoration:none;
                font-weight:800;
                font-family:"Microsoft YaHei";
                }
                `;

            domStyle .appendChild(document.createTextNode(couponStyle));

            domHead.appendChild(domStyle);

            let n=0;

            let couponTimer = setInterval(function(){

                n++;

                let pageNode = document.querySelector(nowNode)

                if(pageNode){

                    clearInterval(couponTimer);

                    couponClass[nowName]();

                }else{

                    if(n==couponTimerNum) clearInterval(couponTimer);
                }

            },100)
            }

        function playVideoFunc(){

            var playVideoClass = new PlayVideoClass();

            //css
            let playVideoStyle = `
                    .zhm_play_vidoe_icon{
                        padding-top:2px;cursor:pointer;
                        z-index:9999999;
                        display:block;
                        position:fixed;${iconVipPosition}:0px;top:${iconVipTop}px;text-align:center;overflow:visible
                    }
                    .zhm_play_video_wrap{
                        position:fixed;${iconVipPosition}:${iconVipWidth}px;top:${iconVipTop}px;
                        z-index:9999999;
                        overflow: hidden;
                        width:300px;
                    }
                    .zhm_play_video_line{
                        width:320px;
                        height:316px;
                        overflow-y:scroll;
                        overflow-x:hidden;
                    }
                    .zhm_play_vide_line_ul{
                        width:300px;
                        display: flex;
                        justify-content: flex-start;
                        flex-flow: row wrap;
                        list-style: none;
                        padding:0px;
                        margin:0px;

                    }
                    .zhm_play_video_line_ul_li{
                        padding:4px 0px;
                        margin:2px;
                        width:30%;
                        color:#FFF;
                        text-align:center;
                        background-color:#f24443;
                        box-shadow:0px 0px 10px #fff;
                        font-size:14px;
                    }
                    .zhm_play_video_line_ul_li:hover{
                        color:#260033;
                        background-color:#fcc0c0
                    }
                    .zhm_line_selected{
                        color:#260033;
                        background-color:#fcc0c0
                    }

                    .zhm_play_video_jx{
                        width:100%;
                        height:100%;
                        z-index:999999;
                        position: absolute;top:0px;padding:0px;
                    }
                `;

            domStyle .appendChild(document.createTextNode(playVideoStyle));

            domHead.appendChild(domStyle);

            //custom add line

            if(GM_getValue('videoPlayLineAdd')==22 && GM_getValue('playVideoLineText')){

                let lineObj = playVideoClass.getLine(GM_getValue('playVideoLineText'));

                if(lineObj){

                    playLine = [...lineObj,...playLine];
                }

            }

            //template:icon,playLine;
            let playWrapHtml = "<div href='javascript:void(0)' target='_blank' style='' class='playButton zhm_play_vidoe_icon' id='zhmlogo'><img class='iconLogo' src='data:image/gif;base64,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' title='点击主图标弹出解析，点击右侧列表站内解析' style='width:"+iconVipWidth+"px'>";

            playWrapHtml += "<div class='playLineDiv zhm_play_video_wrap' style='display:none;'>"

            playWrapHtml += "<div class='zhm_play_video_line'>";

            playWrapHtml +="<div><ul class='zhm_play_vide_line_ul'>";

            playLine.forEach(function(item){

                let selected = '';

                if(playVideoClass.getCookie('playLineAction') == item.url){

                    selected='zhm_line_selected';

                }

                playWrapHtml +=`<li class='playLineTd zhm_play_video_line_ul_li ${selected}' url='${item.url}' >${item.name}</li>`;

            })

            playWrapHtml +="</div></div></div>";

            //template:node;播放区域

            let playJxHtml = "<div class='zhm_play_video_jx'>";

            playJxHtml += "<iframe allowtransparency=true frameborder='0' scrolling='no' allowfullscreen=true allowtransparency=true name='jx_play' style='height:100%;width:100%' id='playIframe'></iframe></div>";

            //循环判断是否在播放页，是则执行下面
            let jxVideoData = [
                {funcName:"playVideo", node:".player__container" ,match:/https:\/\/v.qq.com\/x\/cover\/[a-zA-Z0-9]+.html/,areaClassName:'mod_episode',name:'qqPC'},
                {funcName:"playVideo", node:"#player-container" ,match:/https:\/\/v.qq.com\/x\/cover\/[a-zA-Z0-9]+\/[a-zA-Z0-9]+.html/,areaClassName:'mod_episode',name:'qqPC'},
                {funcName:"playVideo", node:".container-player" ,match:/v\.qq\.com\/x\/page/,areaClassName:'mod_episode'},
                {funcName:"playVideo", node:"#player",match:/m\.v\.qq\.com\/x\/m\/play\?cid/},
                {funcName:"playVideo", node:"#player",match:/m\.v\.qq\.com\/x\/play\.html\?cid=/},
                {funcName:"playVideo", node:"#player",match:/m\.v\.qq\.com\/play\.html\?cid\=/},
                {funcName:"playVideo", node:"#player",match:/m\.v\.qq\.com\/cover\/.*html/},

                {funcName:"playVideo", node:"#flashbox",match:/^https:\/\/www\.iqiyi\.com\/[vwa]\_/,areaClassName:'qy-episode-num',name:'iqiyiPc'},
                {funcName:"playVideo", node:".m-video-player-wrap",match:/^https:\/\/m.iqiyi\.com\/[vwa]\_/,areaClassName:'m-sliding-list'},
                {funcName:"playVideo", node:".intl-video-wrap",match:/^https:\/\/www\.iq\.com\/play\//,areaClassName:'m-sliding-list'},

                {funcName:"playVideo", node:"#player",match:/m\.youku\.com\/alipay_video\/id_/},
                {funcName:"playVideo", node:"#player",match:/m\.youku\.com\/video\/id_/},
                {funcName:"playVideo", node:"#player",match:/v\.youku\.com\/v_show\/id_/},

                //{funcName:"playVideo", node:".player-container",nodeType:'id',match:/www\.bilibili\.com\/video/},
                {funcName:"playVideo", node:"#bilibili-player",nodeType:'id',match:/www\.bilibili\.com\/video/,name:'biliPc',areaClassName:'video-episode-card'},
                {funcName:"playVideo", node:"#player_module",nodeType:'id',match:/www\.bilibili\.com\/bangumi/,areaClassName:'ep-list-wrapper report-wrap-module'},
                {funcName:"playVideo", node:".player-container",nodeType:'class',match:/m\.bilibili\.com\/bangumi/,areaClassName:'ep-list-pre-container no-wrap'},
                {funcName:"playVideo", node:".mplayer",nodeType:'class',match:/m\.bilibili\.com\/video\//},

                {funcName:"playVideo", node:".video-area",nodeType:'class',match:/m\.mgtv\.com\/b/},
                {funcName:"playVideo", node:"#mgtv-player-wrap",nodeType:'id',match:/mgtv\.com\/b/,areaClassName:'episode-items clearfix'},
                {funcName:"playVideo", node:".x-player",nodeType:'class',match:/tv\.sohu\.com\/v/},
                {funcName:"playVideo", node:".x-cover-playbtn-wrap",nodeType:'class',match:/m\.tv\.sohu\.com/},
                {funcName:"playVideo", node:"#playerWrap",nodeType:'id',match:/film\.sohu\.com\/album\//},

                {funcName:"playVideo", node:"#le_playbox",nodeType:'id',match:/le\.com\/ptv\/vplay\//,areaClassName:'juji_grid'},

                {funcName:"playVideo", node:"#player",nodeType:'id',match:/play\.tudou\.com\/v_show\/id_/},

                {funcName:"playVideo", node:"#pptv_playpage_box",nodeType:'id',match:/v\.pptv\.com\/show\//},

                {funcName:"playVideo", node:"#player",nodeType:'id',match:/vip\.1905.com\/play\//},

                {funcName:"playVideo", node:"#vodPlayer",nodeType:'id',match:/www\.1905.com\/vod\/play\//},
            ];

            //创建logo_icon
            playVideoClass.createElement('div','zhmIcon');

            let zhmPlay = document.getElementById('zhmIcon');

            zhmPlay.innerHTML = playWrapHtml;

            let jxVideoWeb = jxVideoData.filter(function(item){

                return location.href.match(item.match);

            })

            //是否在播放页
            if(jxVideoWeb.length == 0){

                document.querySelector('#zhmIcon').addEventListener('click',function(){

                    BaseClass.toast('请在视频播放页点击图标');

                })

            }else{

                var {funcName,match:nowMatch,node:nowNode,name:nowName} = jxVideoWeb[0];

                //鼠标经过显示线路
                document.querySelector('.playButton').onmouseover=()=>{

                    document.querySelector(".playLineDiv").style.display='block';

                }

                document.querySelector('.playButton').onmouseout=()=>{

                    document.querySelector(".playLineDiv").style.display='none';

                }

                //选择线路解析播放

                var playLineTd = document.querySelectorAll('.playLineTd');

                playLineTd.forEach(function(item){

                    item.addEventListener('click',function(){

                        playLineTd.forEach(function(e){

                            e.setAttribute('class','playLineTd zhm_play_video_line_ul_li');
                        })

                        this.setAttribute('class','playLineTd zhm_play_video_line_ul_li zhm_line_selected');

                        playVideoClass.setCookie('playLineAction',this.getAttribute('url'),30);

                        let nowWebNode = document.querySelector(nowNode);

                        if(nowWebNode){

                            nowWebNode.innerHTML = playJxHtml;

                            let playIframe = document.querySelector('#playIframe');

                            playIframe.src= item.getAttribute('url')+location.href;

                        }else{

                            console.log('视频网站结点不存在');
                        }

                    })

                })

                /*--特殊处理--*/
                //优酷去广告
                if(nowNode=="#player"){

                    setTimeout(function(){

                        let youkuAd = document.querySelector('.advertise-layer');

                        let ykAd = youkuAd.lastChild;

                        ykAd.parentNode.removeChild(ykAd);

                        document.querySelector('.kui-dashboard-0').style='display:flex';

                        let playVideo = document.querySelector('.video-layer video');

                        playVideo.play();

                        let n=0;

                        //暂停
                        document.querySelector('.kui-play-icon-0').addEventListener('click',function(){

                            let video = document.querySelector('.video-layer video');

                            if(n++%2 == 0){

                                video.pause();

                            }else{

                                video.play();
                            }

                        });

                        playVideo.addEventListener('timeupdate',function(){ //播放时间改变

                            let youkuAd = document.querySelector('.advertise-layer');

                            let ykAd = youkuAd.lastChild;


                            if(ykAd){

                                ykAd.parentNode.removeChild(ykAd);
                            }

                            document.querySelector('.kui-dashboard-0').style='display:flex';
                        });

                    },3000)
                }
                //爱奇艺去广告
                if(nowNode=="#flashbox"){

                    setTimeout(function(){

                        let dom = document.querySelector('.skippable-after');

                        if(dom){

                            dom.click();

                        }

                    },3000)

                }

                //腾讯去vip弹窗
                if(nowNode=="#player-container"){

                    let n = 0;

                    let timer = setInterval(function(){

                        if(n++ < 100){

                            let panelTipVip = document.querySelector('.panel-overlay');

                            if(panelTipVip){

                                panelTipVip.style.display='none';

                                clearInterval(timer);
                            }

                        }else{

                            clearInterval(timer);

                        }

                    },100)



                    }
                //乐视选集处理
                if(nowNode == "#le_playbox"){

                    setTimeout(function(){

                        let jBlock = document.querySelectorAll('.j_block');

                        if(!jBlock) return;

                        for(let i=0;i<jBlock.length;i++){

                            let videoId = jBlock[i].getAttribute('data-vid');

                            let link = `https://www.le.com/ptv/vplay/${videoId}.html`;

                            jBlock[i].firstChild.setAttribute('href',link);
                        }
                    },3000)
                }

                //B站大会员url处理，页面class不一致
                if(nowNode == ".player-container"){

                    setTimeout(function(){

                        if(!document.querySelector('.player-container') && !document.querySelector('.bpx-player-container')){

                            nowNode = '.player-mask';

                        }else{

                            nowNode = '.bpx-player-container';
                        }

                    },3000)
                }

                document.querySelector('.iconLogo').addEventListener('click',function(){

                    playVideoClass.request('get',`${zhmApiUrl}/jxcode.php?in=${jxCodeInfo.in}&code=${jxCodeInfo.code}`).then((result)=>{

                        location.href=`${zhmApiUrl}/jxjx.php?lrspm=${result}&zhm_jx=${location.href}`;

                    }).cath(err=>{})
                })

                //全局click监听
                document.addEventListener('click',function(e){

                    /*爱奇艺选集去广告*/
                    if(nowName=='iqiyiPc'){

                        e.path.forEach(function(item){

                            if(item.className.indexOf('select-item')!= -1){

                                setTimeout(function(){

                                    location.href=location.href;

                                },1000)

                            }

                        })

                        setTimeout(function(){

                            let dom = document.querySelector('.skippable-after');

                            if(dom){

                                dom.click();

                            }else{

                                return;
                            }

                        },5000)

                    }

                    let areaClassName = [];

                    e.path.filter(function(item){

                        if(item.className == nowWeb[0].areaClassName){

                            areaClassName=item;

                        };

                    })

                    if(areaClassName.length == 0){
                        console.log('不在选集范围');
                        return;
                    }

                    if(nowName=='qqPC'){

                        e.path.forEach(function(item){

                            if(item.className=='episode-list-rect__item' || item.className.indexOf('episode-item') != -1){

                                setTimeout(function(){

                                    location.href=location.href;

                                },1000)

                            }

                        })
                    }

                    if(nowName == 'biliPc'){
                        //在元素范围内，不用跳转，
                        let className = ['bpx-player-video-area'];//点击元素范围，范围取视频播发区域。后续有跳转错误，新增区域即可。

                        let matchNum = 0;

                        e.path.filter(function(item){

                            if(className.indexOf(item.className) != -1){
                                matchNum++;
                            }

                        })

                        if(matchNum > 0){
                            return;
                        }
                        //视频页面选集跳转
                        setTimeout(function(){

                            let videoClassName = ['video-episode-card'];//视频页面续集dom

                            e.path.filter(function(item){

                                if(videoClassName.indexOf(item.className) != -1){
                                    location.href = location.href;
                                }

                            })

                        })

                    }

                    var objLink = {};

                    e.path.forEach(function(item){

                        if(item.href){

                            objLink.href = item.href?item.href:'';

                            objLink.target = item.target?item.target:'';

                            return;
                        }

                    })

                    if(objLink.href && objLink.target != '_blank'){

                        location.href = objLink.href;

                        return;
                    }

                })

                /*腾讯视频点击其它视频跳转*/
                if(nowName=='qqPC'){

                    let figure = document.querySelectorAll('.figure');

                    let figureDetail = document.querySelectorAll('.figure_detail');

                    let listItem = [...figure,...figureDetail];

                    if(listItem.length > 0){

                        listItem.forEach(function(item){

                            item.addEventListener('click',function(){

                                let link = this.getAttribute('href');

                                if(link){

                                    location.href = link;

                                    return;
                                }

                            })

                        });

                    }
                }

            }

        }

        function playMusicFunc(){

            if(self.frameElement && self.frameElement.tagName == "IFRAME"){

                return;
            }

            var playMusicClass = new PlayMusicClass();

            const webUrl = 'http://music.eggvod.cn/';

            var musicId = Math.ceil(Math.random()*100000000);

            var musicHtml = "<div href='javascript:void(0)' id=music"+musicId+" class='zhm_icon' style='cursor:pointer;z-index:98;display:block;width:"+iconVipWidth+"px;position:fixed;"+iconVipPosition+":0;top:"+iconVipTop+"px;text-align:center;'><img src='data:image/gif;base64,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' title='在音乐单曲播放页面点击图标下载' style='width:"+iconVipWidth+"px'></div>";
            //netease 路由两次，需重定义
            var newUrl = location.href;

            let jxMusicWeb = jxMusic[0].web.filter(function(item){

                return newUrl.match(item.match);

            })

            if(jxMusicWeb.length){

                let timerZhmIcon = setInterval(function(){

                    if (document.querySelector('#zhmIcon')){

                        clearInterval(timerZhmIcon); // 取消定时器

                        if(jxMusicWeb[0].name=='kuwo'){

                            setTimeout(function(){

                                let control = document.querySelector('.icon-bar_icon_download_');

                                let icon = control.cloneNode(true);

                                icon.className = '';

                                icon.style='margin-left:10px;';

                                icon.innerHTML = "<a style='font-size:10px;white-space: nowrap;cursor:pointer;color:#555;' id='kuwoDownload'>下载</a>";

                                let controls = document.querySelector('.col_r');

                                controls.before(icon);

                                document.querySelector('#kuwoDownload').addEventListener('click',function(){

                                    let audioSrc = document.querySelector("audio").src;

                                    let songName = document.querySelector('.control .song_name').title;

                                    let artist = document.querySelector('.control .artist').title;

                                    GM_download(audioSrc,songName+'-'+artist+'.mp3');

                                })

                            },2000)
                        }

                        if(jxMusicWeb[0].name=='ximalaya'){

                            setTimeout(function(){
                                //播放器创建下载icon
                                let xmControls = document.querySelector('.xm-player-oprations');

                                let control = xmControls.querySelector('a:nth-of-type(2)');

                                let icon = control.cloneNode(true);

                                icon.innerHTML = "<span style='font-size:10px;white-space: nowrap;cursor:pointer;color:#FFF;' id='ximaDownload'>下载</span>";

                                xmControls.style='position: relative;margin-left:-20px;';

                                document.querySelector('.xm-player-progress').style.width='450px';

                                document.querySelector('.xm-player-playtime').style='position: absolute;right:40px;';

                                xmControls.prepend(icon);
                                //播放器下载事件
                                document.querySelector('#ximaDownload').addEventListener('click',function(){

                                    let fmTitle = document.querySelector('.fm-title');

                                    let fmTitleMatch = fmTitle.href.match(/^https?:\/\/www\.ximalaya\.com\/sound\/(\S*)$/);

                                    let url = 'https://mobile.ximalaya.com/mobile-playpage/track/v3/baseInfo/'+new Date().getTime()+'?device=web&trackId='+fmTitleMatch[1];

                                    playMusicClass.request('get',url).then((result)=>{

                                        let data = JSON.parse(result);

                                        let playUrl = data.trackInfo.playUrlList[1].url;

                                        let str1 = playUrl.replaceAll('-','+');

                                        let str2 = str1.replaceAll('_','/');

                                        let num = str2.length%4;

                                        if(num){

                                            str2 += '===='.substr(num);
                                        }

                                        let decrypted = CryptoJS.AES.decrypt({

                                            ciphertext: CryptoJS.enc.Base64.parse(str2)

                                        }, CryptoJS.enc.Hex.parse("aaad3e4fd540b0f79dca95606e72bf93"), {

                                            mode: CryptoJS.mode.ECB,

                                            padding: CryptoJS.pad.Pkcs7

                                        }).toString(CryptoJS.enc.Utf8);

                                        console.log(decrypted);

                                        if(decrypted){

                                            GM_download(decrypted,data.trackInfo.title+'.mp3');

                                        }else{
                                            console.log('解密地址失败');
                                        }

                                    })

                                })

                                //页面列表创建批量下载
                                let urlMatch = newUrl.match(/^https:\/\/www.ximalaya.com\/album\/[0-9]+/);

                                if(urlMatch){

                                    let soundList = document.querySelector('#anchor_sound_list');

                                    if(soundList){

                                        let soundListHead = soundList.querySelector('.head');

                                        let soundListHeadTitle = soundListHead.querySelector('.sort').lastChild;

                                        let data = [{name:'批量下载',id:'batchDownload'},{name:'重置',id:'reset'},{name:'全选',id:'selectAll'}];

                                        data.forEach(function(item){

                                            let control = soundListHeadTitle.cloneNode(true);

                                            control.setAttribute('id',item.id);

                                            control.innerText = item.name;

                                            soundListHeadTitle.after(control);

                                            control.before(" | ");

                                        });

                                        playMusicClass.xmlyCreateCheckbox();

                                        document.querySelector('#selectAll').addEventListener('click',function(){

                                            let zhmCheckbox = soundList.querySelectorAll("input[name='zhmCheckbox']");

                                            zhmCheckbox.forEach(function(item){

                                                if(!item.checked){

                                                    item.checked=true;
                                                }

                                            })

                                        });

                                        document.querySelector('#reset').addEventListener('click',function(){

                                            let zhmCheckbox = soundList.querySelectorAll("input[name='zhmCheckbox']");

                                            zhmCheckbox.forEach(function(item){

                                                item.checked = false;

                                            })

                                        })

                                        document.querySelector('#batchDownload').addEventListener('click',function(){

                                            //BaseClass.toast('已下载，请稍候');

                                            let zhmCheckbox = soundList.querySelectorAll("input[name='zhmCheckbox']");

                                            zhmCheckbox.forEach(function(item){

                                                if(item.checked){

                                                    let scrMatch = item.value.match(/\/sound\/([0-9]+)/);

                                                    let url = 'https://mobile.ximalaya.com/mobile-playpage/track/v3/baseInfo/'+new Date().getTime()+'?device=web&trackId='+scrMatch[1];

                                                    playMusicClass.request('get',url).then((result)=>{

                                                        let data = JSON.parse(result);

                                                        let playUrl = data.trackInfo.playUrlList[1].url;

                                                        let str1 = playUrl.replaceAll('-','+');

                                                        let str2 = str1.replaceAll('_','/');

                                                        let num = str2.length%4;

                                                        if(num){

                                                            str2 += '===='.substr(num);
                                                        }

                                                        let decrypted = CryptoJS.AES.decrypt({

                                                            ciphertext: CryptoJS.enc.Base64.parse(str2)

                                                        }, CryptoJS.enc.Hex.parse("aaad3e4fd540b0f79dca95606e72bf93"), {

                                                            mode: CryptoJS.mode.ECB,

                                                            padding: CryptoJS.pad.Pkcs7

                                                        }).toString(CryptoJS.enc.Utf8);

                                                        //console.log(decrypted);

                                                        if(decrypted){

                                                            GM_download(decrypted,data.trackInfo.title+'.mp3');

                                                        }else{
                                                            console.log('解密地址失败');
                                                        }

                                                    })

                                                }

                                            })

                                        })

                                        //正序倒序事件

                                        soundListHead.querySelector('.sort').firstChild.addEventListener('click',function(){

                                            setTimeout(function(){

                                                playMusicClass.xmlyCreateCheckbox();

                                            },2000)

                                        });

                                        soundListHeadTitle.addEventListener('click',function(){

                                            setTimeout(function(){

                                                playMusicClass.xmlyCreateCheckbox();

                                            },2000)

                                        });

                                        //翻页事件

                                        let pageBar = document.querySelector('.pagination-page');

                                        pageBar.addEventListener('click',function(){

                                            setTimeout(function(){

                                                playMusicClass.xmlyCreateCheckbox();

                                            },2000)

                                        })
                                        //跳页事件
                                        document.querySelector('button[type=submit]').addEventListener('click',function(){

                                            setTimeout(function(){

                                                playMusicClass.xmlyCreateCheckbox();

                                            },1000)

                                        })
                                    }
                                }else{
                                    console.log('url地址错误');
                                }

                            },1000);

                            //全局点击事件
                            document.addEventListener('click',function(e){

                                var objLink = {};

                                e.path.forEach(function(item){

                                    if(item.href){

                                        objLink.href = item.href?item.href:'';

                                        objLink.target = item.target?item.target:'';

                                        return;
                                    }

                                })

                                if(objLink.href && objLink.target != '_blank'){

                                    location.href = objLink.href;

                                    return;
                                }
                            })

                        }

                        if(jxMusicWeb[0].name=='kugou'){

                            let aDom = document.querySelectorAll('a');

                            aDom.forEach(function(item){

                                let dataObj = item.getAttribute('dataobj');

                                if(dataObj){

                                    item.removeAttribute('dataobj');

                                    item.setAttribute('target','_blank');
                                    //console.log(dataObj);
                                }

                            })

                            if(couponUrl.indexOf('mixsong')!=-1 || couponUrl.indexOf('song') != -1){

                                setTimeout(function(){

                                    let volumeDom = document.querySelector('#volume');

                                    let downloadDom = volumeDom.cloneNode(true);

                                    downloadDom.removeAttribute('id');

                                    downloadDom.style='margin-top:30px';

                                    downloadDom.innerHTML = "<a style='color:#fff;font-size:10px;white-space:nowrap;cursor:pointer;' id='kugouDownload' javascript:void(0);>下载</a>";

                                    volumeDom.before(downloadDom);

                                    volumeDom.style='left:50px;';

                                    document.querySelector('#mode').style='margin-left:90px;';

                                    document.querySelector('#pb_download').style='margin-left:130px;';

                                    document.querySelector('#pb_share').style='margin-left:170px;';

                                    document.querySelector('#list').style='right:-20px;';

                                    document.querySelector('#kugouDownload').addEventListener('click',function(){

                                        let audio = document.querySelector('#myAudio');

                                        let audioSrc = audio.getAttribute('src');

                                        let singerName = document.querySelector('.singerName').title;

                                        let songName = document.querySelector('#songNameTemp').title;

                                        GM_download(audioSrc,songName+'-'+singerName.substr(0,singerName.length-1)+'.mp3');

                                    })

                                },1000)
                            }
                            console.log(couponUrl);
                        }

                        if(jxMusicWeb[0].name=='netease' && location.href == 'https://music.163.com/st/download'){

                            return false;
                        }

                        let zhmPlay = document.getElementById('zhmIcon');

                        setTimeout(function(){

                            zhmPlay.innerHTML = musicHtml;

                            document.querySelector('.zhm_icon').addEventListener('click',function(){

                                let musicUrlData = [
                                    {match:/^https?:\/\/music\.163\.com\/#\/(?:song|dj)\?id/},
                                    {match:/^https?:\/\/y\.music\.163\.com\/m\/(?:song|dj)\?id/},
                                    {match:/^https?:\/\/music\.163\.com\/(?:song|dj)\?id/},
                                    {match:/^https?:\/\/y\.qq\.com\/n\/ryqq\/player/},
                                    {match:/kugou\.com/},
                                    {match:/kuwo\.cn/},
                                    {match:/^https?:\/\/www\.ximalaya\.com/},
                                ]

                                let musicUrl = musicUrlData.filter(function(item){

                                    return location.href.match(item.match);

                                })

                                if(musicUrl.length==0){

                                    BaseClass.toast(jxMusicWeb[0].tip);

                                    return;
                                }

                                switch(jxMusicWeb[0].name){
                                    case 'netease':
                                        neteaseFun();
                                        break;
                                    case 'qq':
                                        qqFun();
                                        break;
                                    case 'kugou':
                                        kugouFun();
                                        break;
                                    case 'kuwo':
                                        kuwoFun();
                                        break;
                                    case 'ximalaya':
                                        ximalayaFun();
                                        break;
                                }

                                function neteaseFun(){

                                    let urlParams = playMusicClass.getUrlParams(location.href);

                                    if(urlParams.id == undefined) return;

                                    let neteaseUrlEncode = encodeURIComponent('https://music.163.com/song?id='+urlParams.id);

                                    let openUrl = webUrl+'?url='+neteaseUrlEncode;

                                    window.open(openUrl);

                                }

                                function qqFun(){

                                    let qqSongMatch;

                                    if(document.querySelector(".player_music__info")){

                                        qqSongMatch = document.querySelector(".player_music__info").childNodes[0].href.match(/songDetail\/(\S*)\?/);

                                    }else if(document.querySelector("#sim_song_info")){

                                        qqSongMatch = document.querySelector("#sim_song_info").childNodes[0].href.match(/song\/(\S*).html/);

                                    }else{

                                        qqSongMatch = '';
                                    }

                                    if(!qqSongMatch[1]){console.log('没有获取到歌曲ID'); return};

                                    let audioLink = encodeURIComponent(document.querySelector("audio").src);

                                    let openUrl = webUrl+'?id='+qqSongMatch[1]+'&type=qq&playUrl='+audioLink;

                                    window.open(openUrl);

                                }

                                function kugouFun(){

                                    let audioModule = document.querySelector('#audioModule');

                                    if(audioModule){

                                        document.querySelector('#audioModule').style='bottom:0px;';

                                        document.querySelector('#showHide_playbar').className = 'icon show-playbar-btn';

                                    }
                                    BaseClass.toast('请点击播放需要下载的歌曲，然后在网页下方播放器内点击"下载"',2000)

                                    //alert('请点击播放需要下载的歌曲，然后在网页下方播放器内点击"下载"。');

                                    /*

                                        let songKugouMatch = newUrl.match(jxMusicWeb[0].match);

                                        let audioSrc = encodeURIComponent(document.querySelector("audio").src);

                                        let openUrl = webUrl+'?id='+songKugouMatch[1]+'&type=kugou&playUrl='+audioSrc;

                                        window.open(openUrl);
                                        */
                                }

                                function kuwoFun(){

                                    document.querySelector('.playControl').style='bottom:0px';

                                    BaseClass.toast('请点击播放需要下载的歌曲，然后在网页下方播放器内点击"下载"',2000)

                                    //alert('请点击播放需要下载的歌曲，然后在网页下方播放器内点击"下载"。');

                                    /*
                                        let songKuwoMatch = newUrl.match(jxMusicWeb[0].match);

                                        let audioSrc = encodeURIComponent(document.querySelector("audio").src);

                                        let openUrl = webUrl+'?id='+songKuwoMatch[1]+'&type=kuwo&playUrl='+audioSrc;

                                        window.open(openUrl);
                                        */
                                }

                                function ximalayaFun(){

                                    document.querySelector('.xm-player').style='bottom:0px';

                                    BaseClass.toast('请点击播放需要下载的歌曲，然后在网页下方播放器内点击"下载"',2000)

                                    //alert('请点击播放需要下载的歌曲，然后在网页下方播放器内点击"下载"。');

                                    /*
                                        let urlInfo = newUrl.match(jxMusicWeb[0].match);

                                        console.log(webUrl+'?id='+urlInfo[1]+'&type=ximalaya&playUrl='+encodeURIComponent(newUrl));

                                        if(urlInfo[1]){

                                            window.open(webUrl+'?id='+urlInfo[1]+'&type=ximalaya&playUrl='+encodeURIComponent(newUrl));

                                        }else{

                                            console.log('没有获取url参数');
                                        }
                                        */
                                }

                            })

                        },iconWaitTime);

                    }else{

                        playMusicClass.createElement('div','zhmIcon');
                    }

                })

                }else{

                    let zhmPlayDom = document.querySelector('#zhmIcon');

                    if(zhmPlayDom){

                        zhmPlayDom.parentNode.removeChild(zhmPlayDom);

                    }

                    console.log('当前音频网址没有添加匹配或匹配错误');

                }

        }

        function zhNiceFunc(){

            var zhClass = new ZhClass();

            //关闭登录弹框
           (async function(){

               let loginModalWrapper = await BaseClass.getElement(".Modal-wrapper");

               if(loginModalWrapper){

                   let closeButton = loginModalWrapper.querySelector('.Modal-closeButton');

                   if(closeButton){

                       closeButton.click();

                   }

               }

            })()

            var zhData = [
                {func:'removeVideo',isOpen:GM_getValue('removeVideo','0'),isOnscroll:1,onload:1},
                {func:'removeAD',isOpen:GM_getValue('removeAD','22'),isOnscroll:0,onload:0},
                {func:'downloadVideo',isOpen:GM_getValue('downloadVideo','22'),isOnscroll:0,onload:0},
                {func:'removeRight',isOpen:GM_getValue('removeRight','0'),isOnscroll:0,onload:0},
                {func:'changeLink',isOpen:GM_getValue('changeLink','22'),isOnscroll:0,onload:0},
                {func:'removeKeyword',isOpen:GM_getValue('removeKeyword','0'),isOnscroll:1,onload:1},
                {func:'showSpecialColumn',isOpen:GM_getValue('specialColumn','22'),isOnscroll:1,onload:1},
                {func:'showVideoTitle',isOpen:GM_getValue('videoTitle','22'),isOnscroll:1,onload:1},
                {func:'removeAuthorName',isOpen:GM_getValue('removeAuthorName','0'),isOnscroll:1,onload:1},
                {func:'removeYanxuan',isOpen:GM_getValue('removeYanxuan','0'),isOnscroll:1,onload:1},
            ]

            zhData.forEach(function(item){
                if(item.isOpen==22 && item.onload==0){
                    zhClass[item.func]();
                }
            })

            window.onload=function(){
                zhData.forEach(function(item){
                    if(item.isOpen==22 && item.onload==1){
                        zhClass[item.func]();
                    }
                })
            }
            window.onscroll = function(){

                var scrollTop = document.documentElement.scrollTop;

                if(scrollTop > 200){

                    zhData.forEach(function(item){
                        if(item.isOpen==22 && item.isOnscroll==1){

                            zhClass[item.func]();
                        }
                    })

                }

            }

        }
    }
})();