import { webview } from '@kit.ArkWeb';


// 定义 Config 接口
export interface Config {
  url: string;
  localPath: string;
  options: webview.CacheOptions
}

export let configs_jd: Array<Config> = [
  {
    url: 'https://misc.360buyimg.com/jdf/lib/jquery-1.6.4.js?v=20240117',
    localPath: 'jquery-1.6.4.js',
    options: {
      responseHeaders: [
        { headerKey: 'JD-Tag', headerValue: 'xxx' },
        { headerKey: 'Last-Modified', headerValue: 'Thu, 20 Mar 2014 10:33:07 GMT' }
      ]
    }
  },
  {
    url: 'https://wl.jd.com/wl.js',
    localPath: 'wl.js',
    options: {
      responseHeaders: [
        { headerKey: 'JD-Tag', headerValue: 'xxx' },
        { headerKey: 'Last-Modified', headerValue: 'Wed, 11 Sep 2024 13:05:54 GMT' }
      ]
    }
  },
  {
    url: 'https://misc.360buyimg.com/??mtd/pc/common/js/o2_ua.js,mtd/pc/base/1.0.0/event.js?v=20240117',
    localPath: 'o2_ua+event.js',
    options: {
      responseHeaders: [
        { headerKey: 'JD-Tag', headerValue: 'xxx' },
        { headerKey: 'Last-Modified', headerValue: 'Wed, 22 Nov 2017 02:56:56 GMT' }
      ]
    }
  },
  {
    url: 'https://h5static.m.jd.com/act/jd-jssdk/latest/jd-jssdk.min.js',
    localPath: 'jd-jssdk.min.js',
    options: {
      responseHeaders: [
        { headerKey: 'JD-Tag', headerValue: 'xxx' },
        { headerKey: 'Last-Modified', headerValue: 'Fri, 15 Dec 2023 09:03:38 GMT' }
      ]
    }
  },
  {
    url: 'https://gias.jd.com/js/pc-tk.js?v=20240117',
    localPath: 'pc-tk.js',
    options: {
      responseHeaders: [
        { headerKey: 'JD-Tag', headerValue: 'xxx' },
        { headerKey: 'Last-Modified', headerValue: 'Tue, 27 Aug 2024 12:08:36 GMT' }
      ]
    }
  },
  {
    url: 'https://storage.360buyimg.com/staticapp/pc_mall_public/encrypt/sha256.js?v=20240117',
    localPath: 'sha256.js',
    options: {
      responseHeaders: [
        { headerKey: 'JD-Tag', headerValue: 'xxx' },
        { headerKey: 'Last-Modified', headerValue: 'Mon, 13 Mar 2023 10:42:57 GMT' }
      ]
    }
  },
]

