/**
 * 描述：仿Android TabLayout+ViewPager
 * 时间：2024/7/2
 **/
import { ComponentUtils } from '@ohos.arkui.UIContext'
import { getConfig, ListTabsConfig } from './ListTabsConfig'
import { display } from '@kit.ArkUI'

export interface Tab {
  _name: string
}

@Component
export struct ListTabs {
  //当前选中的Index
  @State currentIndex: number = 0
  //titleBar位置
  @State barPosition: ItemAlign = ItemAlign.Center
  //配置文件
  @Prop @Watch('onConfigChange') tabsConfig: ListTabsConfig
  @Link
  titles: Array<Tab>
  /**
   * 解决一个页面使用多个ListTabs控件 id属性重复问题
   * 注：当一个页面使用多个ListTabs时 idTag为必传 用于防止id重复，导致位置计算错误
   */
  @Prop
  idTag: string
  @BuilderParam titleBar: <T = Tab>(tab: T, index: number) => void = this.tabBuilder
  @BuilderParam content: <T = Tab>(tab: T, index: number) => void
  //指示器距离左侧的边距
  @State
  private indicatorLeftMargin: number = 0
  //指示器的宽度
  @State
  private indicatorWidth: number = 0
  //ListTabs宽度
  private tabsWidth: number = 0
  private componentUtils: ComponentUtils = this.getUIContext().getComponentUtils()
  private listController = new Scroller()
  @State
  private config: ListTabsConfig = getConfig()
  /**
   * 记录滑动状态
   */
  private isScroll: boolean = false
  /**
   * 记录滑动对齐方式
   */
  private scrollAlign = ScrollAlign.END
  @State
  private lineWidth:number=0
  onConfigChange() {
    this.config = getConfig(this.tabsConfig)
  }

  aboutToAppear(): void {
    this.config = getConfig(this.tabsConfig)

  }

  @Builder
  tabBuilder<T = Tab>(tab: T, index: number) {
    Text((tab as Tab)._name)
      .fontSize(this.config.fontSize)
      .fontColor(this.currentIndex === index ? this.config.fontSelectColor : this.config.fontDefColor)
      .fontWeight(this.currentIndex === index ? this.config.fontSelectWeight : this.config.fontDefWeight)
      .width('auto')
      .textAlign(this.config.textAlign)
      .height('auto')
      .maxLines(this.config.maxLines)
      .textOverflow({ overflow: TextOverflow.Ellipsis })
  }

  build() {
    Column() {
      this.titleListBuilder()
      Swiper() {
        ForEach(this.titles, (val: Tab, index) => {
          if (this.content) {
            this.content(val, index)
          } else {
            Column() {
              Text('请传入内容布局')
            }.width('100%').height('100%')
            .justifyContent(FlexAlign.Center)
          }
        })
      }
      .onAnimationStart((_: number, targetIndex: number, __: TabsAnimationEvent) => {
        // 切换动画开始时触发该回调。下划线跟着页面一起滑动，同时宽度渐变。
        let targetIndexInfo = this.getTextInfo(targetIndex)
        this.startAnimateTo(this.config.animationDuration, targetIndexInfo.left, targetIndexInfo.width)
      })
      .onAnimationEnd((index: number, event: TabsAnimationEvent) => {
        // 切换动画结束时触发该回调。下划线动画停止。
        let currentIndicatorInfo = this.getCurrentIndicatorInfo(index, event)
        this.startAnimateTo(0, currentIndicatorInfo.left, currentIndicatorInfo.width)
      })
      .onGestureSwipe((index: number, event: TabsAnimationEvent) => {
        //解决list滑动动画未完成，直接进行手势滑动时，布局跳动问题
        if (this.isScroll) {
          this.listController.scrollToIndex(this.currentIndex, false, this.scrollAlign)
          return
        }
        //如果 animationDuration为空或者 等于0 证明不需要动画 取消手势跟随
        if (!this.config.animationDuration || this.config.animationDuration == 0) {
          return
        }
        // 在页面跟手滑动过程中，逐帧触发该回调。
        let currentIndicatorInfo = this.getCurrentIndicatorInfo(index, event)
        this.indicatorLeftMargin = currentIndicatorInfo.left
        this.indicatorWidth = currentIndicatorInfo.width
      })
      .indicator(false)
      .effectMode(EdgeEffect.None)
      .cachedCount(this.config.cachedCount)
      .disableSwipe(this.config.disableSwipe)
      .index(this.currentIndex)
      .loop(false)
      .indicator(false)
      .layoutWeight(1)
      .onChange((index) => {
        this.currentIndex = index
        this.listController.scrollToIndex(index, true, this.config.scrollAlign)
        if (this.config.onChange) {
          this.config.onChange(index)
        }
      })
    }.width('100%')
    .height('auto')
    .alignItems(HorizontalAlign.Start)
    .justifyContent(FlexAlign.End)

  }

  @Builder
  titleListBuilder() {
    Row() {
      List({ initialIndex: this.currentIndex, scroller: this.listController }) {
        ForEach(this.titles, (val: Tab, index) => this.listItem(val, index))
      }
      .height(this.config.itemHeight)
      .width('auto')
      .onAreaChange((_: Area, newValue: Area) => {
        let width = Number.parseFloat(newValue.width.toString())
        this.tabsWidth = Number.isNaN(width) ? 0 : width
        //解决第一次进入时测量失败问题，重新校正
        if (this.indicatorLeftMargin <= 0 || this.indicatorWidth <= 0
          || this.indicatorLeftMargin > px2vp(display.getDefaultDisplaySync().width)
          || this.indicatorWidth >= px2vp(display.getDefaultDisplaySync().width)) {
          let targetIndexInfo = this.getTextInfo(this.currentIndex)
          this.indicatorLeftMargin = targetIndexInfo.left
          this.indicatorWidth = targetIndexInfo.width
        }
      })
      .onDidScroll((scrollOffset: number, scrollState: ScrollState) => {
        //滑动时动态设置线位置
        let targetIndexInfo = this.getTextInfo(this.currentIndex)
        this.indicatorLeftMargin = targetIndexInfo.left
        this.indicatorWidth = targetIndexInfo.width
        //添加滑动监听
        if (this.config.onScroll) {
          this.config.onScroll(scrollOffset, scrollState)
        }
      })
      .onScrollStart(() => {
        this.isScroll = true
        //滑动开始监听
        if (this.config.onScrollStart) {
          this.config.onScrollStart()
        }
      })
      .onScrollStop(() => {
        this.isScroll = false
        //滑动结束监听
        if (this.config.onScrollStop) {
          this.config.onScrollStop()
        }
      })
      .scrollBar(BarState.Off)
      .listDirection(Axis.Horizontal)
    }.alignSelf(this.barPosition)

    if (this.config.isShowLine) {
      Column()
        .height(this.config.indicatorHeight)
        .width(this.lineWidth>this.tabsWidth?20:this.lineWidth)
        .borderRadius(this.config.borderRadius)
        .margin({
          left: this.indicatorLeftMargin + this.indicatorWidth / 2 - this.lineWidth/2,
          top: this.config.indicatorMarginTop,
          bottom: this.config.indicatorMarginBottom
        })
        .backgroundColor(this.config.lineColor)
    }

  }

  @Builder
  listItem<T = Tab>(val: T, index: number) {
    ListItem() {
      if (this.titleBar) {
        this.titleBar(val, index)
      }
    }
    .height(this.config.itemHeight)
    .width(this.config.itemWidth)
    .margin(this.config.itemMargin)
    .padding(this.config.itemPadding)
    .onClick(() => {
      //点击切换index 并执行动画
      this.currentIndex = index
      let targetIndexInfo = this.getTextInfo(index)
      this.startAnimateTo(this.config.animationDuration, targetIndexInfo.left, targetIndexInfo.width)
    })
    .onAreaChange((_: Area, newValue: Area) => {
      //计算当前Item宽度和距离左侧的距离
      if (this.currentIndex === index && (this.indicatorLeftMargin === 0 || this.indicatorWidth === 0)) {
        if (newValue.position.x != undefined) {
          let positionX = Number.parseFloat(newValue.position.x.toString())
          this.indicatorLeftMargin = Number.isNaN(positionX) ? 0 : positionX
        }
        let width = Number.parseFloat(newValue.width.toString())
        this.indicatorWidth = Number.isNaN(width) ? 0 : width
        if (this.config.indicatorWidth==='auto'){
          this.lineWidth=width
        }else if (typeof this.config.indicatorWidth === 'number'){
          this.lineWidth=(this.config.indicatorWidth??0)>width?width :this.config.indicatorWidth
        }else {
          try {
            let lineWidth:number= getContext(this).resourceManager.getNumber(this.config.indicatorWidth as Resource)
            this.lineWidth=lineWidth
          } catch (e) {
            console.error('tabs_error:','资源文件获取失败，请检查资源文件是否存在于当前模块')
          }

        }
      }
    })
    .id(this.getViewId(index))
  }

  /**
   * 根据ViewId 获取View位置
   * @param index
   * @returns
   */
  private getTextInfo(index: number): Record<string, number> {
    let rectangle = this.componentUtils.getRectangleById(this.getViewId(index))
    return { 'left': px2vp(rectangle.windowOffset.x), 'width': px2vp(rectangle.size.width) }
  }

  /**
   *  获取ViewId
   * @param index 角标
   * @param index
   * @returns
   * @returns
   */
  private getViewId(index: number) {
    return this.idTag + index.toString()
  }
  /**
   * 获取下划线当前的位置信息
   * @param index
   * @param event
   * @returns
   */
  private getCurrentIndicatorInfo(index: number, event: TabsAnimationEvent): Record<string, number> {
    let nextIndex = index
    if (index > 0 && event.currentOffset > 0) {
      nextIndex--
    } else if (index < this.titles.length - 1 && event.currentOffset < 0) {
      nextIndex++
    }
    let indexInfo = this.getTextInfo(index)
    let nextIndexInfo = this.getTextInfo(nextIndex)
    let swipeRatio = Math.abs(event.currentOffset / this.tabsWidth)
    let currentIndex = swipeRatio > 0.5 ? nextIndex : index // 页面滑动超过一半，tabBar切换到下一页。
    let currentLeft = indexInfo.left + (nextIndexInfo.left - indexInfo.left) * swipeRatio
    let currentWidth = indexInfo.width + (nextIndexInfo.width - indexInfo.width) * swipeRatio
    return { 'index': currentIndex, 'left': currentLeft, 'width': currentWidth }
  }
  /**
   * 执行动画
   * @param duration
   * @param leftMargin
   * @param width
   */
  private startAnimateTo(duration?: number, leftMargin?: number, width?: number) {
    animateTo({
      duration: duration, // 动画时长
      curve: Curve.Linear, // 动画曲线
      iterations: 1, // 播放次数
      playMode: PlayMode.Normal // 动画模式
    }, () => {
      this.indicatorLeftMargin = leftMargin ? leftMargin : 0
      this.indicatorWidth = width ? width : 0
    })
  }
}
