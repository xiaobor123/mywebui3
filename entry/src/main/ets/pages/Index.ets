import web_webview from '@ohos.web.webview'

// todo: 搞一个离线渲染的web组件用于加载所有内容
// 找简单的网页
//lazyforeach 优化tabs（可能用不了）
// 高负载场景下分针渲染
//全局自定义组件复用实现
//多线程优化
//组件复用
import { webview } from '@kit.ArkWeb';
import {createNWeb, getNWeb} from './preparepage'
import {createCommonWeb, getCommonWeb} from './common'
import { displaySync } from '@kit.ArkGraphics2D';
import { SlidingTabController } from '@xqw/sliding-tabs/src/main/ets/SlidingTabController'
import { SlidingTabs } from '@xqw/sliding-tabs/src/main/ets/SlidingTabs'




@Entry
@ComponentV2
struct TabsExample {
  tabController = new SlidingTabController()

  aboutToAppear(): void {
    // 初始化用于注入本地资源的Web组件
    webview.WebviewController.prepareForPageLoad('https://m.baidu.com/', true, 2);
    webview.WebviewController.prepareForPageLoad('https://m.thepaper.cn/', true, 2);
    webview.WebviewController.prepareForPageLoad('https://app.people.cn/', true, 2);
    //可能是异步的，大约只花费了50ms
    //console.log('create start')
    createNWeb('https://xxx');
    createCommonWeb('https://m.baidu.com/');
    createCommonWeb('https://m.thepaper.cn/');
    createCommonWeb('https://app.people.cn/');
    //console.log('create end')
  }
  @Local tabs: Array<string> = [
    'https://m.baidu.com/',
    'https://m.thepaper.cn/',
    'https://app.people.cn/'
  ]

  build() {
    Column(){
      Divider().height(2)
      Text("搭配Swiper使用").height(40)
      Divider().height(2)
      SlidingTabs({
        tabs: this.tabs,
        barMode : "fixed",
        tabController: this.tabController,
        tabStyle:{
          indicatorWidthWrapTab:true,
          fontColorSelect:Color.Blue
        },
        onTabIndicatorBuilder:()=>{
          this.TabIndicator()
        },
        onTabItemBuilder:(tab,index)=>{
          this.TabItem(tab,index)
        }

      })
      Swiper(this.tabController.swiperController){
        ForEach(this.tabs,(item:string,index)=>{
          Stack()
          {
            NodeContainer(getCommonWeb(item))
              .height('90%')
              .width('100%')
          }
          .width('100%').height('100%')
        })
      }.layoutWeight(1)
      .onGestureSwipe((index,extraInfo)=>{
        this.tabController.swiperOnGestureSwipe(index,extraInfo)
      })
      .onAreaChange((oldValue,newValue)=>{
        this.tabController.swiperOnAreaChange(oldValue,newValue)
      })
      .onAnimationStart((index,targetIndex,extraInfo)=>{
        this.tabController.swiperOnAnimationStart(index,targetIndex,extraInfo)
      })
    }
  }

  @Builder
  TabIndicator(){
    Stack().width('100%').height('100%')
      .backgroundColor(Color.Pink).borderRadius(12)
  }

  @Builder
  TabItem(tab:string,index:number){
    Column(){
      Image($r('app.media.app_icon')).width(20).margin({bottom:4})
      Text(tab)
        .fontColor(this.tabController.selectedTabIndex == index ? Color.Black : Color.Gray)
        .fontWeight(this.tabController.selectedTabIndex == index ? FontWeight.Medium : FontWeight.Normal)
        .fontSize(this.tabController.selectedTabIndex == index ? 18 : 16)
        .animation({ duration: 300 })
    }
  }

}