import { SlidingTabController } from './SlidingTabController'

//当前支持可滚动Tab和均分Tab
export type BarMode = "scroll" | "fixed"

/**
 * 高度可拓展的TabLayout
 * */

@ComponentV2
export struct SlidingTabs {
  @Param @Require tabs: string[]
  @Param @Require names: Array<[string, Resource]>
  @Event onChange: (index: number) => void
  @Param tabStyle: ITabStyle = {}
  @Param barMode: BarMode = "scroll"
  @BuilderParam onTabItemBuilder?: (tab: [string, Resource], index: number) => void
  @BuilderParam onTabIndicatorBuilder?: CustomBuilder
  @Param tabController: SlidingTabController = new SlidingTabController()

  aboutToAppear(): void {
    this.tabController.initTabChild(this.tabs, this.barMode, this.tabStyle)
    this.tabController.animatorDuration = this.tabStyle.animationDuration ?? 300
  }

  @Monitor("tabs")
  onTabsChange() {
    this.tabController.initTabChild(this.tabs, this.barMode, this.tabStyle)
  }

  @Monitor("tabController.selectedTabIndex")
  onTabIndexChange(monitor: IMonitor) {
    const index = monitor.value("tabController.selectedTabIndex")?.now as number
    this.onChange?.(index)
  }

  build() {
    Stack() {
      //指示器
      if (this.tabStyle.showIndicator ?? true) {
        Stack({ alignContent: this.tabStyle.indicatorAlignment ?? Alignment.Bottom }) {
          if (this.onTabIndicatorBuilder) {
            this.onTabIndicatorBuilder()
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
              if (this.onTabItemBuilder) {
                this.onTabItemBuilder(item, index)
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

export interface ITabStyle {
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
