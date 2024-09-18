/**
 * 描述：自定义组件{ListTabs} 配置文件
 * 时间：2024/7/3
 **/
import { assign } from './assign'

export interface ListTabsConfig {
  /**
   * 宽度 默认：'20%'
   */
  itemWidth?: Length
  /**
   * 高度 默认：38
   */
  itemHeight?: Length
  /**barPosition
   * 外边距
   */
  itemMargin?: Margin
  /**
   * 内边距
   */
  itemPadding?: Padding
  /**
   * 字体大小 默认：16
   * 注：自定义布局无效
   */
  fontSize?: Length
  /**
   *  最大支持行数
   * 注：自定义布局无效
   */
  maxLines?: number
  /**
   * 文本溢出位置 默认 TextOverflow.Ellipsis
   * 注：自定义布局无效
   */
  textOverflow?: TextOverflow
  /**
   * 未选中字体颜色 默认：#182431
   */
  fontDefColor?: ResourceColor
  /**
   * 选中字体颜色 默认：#007DFF
   */
  fontSelectColor?: ResourceColor
  /**
   * 字体位置 默认：TextAlign.Center
   */
  textAlign?: TextAlign
  /**
   * 未选中字体加粗 默认:400
   */
  fontDefWeight?: number | FontWeight | string
  /**
   * 选中字体加粗 默认：600
   */
  fontSelectWeight?: number | FontWeight | string
  /**
   * 线的宽度 默认：20线的宽度 默认：20
   */
  indicatorWidth?:Length
  /**
   * 线的高度 默认：2
   */
  indicatorHeight?: Length
  /**
   * 下划线顶部外边距 默认：空
   */
  indicatorMarginTop?: Length
  /**
   * 下划线底部外边距
   * 默认：2
   */
  indicatorMarginBottom?: Length
  /**
   * 线的圆角 默认：50
   */
  borderRadius?: Length | BorderRadiuses
  /**
   * 线颜色 默认#007DFF
   */
  lineColor?: ResourceColor
  /**
   * 页面切换到尾部时，滚动对齐方式 默认：ScrollAlign.END
   *  StartAndEndAuto:向右滑动采用ScrollAlign.END，向左滑动ScrollAlign.START
   */
  scrollAlign?: ScrollAlign
  /**
   * 动画执行时长 默认：300
   */
  animationDuration?: number
  /**
   * 收否显示下划线 默认显示
   */
  isShowLine?: boolean
  /**
   * 预加载个数
   */
  cachedCount?: number
  /**
   * 禁止组件滑动（content布局滑动）
   * 默认不禁止
   */
  disableSwipe?: boolean
  /**
   * List滑动监听
   * @param scrollOffset
   * @param scrollState
   */
  onScroll?: (scrollOffset: number, scrollState: ScrollState) => void
  /**
   * 滑动开始监听
   */
  onScrollStart?: () => void
  /**
   * 滑动结束监听
   */
  onScrollStop?: () => void
  /**
   * 页面切换
   * @param index 角标
   */
  onChange?: (index: number) => void
}
/**
 * 获取默认API(非全部属性，如需要别的属性，可在上方查看{ ListTabsConfig } 目前是否支持 )
 * 可在此基础修改属性
 * 例如
 * const config=getConfig({
 * @param newConfig
 * @returns
 * itemWidth='30%',
 * itemHeight=45
 * @param newConfig
 * @returns
 * })
 * @param newConfig 修改或添加属性
 * @returns
 */
export function getConfig(newConfig?: ListTabsConfig): ListTabsConfig {
  let config: ListTabsConfig = {
    /**
     * 宽度 默认：'20%'
     */
    itemWidth: '20%',
    /**
     * 高度 默认：38 （不包含下划线高度）
     */
    itemHeight: 38,

    /**
     * 字体大小 默认：16
     * 注：自定义布局无效
     */
    fontSize: 16,
    /**
     * 最大支持行数 默认：1
     * 注：自定义布局无效
     */
    maxLines: 1,
    /**
     * 文本溢出  默认：TextOverflow.Ellipsis
     * 注：自定义布局无效
     */
    textOverflow: TextOverflow.Ellipsis,
    /**
     * 未选中字体颜色 默认：#182431
     */
    fontDefColor: '#182431',
    /**
     * 选中字体颜色 默认：#007DFF
     */
    fontSelectColor: '#007DFF',
    /**
     * 字体位置 默认：TextAlign.Center
     */
    textAlign: TextAlign.Center,
    /**
     * 未选中字体加粗 默认:400
     */
    fontDefWeight: 400,
    /**
     * 选中字体加粗 默认：600
     */
    fontSelectWeight: 600,
    /**
     * 线的宽度 默认：20
     */
    indicatorWidth: 20,
    /**
     * 线的高度 默认：2
     */
    indicatorHeight: 2,
    /**
     * 下划线底部外边距
     * 默认：2
     */
    indicatorMarginBottom: 2,
    /**
     * 线的圆角 默认：1
     */
    borderRadius: 1,
    /**
     * 线颜色 默认#007DFF
     */
    lineColor: '#007DFF',
    /**
     * 是否显示下划线
     */
    isShowLine: true,
    /**
     * 页面切换到尾部时，滚动对齐方式 默认：ScrollAlign.END
     *  StartAndEndAuto:向右滑动采用ScrollAlign.END，向左滑动ScrollAlign.START
     */
    scrollAlign: ScrollAlign.END,
    /**
     * 动画执行时长 默认：300
     */
    animationDuration: 300,
  }
  if (newConfig && config != newConfig) {
    //合并两个对象，重复的会被newConfig覆盖
    console.log(JSON.stringify(assign(config, newConfig)))
    return assign(config, newConfig)
  }
  return config
}