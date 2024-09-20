/** 百度新闻PC端去掉所有一级标题的超链接，删除娱乐版块*/
var hideModelFn = function() {
    // 修改国际及国内模块标题
    $('.civilnews a[href="/guonei"]').text('视野');
    $('.InternationalNews a[href="/guoji"]').text('天下');
    // 国内模块去掉标题a标签链接
    $('.civilnews .column-title-border a')[0] && ($('.civilnews .column-title-border a')[0].href = 'javascript:void(0);');
    $('.civilnews .column-title-border a')[0] && ($('.civilnews .column-title-border a')[0].target = '');
    // 国际模块去掉标题a标签链接
    $('.InternationalNews .column-title-border a')[0] && ($('.InternationalNews .column-title-border a')[0].href = 'javascript:void(0);');
    $('.InternationalNews .column-title-border a')[0] && ($('.InternationalNews .column-title-border a')[0].target = '');
    // 体育模块去掉标题a标签链接
    $('.SportNews .column-title-border a')[0] && ($('.SportNews .column-title-border a')[0].href = 'javascript:void(0);');
    $('.SportNews .column-title-border a')[0] && ($('.SportNews .column-title-border a')[0].target = '');
    // 财经模块去掉标题a标签链接
    $('.FinanceNews .column-title-border a')[0] && ($('.FinanceNews .column-title-border a')[0].href = 'javascript:void(0);');
    $('.FinanceNews .column-title-border a')[0] && ($('.FinanceNews .column-title-border a')[0].target = '');
    // 科技模块去掉标题a标签链接
    $('.TechNews .column-title-border a')[0] && ($('.TechNews .column-title-border a')[0].href = 'javascript:void(0);');
    $('.TechNews .column-title-border a')[0] && ($('.TechNews .column-title-border a')[0].target = '');
    // 军事模块去掉标题a标签链接
    $('.MilitaryNews .column-title-border a')[0] && ($('.MilitaryNews .column-title-border a')[0].href = 'javascript:void(0);');
    $('.MilitaryNews .column-title-border a')[0] && ($('.MilitaryNews .column-title-border a')[0].target = '');
    // 互联网模块去掉标题a标签链接
    $('.InternetNews .column-title-border a')[0] && ($('.InternetNews .column-title-border a')[0].href = 'javascript:void(0);');
    $('.InternetNews .column-title-border a')[0] && ($('.InternetNews .column-title-border a')[0].target = '');
    // 女人模块去掉标题a标签链接
    $('.LadyNews .column-title-border a')[0] && ($('.LadyNews .column-title-border a')[0].href = 'javascript:void(0);');
    $('.LadyNews .column-title-border a')[0] && ($('.LadyNews .column-title-border a')[0].target = '');
    // 删除娱乐模块
    $('.EnterNews').hide();
    // 删除nvr模块
    $('.LadyNews').hide();
};

var hideModel = function () {
    if (window.isHidedModel) {
        return;
    }
    if ($('.LadyNews .column-title-border a')[0]) {
        hideModelFn();
        window.isHidedModel = true;
    } else {
        setTimeout(hideModel, 50)
    }
};

// 删除控制导航的滚动事件
var removeNavScroll = function () {
    setTimeout(()=> {
        if (!$) {
            removeNavScroll();
        }
        if ($._data(window).events) {
            $._data(window).events.scroll[1] = null;
            // 监听 scroll 事件显隐回到顶部按钮
            var $topBtn = $('.mod-sidebar').find('.gotop');
            window.addEventListener('scroll', function () {
                var sTop = $(window).scrollTop();
                if (sTop > 200) {
                    $topBtn.slideDown(300);
                }
                else {
                    $topBtn.slideUp(300);
                }
                if (sTop > 600) {
                    hideModel();
                }
            });
        } else {
            removeNavScroll();
        }
    }, 10)
}
// 隐藏底bar百度新闻独家出品第二条
var someDomHide = function() {
    setTimeout(()=> {
        if (typeof $ !== 'undefined') {
            $('#menu').hide();
            $('#tab-login').hide();
            // $('#channel-all').hide();
            // $('#channel-shanghai').hide();
            // 隐藏底bar百度新闻独家出品第二条、及辅助信息的部分
            // $('.bot-right').find('ol').find('li').eq(-1).hide();
            $('.bot-right').find('ol').find('li').eq(-1).remove();
            // $('#footer').prev().hide();
            $('#footer').prev().remove();
            // 替换定部导航中音乐跳转链接
            $('#header-link-wrapper').find('a[data-path="search?fr=news&ie=utf-8&key="]').attr('href', 'https://music.taihe.com');
            $('#header-link-wrapper').find('a').each(function() {
                $(this).attr('target', '_blank');
            });
            var footerTipsTimeYear = (new Date()).getFullYear();
            $("#footer").html('<a href="//news-bos.cdn.bcebos.com/mvideo/baidu_news_protocol.html">用户协议</a> <a href="https://news-bos.cdn.bcebos.com/mvideo/privacy.html">隐私策略</a> <a href="http://e.baidu.com/?refer=1268">企业推广</a> <a href="//help.baidu.com/newadd?prod_id=5&category=1">投诉中心</a> <a href="//b.bdstatic.com/searchbox/image/gcp/20230526/3812451844.jpg">营业执照</a> <span> 京ICP证030173号 </span> <span> 京公网安备11000002000001号 </span> <span>《互联网新闻信息服务许可》编号：11220180008</span> <span>《互联网宗教信息服务许可证》编号：京（2022）0000043</span> <span>&copy;' + footerTipsTimeYear + 'Baidu</span> <a class="cy" href="//www.baidu.com/duty/">使用百度前必读</a> <a target="_blank" class="img-link img-link1" href="https://cn.china.cn/"> </a> <a target="_blank" class="img-link img-link2" href="http://cyberpolice.mps.gov.cn/wfjb/"> </a> <a target="_blank" class="img-link img-link3" href="http://www.bjjubao.org/"> </a>');
            removeNavScroll();
        } else {
            someDomHide();
        }
    }, 10)
}
someDomHide();
setTimeout(()=> {
    someDomHide();
}, 1000)
var TIME = new Date().getTime();

var AConf = window.AConf = {
    activity: false,
    imgUrl: '//news-bos.cdn.bcebos.com/mvideo/2023lianghui3.jpg',
    timeFlag: TIME,
    extCSSRule: ''
}

try {
    var nowTime = new Date().getTime();
    var startTime = new Date('2024-03-03 12:00:00'.replace(/-/g,'/')).getTime(); // 开始时间
    var endTime = new Date('2024-03-12 00:00:00'.replace(/-/g,'/')).getTime(); // 结束时间
    if (nowTime > startTime && nowTime < endTime) {
        AConf = window.AConf = {
            activity: true,
            imgUrl: '//news-bos.cdn.bcebos.com/mvideo/2024lianghui2.jpg',
            timeFlag: TIME,
            extCSSRule: ''
        }
        // document.getElementsByTagName('html')[0].setAttribute('style', 'filter: grayscale(100%); -webkit-filter: grayscale(100%); -moz-filter: grayscale(100%); -ms-filter: grayscale(100%); -o-filter: grayscale(100%); filter: url("data:image/svg+xml;utf8,#grayscale"); filter:progid:DXImageTransform.Microsoft.BasicImage(grayscale=1); -webkit-filter: grayscale(1);');
    }

    function loadjscssfile(filename, filetype) {

        if (filetype == "js") {
            var fileref = document.createElement('script');
            fileref.setAttribute("type", "text/javascript");
            fileref.setAttribute("src", filename);
        } else if (filetype == "css") {

            var fileref = document.createElement('link');
            fileref.setAttribute("rel", "stylesheet");
            fileref.setAttribute("type", "text/css");
            fileref.setAttribute("href", filename);
        } else if (filetype == 'meta') {
            if (location.protocol == 'http:') {
                var oMeta = document.createElement('meta');
                oMeta.name = 'baidu_union_verify';
                oMeta.content = 'c06c0cb3fdfe79722bc814edc74f301e';
                document.getElementsByTagName('head')[0].appendChild(oMeta);
            }
        }
        if (typeof fileref != "undefined") {
            document.getElementsByTagName("head")[0].appendChild(fileref);
        }

    }
    loadjscssfile("//news-bos.cdn.bcebos.com/mvideo/temp.css?radom=" + new Date().getTime(), "css");

    var tempStyle = document.createElement('style');
    tempStyle.type = 'text/css';
    tempStyle.id = 'tempStyle' + new Date().getTime();
    tempStyle.innerHTML = 
    '.hotnews li strong {display: -webkit-box!important;-webkit-box-orient: vertical;-webkit-line-clamp: 3!important;line-clamp: 3!important;overflow: hidden;text-overflow: ellipsis;}'
    + '.mod-headline-tab .tab-login {display: none!important;}'
    + '.mod-navbar {display: none!important;}';
    document.getElementsByTagName('head')[0].appendChild(tempStyle);
} catch (e) {

}

// try {
//     function changeColumnName() {
//         var cityName = $('#city_name b').text();
//         var columnName = cityName === '北京' ? '垃圾分类专区' : '新闻资讯';
//
//         $('#internet-aside-gsdt h3').text(columnName);
//     }
//
//     setTimeout(function(){
//         changeColumnName();
//         $('#change-city').on('click', function() {
//             $('#city_view a').on('click', function() {
//                 setTimeout(function(){
//                     changeColumnName();
//                     }, 200);
//             });
//         });
//     }, 1000);
//
// } catch (e) {
//
// }

try {
    setTimeout(function() {
        $('.item.report a').attr('href', 'https://12377.cn');
    }, 200);
} catch (e) {

}
