// Index.ets
// 导入页面路由模块
import { router } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';
import { webview } from '@kit.ArkWeb';
import systemDateTime from '@ohos.systemDateTime'
import { TConfig } from '../entryability/EntryAbility'
import EntryAbility from '../entryability/EntryAbility'
import { hilog } from '@kit.PerformanceAnalysisKit';
import { HashSet } from '@kit.ArkTS';
import {createWebNode, getWebNode} from "./common"
import { window } from '@kit.ArkUI';

@Entry
@Component
struct Index {
  webController: webview.WebviewController = new webview.WebviewController();
  // delegate: webview.WebDownloadDelegate = new webview.WebDownloadDelegate();
  webController2: webview.WebviewController = new webview.WebviewController();
  webController3: webview.WebviewController = new webview.WebviewController();
  // tabsController: TabsController = new TabsController();
  // responseWeb: WebResourceResponse = new WebResourceResponse();
  url: string = TConfig.url;
  url2: string = TConfig.url2;
  url3: string = TConfig.url3;
  jsFiles: HashSet<string> = new HashSet();
  rep: RegExp = /\.js($|\?)/
  build() {
    Tabs(){
      TabContent(){
        Web({ src: this.url, controller: this.webController })
          .domStorageAccess(true)
          .fileAccess(true)
          .imageAccess(true)
          .onAppear(()=>{
            hilog.info(0x0001,'testTag', 'Index-Web onAppear');
            // this.webController.setDownloadDelegate(this.delegate);
          })
          .onPageBegin((event) => {
            // hilog.info(0x0001,'testTag','Index-Web onPageBegin');
          })
          .onPageEnd((event) => {
            // hilog.info(0x0001,'testTag', 'Index-Web onPageEnd');
            // hilog.info(0x0001,'testTag','EntryCreate to WebPageEnd time: %{public}d ms', systemDateTime.getTime(false)-EntryAbility.EntryCreateTime);
            // this.webController.prefetchPage(this.url2)
            // this.jsFiles.forEach((value?: string, key?: string): void => {
            //   console.log("value:" + value);
            // })
            // console.log("length:" + this.jsFiles.length);
            // let context = getContext(this) as common.UIAbilityContext;
            // let filesDir = context.filesDir;
            // console.log("filesDir:" + filesDir);
            createWebNode(TConfig.url2, EntryAbility.uiContext);
            createWebNode(TConfig.url3, EntryAbility.uiContext);
          })
          .onDisAppear(()=>{
            hilog.info(0x0001,'testTag', 'Index-Web onDisAppear');
          })
          .onDownloadStart((event) => {
            // if (event) {
            //   // hilog.info(0x0001,'testTag','%{public}s','onDownloadStart-url:' + event.url);
            //   // console.log('userAgent:' + event.userAgent)
            //   // console.log('contentDisposition:' + event.contentDisposition)
            //   // console.log('contentLength:' + event.contentLength)
            //   // console.log('mimetype:' + event.mimetype)
            // }
          })
          .onResourceLoad((event) => {
            // console.log('onResourceLoad-url: ' + event.url);
            // if (this.rep.test(event.url)) {
            //   console.log('onResourceLoad-url: ' + event.url);
            //   this.jsFiles.add(event.url);
            // }
          })
          .onInterceptRequest((event) => {
            if (event) {
              // console.log('onInterceptRequest-url:' + event.request.getRequestUrl());
            }
            return null;
          })
          .onLoadIntercept((event) => {
            // console.log('onLoadIntercept-url:' + event.data.getRequestUrl());
            // console.log('isMainFrame:' + event.data.isMainFrame());
            // console.log('isRedirect:' + event.data.isRedirect());
            // console.log('isRequestGesture:' + event.data.isRequestGesture());
            return false;
          })
      }
      .tabBar('baidu')
      .onWillHide(()=>{
        // hilog.info(0x0001,'testTag','baidu-Web onWillHide');
      });
      TabContent(){
        NodeContainer(getWebNode(TConfig.url2))
          .height('100%')
          .width('100%')
      }
      .tabBar('the-paper')

      TabContent(){
        NodeContainer(getWebNode(TConfig.url3))
          .height('100%')
          .width('100%')
      }
      .tabBar('openharmony')
    }
  }
}