import web_webview from '@ohos.web.webview'

import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { webview } from '@kit.ArkWeb';
import {createNWeb, getNWeb} from './common'
import { hiTraceMeter } from '@kit.PerformanceAnalysisKit';

@Entry
@Component
struct TabsExample {
  @State currentIndex: number = 0;
  private tabsController: TabsController = new TabsController();
  private webviewController1: webview.WebviewController = new webview.WebviewController();
  @Builder TabBuilder(title: string, targetIndex: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      Image(this.currentIndex === targetIndex ? selectedImg : normalImg)
        .size({ width: 25, height: 25 })
      Text(title)
        .fontColor(this.currentIndex === targetIndex ? '#1698CE' : '#6B6B6B')
    }
    .width('100%')
    .height(50)
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.currentIndex = targetIndex;
      this.tabsController.changeIndex(this.currentIndex);
    })
  }

  build() {
    Tabs({ barPosition: BarPosition.End, controller: this.tabsController }) {
       TabContent() {
        NodeContainer(getNWeb('https://news.baidu.com/'))
          .height('90%')
          .width('100%')

      }
      .tabBar(this.TabBuilder('百度新闻', 0, $r('app.media.home_selected'), $r('app.media.home_normal')))


      //TabContent() {
         //NodeContainer(getNWeb('https://www.thepaper.cn/'))
           //.height('90%')
           //.width('100%')
       //}
       //.tabBar(this.TabBuilder('澎湃新闻', 1, $r('app.media.mine2_selected'), $r('app.media.mine2_normal')))

      /*TabContent() {
        NodeContainer(getNWeb('https://news.sina.com.cn/'))
          .height('90%')
          .width('100%')
      }
      .tabBar(this.TabBuilder('新浪新闻', 3, $r('app.media.mine3_selected'), $r('app.media.mine3_normal')))
      */
    }
    .barWidth('100%')
    .barHeight(50)
    .backgroundColor('#f2f3f5')
    .onChange((index: number) => {
      this.currentIndex = index;
    })
  }
}