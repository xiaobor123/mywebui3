import web_webview from '@ohos.web.webview'

// todo: 搞一个离线渲染的web组件用于加载所有内容
// 找简单的网页
//lazyforeach 优化tabs（可能用不了）
// 高负载场景下分针渲染
//全局自定义组件复用实现
import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';
import { webview } from '@kit.ArkWeb';
import {createNWeb, getNWeb} from './preparepage'
import {createCommonWeb, getCommonWeb} from './common'



@Entry
@Component
struct TabsExample {
  @State currentIndex: number = 0;
  private tabsController: TabsController = new TabsController();
  private webviewController1: webview.WebviewController = new webview.WebviewController();

  aboutToAppear(): void {
    // 初始化用于注入本地资源的Web组件
    webview.WebviewController.prepareForPageLoad('https://m.baidu.com/', true, 2);
    webview.WebviewController.prepareForPageLoad('https://m.thepaper.cn/', true, 2);
    webview.WebviewController.prepareForPageLoad('https://app.people.cn/', true, 2);
    createNWeb('https://xxx');
    createCommonWeb('https://m.baidu.com/');
  }


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
          NodeContainer(getCommonWeb('https://m.baidu.com/'))
            .height('90%')
            .width('100%')

        }
        .tabBar(this.TabBuilder('百度新闻', 0, $r('app.media.home_selected'), $r('app.media.home_normal')))


        TabContent() {
           NodeContainer(getCommonWeb('https://m.thepaper.cn/'))
             .height('90%')
             .width('100%')
         }
         .tabBar(this.TabBuilder('澎湃新闻', 1, $r('app.media.mine2_selected'), $r('app.media.mine2_normal')))



        TabContent() {
          NodeContainer(getCommonWeb('https://app.people.cn/'))
            .height('90%')
            .width('100%')
        }
        .tabBar(this.TabBuilder('人民日报', 2, $r('app.media.mine3_selected'), $r('app.media.mine3_normal')))

    }
    .barWidth('100%')
    .barHeight(50)
    .backgroundColor('#f2f3f5')
    .onChange((index: number) => {
      this.currentIndex = index;
      console.log("1111")
    })
  }
}