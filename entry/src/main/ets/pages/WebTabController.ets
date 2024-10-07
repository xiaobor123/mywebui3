import { Animator, AnimatorResult } from '@kit.ArkUI'
import measure from '@ohos.measure'
import { BarMode, MyTabStyle } from './WebTab'

@ObservedV2
export class WebTabController {
  @Trace selectedTabIndex: number = 0//当前选中的Tab Index
  @Trace indicatorOffset: number = 0//控制指示器当前位置
  @Trace indicatorWidth: number = 0
  private tabContainerArea?: Area
  private tabScrollArea?: Area
  private swiperArea?: Area
  private tabCount: number = 0
  @Trace tabItemWidth: number[] = []  //每一个TabItem的宽度
  tabScroller = new Scroller()
  swiperController = new SwiperController()
  animatorDuration: number = 300
  indicatorAnimator?: AnimatorResult
  private animWhenIndexChange: boolean = true

  swiperOnGestureSwipe(index: number, event: SwiperAnimationEvent) {
    this.indicatorAnimator?.cancel()
    let currentOffset: number = event.currentOffset
    let contentWidth: number = this.swiperArea?.width as number
    let currentRatio: number = Math.abs(currentOffset / contentWidth)
    let targetIndex = index
    if (currentOffset < 0) {
      if (this.isIndexValid(targetIndex + 1)) {
        targetIndex++
      }
    } else if (currentOffset > 0) {
      if (this.isIndexValid(targetIndex - 1)) {
        targetIndex--
      }
    }

    const current = sumOfFirstN(this.tabItemWidth, index) + this.tabItemWidth[index] / 2

    const targetWidth = sumOfFirstN(this.tabItemWidth, targetIndex) + this.tabItemWidth[targetIndex] / 2
    const space = targetWidth - current

    this.indicatorOffset = current + space * currentRatio - this.tabScroller.currentOffset().xOffset
    this.indicatorWidth =
      this.tabItemWidth[index] + (this.tabItemWidth[targetIndex] - this.tabItemWidth[index]) * currentRatio

  }

  private isIndexValid(index: number): boolean {
    return index >= 0 && index < this.tabCount;
  }

  swiperOnAnimationStart(index: number, targetIndex: number, extraInfo: SwiperAnimationEvent) {
    if (index == targetIndex) {
      this.animationToIndex(targetIndex)
    } else {
      this.selectedTabIndex = targetIndex
    }
  }

  swiperOnAnimationEnd(index: number, extraInfo: SwiperAnimationEvent) {
    // doSomething
  }

  swiperOnAreaChange(oldArea: Area, newArea: Area) {
    this.swiperArea = newArea
  }

  //更新Tab ContainerArea
  updateTabContainerArea(area: Area, barMode: BarMode) {
    this.tabContainerArea = area

    if (barMode == "fixed") {
      this.tabItemWidth.length = this.tabCount
      const itemWidth = (area.width as number) / this.tabCount
      this.tabItemWidth.fill(itemWidth)

      const offset = this.tabScroller.currentOffset()?.xOffset ?? 0
      this.indicatorOffset =
        sumOfFirstN(this.tabItemWidth, this.selectedTabIndex) + this.tabItemWidth[this.selectedTabIndex] / 2 - offset
      this.indicatorWidth = this.tabItemWidth[this.selectedTabIndex]
    }

  }

  //更新Tab 滚动组件Scroll Area
  updateTabScrollArea(area: Area) {
    this.tabScrollArea = area
  }

    show(tabs: string[], barMode: BarMode, tabStyle: MyTabStyle) {
    this.tabItemWidth = []
    this.tabCount = tabs.length

    if (barMode == "fixed") {
      return
    }

    tabs.forEach(v => {
      const tabWidth = measure.measureText({
        textContent: v,
        fontSize: 18,
        fontWeight: FontWeight.Medium
      })

      this.tabItemWidth.push(px2vp(tabWidth) + (tabStyle.tabItemPadding ?? 6) * 2)
    })

    if (this.selectedTabIndex >= tabs.length) {
      this.animWhenIndexChange = false
      this.selectedTabIndex = 0
    }

    const offset = this.tabScroller.currentOffset()?.xOffset ?? 0
    this.indicatorOffset =
      sumOfFirstN(this.tabItemWidth, this.selectedTabIndex) + this.tabItemWidth[this.selectedTabIndex] / 2 - offset
    this.indicatorWidth = this.tabItemWidth[this.selectedTabIndex]
  }


  /**
   * 指示器和Tab滚动到指定Index
   * @param index
   */
  private animationToIndex(index: number) {
    if (this.tabScrollArea == null || this.tabContainerArea == null) {
      return
    }

    this.tabIsAnimator = true

    //tab中间位置
    const centerX = this.tabContainerArea.width as number / 2
    const maxScrollWidth = (this.tabScrollArea.width as number) - (this.tabContainerArea.width as number)
    const tabCenterX = sumOfFirstN(this.tabItemWidth, index) + this.tabItemWidth[index] / 2

    //scroller需要滚动到的位置
    const offset = Math.min(Math.max(0, tabCenterX - centerX), maxScrollWidth)

    //tab滚动到中间位置
    this.tabScroller.scrollTo({
      xOffset: offset, yOffset: 0, animation: {
        duration: this.animatorDuration
      }
    })

    const startOffset = this.indicatorOffset
    const endOffset = sumOfFirstN(this.tabItemWidth, index) + this.tabItemWidth[index] / 2 - offset

    const startWidth = this.indicatorWidth
    const endWidth = this.tabItemWidth[index]

    this.indicatorAnimator = Animator.create({
      duration: this.animatorDuration,
      easing: "linear",
      delay: 0,
      fill: "forwards",
      direction: "normal",
      iterations: 1,
      begin: 0,
      end: 1
    })

    this.indicatorAnimator.onFrame = (progress) => {
      this.indicatorWidth = startWidth + (endWidth - startWidth) * progress
      this.indicatorOffset = startOffset + (endOffset - startOffset) * progress
    }

    this.indicatorAnimator.onFinish = () => {
      this.tabIsAnimator = false
    }
    this.indicatorAnimator.onCancel = () => {
      this.tabIsAnimator = false
    }

    this.indicatorAnimator.play()
  }

  tabIsAnimator = false

  @Monitor("selectedTabIndex")
  selectedTabIndexChange(monitor: IMonitor) {
    const index = monitor.value("selectedTabIndex")?.now as number
    this.swiperController.changeIndex(index, true)
    if (this.animWhenIndexChange) {
      this.animationToIndex(index)
    } else {
      this.animWhenIndexChange = true
    }
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
