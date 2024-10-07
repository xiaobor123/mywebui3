import { WebTabController } from './WebTabController'
import {MyDataSource } from './imple_idata'
import { webview } from '@kit.ArkWeb';
import {getCommonWeb,myNodeController,createCommonWeb} from './WebRendering'

export type BarMode = "scroll" | "fixed"
export let mydata: MyDataSource = new MyDataSource();
export let uicontext:UIContext
export let myWebUrl: string[]=[
  'https://m.baidu.com/',
  'https://m.thepaper.cn/',
  'https://www.openharmony.cn/'
]

@ComponentV2
export struct WebTabs {
  @Param @Require WebUrl: string[]
  @Param @Require names: Array<[string, Resource]>
  @Event onChange: (index: number) => void
  @Param tabStyle: MyTabStyle = {}
  @Param barMode: BarMode = "scroll"
  @Local webviewController1: webview.WebviewController = new webview.WebviewController();
  @BuilderParam onWebTabBarBuilder?: (tab: [string, Resource], index: number) => void
  @BuilderParam onWebTabIndicatorBuilder?: CustomBuilder
  @Param tabController: WebTabController = new WebTabController()

  aboutToAppear(): void {
    myWebUrl=this.WebUrl
    this.tabController.show(this.WebUrl, this.barMode, this.tabStyle)
    this.tabController.animatorDuration = this.tabStyle.animationDuration ?? 300
    webview.WebviewController.prepareForPageLoad('https://m.baidu.com/', true, 2);
    uicontext=this.getUIContext()
    createCommonWeb(myWebUrl[0],this.getUIContext(),this.webviewController1);
  }

  @Monitor("WebUrl")
  onTabsChange() {
    this.tabController.show(this.WebUrl, this.barMode, this.tabStyle)
  }

  @Monitor("tabController.selectedTabIndex")
  onTabIndexChange(monitor: IMonitor) {
    const index = monitor.value("tabController.selectedTabIndex")?.now as number
    this.onChange?.(index)
  }

  build() {
    Column(){
      Stack() {
        //指示器
        if (this.tabStyle.showIndicator ?? true) {
          Stack({ alignContent: this.tabStyle.indicatorAlignment ?? Alignment.Bottom }) {
            if (this.onWebTabIndicatorBuilder) {
              this.onWebTabIndicatorBuilder()
            } else {
              this.TabIndicatorBuilder()
            }
          }
          .padding(this.tabStyle.indicatorPadding ?? 0)
          .width(this.tabController.indicatorWidth)
          .height('100%')
          .position({
            left: this.tabController.indicatorOffset - this.tabController.indicatorWidth / 2, bottom: 0
          })
        }

        Scroll(this.tabController.tabScroller) {
          Row() {
            ForEach(this.names, (item: [string, Resource], index: number) => {

              Stack({ alignContent: Alignment.Center }) {
                if (this.onWebTabBarBuilder) {
                  this.onWebTabBarBuilder(item, index)
                } else {
                  this.TabItemBuilder(item, index)
                }
              }
              .width(this.tabController.tabItemWidth[index])
              .layoutWeight(this.barMode == "fixed" ? 1 : 0)
              .onClick(() => {
                this.tabController.selectedTabIndex = index
              })
            })
          }.onAreaChange((_, area) => {
            this.tabController.updateTabScrollArea(area)
          }).height('100%')
        }
        .onAreaChange((_, area) => {
          this.tabController.updateTabContainerArea(area, this.barMode)
        })
        .scrollable(ScrollDirection.Horizontal)
        .scrollBar(BarState.Off)
        .onTouch(event => {

          if (event.type == TouchType.Move) {
            this.tabController.indicatorAnimator?.cancel()
          }

        })
        .onDidScroll(() => {
          const offset = this.tabController.tabScroller.currentOffset().xOffset
          if (!this.tabController.tabIsAnimator) {
            const tabWidth = this.tabController.tabItemWidth
            const locationX = sumOfFirstN(tabWidth, this.tabController.selectedTabIndex) +
              tabWidth[this.tabController.selectedTabIndex] / 2
            this.tabController.indicatorOffset = locationX - offset
          }
        })
      }
      .width('100%')
      .height(this.tabStyle.barHeight ?? 50)
      .alignContent(Alignment.Start)

      this.MySwiper(this.tabController)
    }

  }


  @Builder
  MySwiper(tabController: WebTabController){
    Swiper(tabController.swiperController) {
      Stack() {
        NodeContainer(getCommonWeb('https://m.baidu.com/'))
          .height('100%')
          .width('100%')
      }

      LazyForEach(mydata, (item: myNodeController | undefined) => {
        Stack() {
          NodeContainer(item)
            .height('90%')
            .width('100%')
        }
        .width('100%').height('100%')
      }, (item: string) => item)
    }.layoutWeight(1)
    .onAreaChange((oldValue, newValue) => {
      tabController.swiperOnAreaChange(oldValue, newValue)
    })
    .onAnimationStart((index, targetIndex, extraInfo) => {
      tabController.swiperOnAnimationStart(index, targetIndex, extraInfo)
    })
    .onGestureSwipe((index, extraInfo) => {
      tabController.swiperOnGestureSwipe(index, extraInfo)
    })
    // .indicator(false)
  }


  @Builder
  TabItemBuilder(tab: [string, Resource], index: number) {
    Text(tab[0])
      .fontColor((this.tabController.selectedTabIndex == index ? this.tabStyle.fontColorSelect :
      this.tabStyle.fontColorNormal) ?? this.tabStyle.fontColor)
      .fontWeight((this.tabController.selectedTabIndex == index ? this.tabStyle.fontWeightSelect :
      this.tabStyle.fontWeightNormal) ?? this.tabStyle.fontWeight)
      .fontSize((this.tabController.selectedTabIndex == index ? this.tabStyle.fontSizeSelect :
      this.tabStyle.fontSizeNormal) ?? this.tabStyle.fontSize)
      .animation({ duration: this.tabStyle.animationDuration ?? 300 })
  }

  @Builder
  TabIndicatorBuilder() {
    Stack()
      .width(this.tabStyle.indicatorWidthWrapTab ? '100%' : this.tabStyle.indicatorWidth ?? 25)
      .height(this.tabStyle.indicatorHeight ?? 4)
      .margin(this.tabStyle.indicatorMargin ?? 4)
      .backgroundColor(this.tabStyle.indicatorColor ?? Color.Orange)
      .borderRadius(this.tabStyle.indicatorRadius ?? 2)
  }
}


function sumOfFirstN(numbers: number[], N: number): number {
  // 检查N是否超过数组的长度
  if (N > numbers.length) {
    N = numbers.length;
  }

  // 计算前N个数的和
  let sum = 0;
  for (let i = 0; i < N; i++) {
    sum += numbers[i];
  }

  return sum;
}

export interface MyTabStyle {
  fontSize?: number,
  fontColor?: ResourceColor,
  fontWeight?: FontWeight,
  fontSizeNormal   ?: number
  fontSizeSelect   ?: number
  fontColorSelect  ?: ResourceColor
  fontColorNormal  ?: ResourceColor
  fontWeightNormal  ?: FontWeight
  fontWeightSelect ?: FontWeight
  //指示器
  showIndicator?: boolean
  indicatorWidth   ?: number
  indicatorHeight?: number
  indicatorPadding?: number | Padding
  indicatorMargin?: number | Padding
  indicatorColor?: ResourceColor
  indicatorRadius?: number
  indicatorAlignment?: Alignment
  //如果为true指示器宽度自适应tab宽度，false则以indicatorWidth为准
  indicatorWidthWrapTab?: boolean
  //Tabs高度，默认50
  barHeight?: number,

  //Tab Item 左右padding
  tabItemPadding?: number,
  animationDuration?: number
}
