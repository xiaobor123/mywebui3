import { webview } from '@kit.ArkWeb';


// 定义 Config 接口
export interface Config {
  url: string;
  localPath: string;
  options: webview.CacheOptions
}

export let configs: Array<Config> = [
  {
    url: 'https://mbdp02.bdstatic.com/pcnews/static/fisp_static/common/resource/js/usermonitor_88a158c.js?v=1.2',
    localPath: 'usermonitor_88a158c.js',
    options: {
      responseHeaders: [
        { headerKey: 'JD-Tag', headerValue: 'xxx' },
        { headerKey: 'Last-Modified', headerValue: 'Thu, 20 Mar 2014 10:33:07 GMT' }
      ]
    }
  },
  {
    url: 'https://mbdp02.bdstatic.com/pcnews/static/fisp_static/news/js/jquery-1.8.3.min_a6ffa58.js',
    localPath: 'jquery-1.8.3.min_a6ffa58.js',
    options: {
      responseHeaders: [
        { headerKey: 'JD-Tag', headerValue: 'xxx' },
        { headerKey: 'Last-Modified', headerValue: 'Wed, 11 Sep 2024 13:05:54 GMT' }
      ]
    }
  },
  {
    url: 'https://efe-h2.cdn.bcebos.com/cliresource/ubc-report-sdk/2.0.8/ubc-web-sdk.umd.min.js',
    localPath: 'ubc-web-sdk.umd.min.js',
    options: {
      responseHeaders: [
        { headerKey: 'JD-Tag', headerValue: 'xxx' },
        { headerKey: 'Last-Modified', headerValue: 'Wed, 22 Nov 2017 02:56:56 GMT' }
      ]
    }
  },
  {
    url: 'https://gss0.bdstatic.com/5foIcy0a2gI2n2jgoY3K/static/fisp_static/wza/aria.js?appid=c890648bf4dd00d05eb9751dd0548c30',
    localPath: 'aria.js',
    options: {
      responseHeaders: [
        { headerKey: 'JD-Tag', headerValue: 'xxx' },
        { headerKey: 'Last-Modified', headerValue: 'Fri, 15 Dec 2023 09:03:38 GMT' }
      ]
    }
  },
  {
    url: 'https://news-bos.cdn.bcebos.com/mvideo/pcconf_2019.js?1726819150345',
    localPath: 'pcconf_2019.js',
    options: {
      responseHeaders: [
        { headerKey: 'JD-Tag', headerValue: 'xxx' },
        { headerKey: 'Last-Modified', headerValue: 'Tue, 27 Aug 2024 12:08:36 GMT' }
      ]
    }
  },
  {
    url: 'https://mbdp02.bdstatic.com/pcnews/static/fisp_static/common/lib/mod_b818356.js',
    localPath: 'mod_b818356.js',
    options: {
      responseHeaders: [
        { headerKey: 'JD-Tag', headerValue: 'xxx' },
        { headerKey: 'Last-Modified', headerValue: 'Mon, 13 Mar 2023 10:42:57 GMT' }
      ]
    }
  },
  {
    url: 'https://mbdp02.bdstatic.com/pcnews/static/fisp_static/common/framework_static_include/framework_static_include_aa59e0d.js',
    localPath: 'framework_static_include_aa59e0d.js',
    options: {
      responseHeaders: [
        { headerKey: 'JD-Tag', headerValue: 'xxx' },
        { headerKey: 'Last-Modified', headerValue: 'Mon, 13 Mar 2023 10:42:57 GMT' }
      ]
    }
  },
  {
    url: 'https://mbdp02.bdstatic.com/pcnews/static/fisp_static/news/focustop/focustop_b924ecb.js',
    localPath: 'focustop_b924ecb.js',
    options: {
      responseHeaders: [
        { headerKey: 'JD-Tag', headerValue: 'xxx' },
        { headerKey: 'Last-Modified', headerValue: 'Mon, 13 Mar 2023 10:42:57 GMT' }
      ]
    }
  },
  {
    url: 'https://mbdp02.bdstatic.com/pcnews/static/fisp_static/common/module_static_include/module_static_include_5d6af88.js',
    localPath: 'module_static_include_5d6af88.js',
    options: {
      responseHeaders: [
        { headerKey: 'JD-Tag', headerValue: 'xxx' },
        { headerKey: 'Last-Modified', headerValue: 'Mon, 13 Mar 2023 10:42:57 GMT' }
      ]
    }
  },
  {
    url: 'https://fex.bdstatic.com/hunter/alog/alog.min.js?v=-19987-19987',
    localPath: 'alog.min.js',
    options: {
      responseHeaders: [
        { headerKey: 'JD-Tag', headerValue: 'xxx' },
        { headerKey: 'Last-Modified', headerValue: 'Mon, 13 Mar 2023 10:42:57 GMT' }
      ]
    }
  },
  {
    url: 'https://hm.baidu.com/h.js?e9e114d958ea263de46e080563e254c4',
    localPath: 'h.js',
    options: {
      responseHeaders: [
        { headerKey: 'JD-Tag', headerValue: 'xxx' },
        { headerKey: 'Last-Modified', headerValue: 'Mon, 13 Mar 2023 10:42:57 GMT' }
      ]
    }
  },
  {
    url: 'https://fex.bdstatic.com/hunter/alog/dp.min.js?v=-19987-19987',
    localPath: 'dp.min.js',
    options: {
      responseHeaders: [
        { headerKey: 'JD-Tag', headerValue: 'xxx' },
        { headerKey: 'Last-Modified', headerValue: 'Mon, 13 Mar 2023 10:42:57 GMT' }
      ]
    }
  },
]




export interface ResourceConfig {
  urlList: Array<string>,
  type: webview.OfflineResourceType,
  responseHeaders: Array<Header>,
  localPath: string,
}

export const basicResources: Array<ResourceConfig> = [
  {
    localPath: "log-news.png",
    urlList: [
      'https://news-bos.cdn.bcebos.com/mvideo/log-news.png'
    ],
    type: webview.OfflineResourceType.IMAGE,
    responseHeaders: []
  },
  {
    localPath: "newErweima_9fa03e0.png",
    urlList: [
      'https://mbdp02.bdstatic.com/pcnews/static/fisp_static/common/img/sidebar/newErweima_9fa03e0.png'
    ],
    type: webview.OfflineResourceType.IMAGE,
    responseHeaders: []
  },
  {
    localPath: "report_3c9a61f.png",
    urlList: [
      'https://mbdp02.bdstatic.com/pcnews/static/fisp_static/common/img/sidebar/report_3c9a61f.png'
    ],
    type: webview.OfflineResourceType.IMAGE,
    responseHeaders: []
  },
  {
    localPath: "roumer_033b02b.png",
    urlList: [
      'https://mbdp02.bdstatic.com/pcnews/static/fisp_static/common/img/sidebar/roumer_033b02b.png'
    ],
    type: webview.OfflineResourceType.IMAGE,
    responseHeaders: []
  },
  {
    localPath: "accessibility_7ba1339.png",
    urlList: [
      'https://mbdp02.bdstatic.com/pcnews/static/fisp_static/common/img/sidebar/accessibility_7ba1339.png'
    ],
    type: webview.OfflineResourceType.IMAGE,
    responseHeaders: []
  },
  {
    localPath: "arrow-down_88161d2.png",
    urlList: [
      'https://mbdp02.bdstatic.com/pcnews/static/fisp_static/news/img/arrow-down_88161d2.png'
    ],
    type: webview.OfflineResourceType.IMAGE,
    responseHeaders: []
  },
  {
    localPath: "bg_19da_xinjingjie_029074f.png",
    urlList: [
      'https://mbdp02.bdstatic.com/pcnews/static/fisp_static/news/img/carousel/bg_19da_xinjingjie_029074f.png'
    ],
    type: webview.OfflineResourceType.IMAGE,
    responseHeaders: []
  },
  {
    localPath: "icon-carousel_b4b1d29.png",
    urlList: [
      'https://mbdp02.bdstatic.com/pcnews/static/fisp_static/news/img/carousel/icon-carousel_b4b1d29.png'
    ],
    type: webview.OfflineResourceType.IMAGE,
    responseHeaders: []
  },
  {
    localPath: "icon-dot-2x_fe00451.png",
    urlList: [
      'https://mbdp02.bdstatic.com/pcnews/static/fisp_static/news/img/carousel/icon-dot-2x_fe00451.png'
    ],
    type: webview.OfflineResourceType.IMAGE,
    responseHeaders: []
  },
  {
    localPath: "icon-merged_b8bc211.png",
    urlList: [
      'https://mbdp02.bdstatic.com/pcnews/static/fisp_static/common/img/sidebar/icon-merged_b8bc211.png'
    ],
    type: webview.OfflineResourceType.IMAGE,
    responseHeaders: []
  },
];


