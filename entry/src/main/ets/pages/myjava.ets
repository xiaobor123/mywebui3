import { webview } from '@kit.ArkWeb';


// 定义 Config 接口
export interface Config {
  url: string;
  location: string;
  options: webview.CacheOptions
}

export let configs: Array<Config> = [
  // {
  //   url: 'https://www.openharmony.cn/_nuxt/0e255f6.js',
  //   location: '0e255f6.js',
  //   options: {
  //     responseHeaders: [
  //       { headerKey: 'JD-Tag', headerValue: 'xxx' },
  //       { headerKey: 'Last-Modified', headerValue: 'Thu, 20 Mar 2014 10:33:07 GMT' }
  //     ]
  //   },
  // },
  // {
  //   url: 'https://www.openharmony.cn/_nuxt/137ca0b.js',
  //   location: '137ca0b.js',
  //   options: {
  //     responseHeaders: [
  //       { headerKey: 'JD-Tag', headerValue: 'xxx' },
  //       { headerKey: 'Last-Modified', headerValue: 'Thu, 20 Mar 2014 10:33:07 GMT' }
  //     ]
  //   }
  // },
  // {
  //   url: "https://www.openharmony.cn/_nuxt/5ff68ad.js",
  //   location: "5ff68ad.js",
  //   options: {
  //     responseHeaders: [
  //       { headerKey: 'JD-Tag', headerValue: 'xxx' },
  //       { headerKey: 'Last-Modified', headerValue: 'Thu, 20 Mar 2014 10:33:07 GMT' }
  //     ]
  //   }
  // },
  // {
  //   url: "https://www.openharmony.cn/_nuxt/b16c65c.js",
  //   location: "b16c65c.js",
  //   options: {
  //     responseHeaders: [
  //       { headerKey: 'JD-Tag', headerValue: 'xxx' },
  //       { headerKey: 'Last-Modified', headerValue: 'Thu, 20 Mar 2014 10:33:07 GMT' }
  //     ]
  //   }
  // },
  // {
  //   url :"https://www.openharmony.cn/_nuxt/9383c4f.js",
  //   location: "9383c4f.js",
  //   options: {
  //     responseHeaders: [
  //       { headerKey: 'JD-Tag', headerValue: 'xxx' },
  //       { headerKey: 'Last-Modified', headerValue: 'Thu, 20 Mar 2014 10:33:07 GMT' }
  //     ]
  //   }
  // },
  // {
  //   url: "https://www.openharmony.cn/_nuxt/8ca6808.js",
  //   location: "8ca6808.js",
  //   options: {
  //     responseHeaders: [
  //       { headerKey: 'JD-Tag', headerValue: 'xxx' },
  //       { headerKey: 'Last-Modified', headerValue: 'Thu, 20 Mar 2014 10:33:07 GMT' }
  //     ]
  //   }
  // },
]




export interface ResourceConfig {
  urlList: Array<string>,
  type: webview.OfflineResourceType,
  responseHeaders: Array<Header>,
  localPath: string,
}

export const basicResources: Array<ResourceConfig> = [
  // {
  //   localPath: "logo.dcf95b3.png",
  //   urlList: [
  //     'https://www.openharmony.cn/_nuxt/img/logo.dcf95b3.png'
  //   ],
  //   type: webview.OfflineResourceType.IMAGE,
  //   responseHeaders: []
  // },
  // {
  //   localPath: "search.2585098.png",
  //   urlList: [
  //     'https://www.openharmony.cn/_nuxt/img/search.2585098.png'
  //   ],
  //   type: webview.OfflineResourceType.IMAGE,
  //   responseHeaders: []
  // },
  // {
  //   localPath: "button-icon-gray.6deb791.png",
  //   urlList: [
  //     'https://www.openharmony.cn/_nuxt/img/button-icon-gray.6deb791.png'
  //   ],
  //   type: webview.OfflineResourceType.IMAGE,
  //   responseHeaders: []
  // },
  // {
  //   localPath: "bgcPhone.a1b7568.png",
  //   urlList: [
  //     'https://www.openharmony.cn/_nuxt/img/bgcPhone.a1b7568.png'
  //   ],
  //   type: webview.OfflineResourceType.IMAGE,
  //   responseHeaders: []
  // },
  // {
  //   localPath: "%E5%9F%8E%E5%B8%82%E6%B4%BB%E5%8A%A80928/%E9%A6%96%E9%A1%B5%E7%A7%BB%E5%8A%A8banner.png",
  //   urlList: [
  //     'https://images.openharmony.cn/%E6%B4%BB%E5%8A%A8/%E5%9F%8E%E5%B8%82%E6%B4%BB%E5%8A%A80928/%E9%A6%96%E9%A1%B5%E7%A7%BB%E5%8A%A8banner.png'
  //   ],
  //   type: webview.OfflineResourceType.IMAGE,
  //   responseHeaders: []
  // },
  // {
  //   localPath: "4.1releas%E6%89%8B%E6%9C%BA.jpg",
  //   urlList: [
  //     'https://images.openharmony.cn/%E9%A6%96%E9%A1%B5/banner/20240411/4.1releas%E6%89%8B%E6%9C%BA.jpg'
  //   ],
  //   type: webview.OfflineResourceType.IMAGE,
  //   responseHeaders: []
  // },
  // {
  //   localPath: "%E5%88%9B%E6%96%B0%E8%B5%9B2023/20230831/%E4%B8%89%E6%96%B9%E5%BA%93%E7%A7%BB%E5%8A%A8%E7%AB%AF.png",
  //   urlList: [
  //     'https://images.openharmony.cn/%E6%B4%BB%E5%8A%A8/%E5%88%9B%E6%96%B0%E8%B5%9B2023/20230831/%E4%B8%89%E6%96%B9%E5%BA%93%E7%A7%BB%E5%8A%A8%E7%AB%AF.png'
  //   ],
  //   type: webview.OfflineResourceType.IMAGE,
  //   responseHeaders: []
  // },
  // {
  //   localPath: "%E5%88%9B%E6%96%B0%E8%B5%9B%E6%B4%BB%E5%8A%A8%E7%A7%BB%E5%8A%A8%E7%AB%AF.png",
  //   urlList: [
  //     'https://images.openharmony.cn/%E6%B4%BB%E5%8A%A8/%E5%88%9B%E6%96%B0%E8%B5%9B2023/20230831/%E5%88%9B%E6%96%B0%E8%B5%9B%E6%B4%BB%E5%8A%A8%E7%A7%BB%E5%8A%A8%E7%AB%AF.png'
  //   ],
  //   type: webview.OfflineResourceType.IMAGE,
  //   responseHeaders: []
  // },
  // {
  //   localPath: "logo.0456c15.png",
  //   urlList: [
  //     'https://www.openharmony.cn/_nuxt/img/logo.0456c15.png'
  //   ],
  //   type: webview.OfflineResourceType.IMAGE,
  //   responseHeaders: []
  // },
  // {
  //   localPath: "btn-bilibili.02de57b.png",
  //   urlList: [
  //     'https://www.openharmony.cn/_nuxt/img/btn-bilibili.02de57b.png'
  //   ],
  //   type: webview.OfflineResourceType.IMAGE,
  //   responseHeaders: []
  // },
  // {
  //   localPath: "core-card-item1.5977b65.png",
  //   urlList: [
  //     'https://www.openharmony.cn/_nuxt/img/core-card-item1.5977b65.png'
  //   ],
  //   type: webview.OfflineResourceType.IMAGE,
  //   responseHeaders: []
  // },
  // {
  //   localPath: "core-card-item2.a72a0d1.png",
  //   urlList: [
  //     'https://www.openharmony.cn/_nuxt/img/core-card-item2.a72a0d1.png'
  //   ],
  //   type: webview.OfflineResourceType.IMAGE,
  //   responseHeaders: []
  // },
  // {
  //   localPath: "core-card-item3.8984f01.png",
  //   urlList: [
  //     'https://www.openharmony.cn/_nuxt/img/core-card-item3.8984f01.png'
  //   ],
  //   type: webview.OfflineResourceType.IMAGE,
  //   responseHeaders: []
  // },
  // {
  //   localPath: "core-card-item4.057c5ac.png",
  //   urlList: [
  //     'https://www.openharmony.cn/_nuxt/img/core-card-item4.057c5ac.png'
  //   ],
  //   type: webview.OfflineResourceType.IMAGE,
  //   responseHeaders: []
  // },
];



