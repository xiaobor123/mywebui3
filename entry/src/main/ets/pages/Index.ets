import { WebTabController } from './WebTabController'
import {WebTabs} from './WebTab'

@Entry
@ComponentV2
struct TabsExample {
  WebController = new WebTabController()
  @Local tabs: Array<string> = [
    'https://m.baidu.com/',
    'https://m.thepaper.cn/',
    'https://www.openharmony.cn/'
  ]
  @Local names: Array<[string, Resource]> = [
    ['百度新闻', $r('app.media.mine_selected')],
    ['澎湃新闻', $r('app.media.mine2_selected')],
    ['鸿蒙', $r('app.media.mine3_selected')]
  ];
  build() {
    Column() {
      WebTabs({
        WebUrl: this.tabs,
        names: this.names,
        barMode: "fixed",
        tabController: this.WebController,
        tabStyle: {
          indicatorWidthWrapTab: true,
          fontColorSelect: Color.Blue
        },
        onWebTabIndicatorBuilder: () => {
          this.TabIndicator()
        },
        onWebTabBarBuilder: (tab, index) => {
          this.TabItem(tab, index)
        }
      })
    }
  }

  @Builder
  TabIndicator(){
    Stack().width('100%').height('100%')
      .backgroundColor(Color.Pink).borderRadius(12)
  }

  @Builder
  TabItem(tab:[string, Resource],index:number){
    Column(){
      Image(tab[1]).width(20).margin({bottom:4})
      Text(tab[0])
        .fontColor(this.WebController.selectedTabIndex == index ? Color.Black : Color.Gray)
        .fontWeight(this.WebController.selectedTabIndex == index ? FontWeight.Medium : FontWeight.Normal)
        .fontSize(this.WebController.selectedTabIndex == index ? 18 : 16)
        .animation({ duration: 300 })
    }
  }
}






// @Component
// struct ArticleSkeletonView {
//   build() {
//     Row() {
//       Column() {
//         textArea(80, 80)
//       }
//       .margin({ right: 20 })
//
//       Column() {
//         textArea('60%', 20)
//         textArea('50%', 20)
//       }
//       .alignItems(HorizontalAlign.Start)
//       .justifyContent(FlexAlign.SpaceAround)
//       .height('100%')
//     }
//     .padding(20)
//     .borderRadius(12)
//     .backgroundColor('#FFECECEC')
//     .height(120)
//     .width('100%')
//     .justifyContent(FlexAlign.SpaceBetween)
//   }
// }


// @Builder
// function textArea(width: number | Resource | string = '100%', height: number | Resource | string = '100%') {
//   Row()
//     .width(width)
//     .height(height)
//     .backgroundColor('#FFF2F3F4')
// }


// Column() {
//   ForEach(this.simpleList, (item: number) => {
//     ArticleSkeletonView()
//       .margin({ top: 20 })
//   }, (item: number) => item.toString())
// }
// .width('100%')
// .opacity(this.listOpacity)
// .onAppear(() => {
//   this.startAnimation();
// })

// startAnimation(): void {
//   animateTo(CommonConstants.SKELETON_ANIMATION, () => {
//     this.listOpacity = CommonConstants.HALF_OPACITY;
//   });
// }

// aboutToAppear(): void {
//   mydata.pushData(mybusinessNode)
//   mydata.pushData(mybusinessNode)
// }

// let mybusinessNode: myNodeController | undefined = undefined
// interface CommonConstantsType {
//   SKELETON_ANIMATION:  AnimateParam;
//   HALF_OPACITY: number;
// }

// const animationParams: AnimateParam = {
//   duration: 1000,             // 动画持续时间为2秒
//   tempo: 1.2,                // 使用默认速度
//   curve: Curve.EaseOut,      // 使用ease-out曲线
//   delay: 0,                  // 无延迟
//   iterations: 3,            // 无限次播放，循环播放
//   playMode: PlayMode.Normal, // 正常播放模式
// };

// const CommonConstants: CommonConstantsType = {
//   SKELETON_ANIMATION: animationParams,
//   HALF_OPACITY: 0,
// };

// todo: 搞一个离线渲染的web组件用于加载所有内容
// 找简单的网页
//lazyforeach
// 高负载场景下分针渲染
//全局自定义组件复用实现
//多线程优化
//组件复用

//import { webview } from '@kit.ArkWeb';
//import { displaySync } from '@kit.ArkGraphics2D';
// export let webviewController2: webview.WebviewController = new webview.WebviewController();
// export let webviewController3: webview.WebviewController = new webview.WebviewController();