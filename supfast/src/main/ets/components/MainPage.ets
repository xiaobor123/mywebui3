import web_webview from '@ohos.web.webview'

import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';

import { hiTraceMeter } from '@kit.PerformanceAnalysisKit';
import { webview } from '@kit.ArkWeb';
import {createNWeb, getNWeb} from './preparepage'
import {createCommonWeb, getCommonWeb} from './Common'
import { displaySync } from '@kit.ArkGraphics2D';
import {BasicDataSource,MyDataSource} from './imple_idata'
import {tabPage,tabItemContent,TabPageType} from './TabItem'
import { beforeEach } from '@ohos/hypium';



@Builder function CustomBuilder() :void{}
@ComponentV2
export struct WebTab {
  @Local currentIndex: number = 0;
  @Local webUrls: string[] = []
  @Param tabsController: TabsController = new TabsController()
  @Local swiperController: SwiperController = new SwiperController()
  @Param webList: string[] = []
  @Param tabStyle: TabStyle = {}
  @Param tabPages: tabPage[] = []
  @Param tabContents: tabItemContent[] = []
  @BuilderParam pageBuilder:(item: tabPage, index: number) => void = CustomBuilder
  private webviewController1: webview.WebviewController = new webview.WebviewController();
  private mydata: MyDataSource = new MyDataSource();
  @Builder TabBuilder(tabContent: tabItemContent, targetIndex : number) {

      Column() {
        if(this.tabStyle.showIcon ?? true){
          Image((tabContent.selectedImg && this.currentIndex === targetIndex) ? tabContent.selectedImg : tabContent.normalImg)
            .size(this.tabStyle.imgSize)
        }
        if(this.tabStyle.showText ?? true){
          Text((tabContent.selectedText && this.currentIndex === targetIndex) ? tabContent.selectedText : tabContent.normalText)
            .fontColor((this.currentIndex === targetIndex) ? this.tabStyle.fontColorSelect : this.tabStyle.fontColor)
            .fontSize((this.currentIndex === targetIndex) ? this.tabStyle.fontSizeSelect : this.tabStyle.fontSize)
            .fontWeight((this.currentIndex === targetIndex) ? this.tabStyle.fontWeightSelect ?? FontWeight.Bold : this.tabStyle.fontWeight)
        }

      }
      .width(50)
      .height('100%')
      .justifyContent(FlexAlign.Center)
      .onClick(() => {
        this.tabsController.changeIndex(targetIndex);
        this.swiperController.changeIndex(targetIndex)
        this.currentIndex = targetIndex;

      })



  }
  aboutToAppear(): void {
    createNWeb('https://xxx', this.getUIContext());

    for(const item of this.tabPages){
      webview.WebviewController.prepareForPageLoad(item.url, true, 2);
      this.mydata.pushData(item);
      createCommonWeb(item.url);
    }


  }
  build() {
      Column(){


        Swiper(this.swiperController){
          LazyForEach(this.mydata, (item: tabPage, index) => {
            if (item.type == TabPageType.Web) {
              NodeContainer(getCommonWeb(item.url))
                .height('90%')
                .width('100%')
            } else if (item.type == TabPageType.Normal) {
              Text(item.text)
            } else if (item.type == TabPageType.Custom){
              this.pageBuilder(item, index)
            }

          })
        }
        .onChange((index: number) => {
          this.currentIndex = index;
        })

        .onAnimationStart((index,targetIndex,extraInfo)=>{

          this.currentIndex = targetIndex
        })
        .height('90%')

        Stack(){
          Tabs({ barPosition: this.tabStyle.barPosition, controller: this.tabsController })
            .height(60)
            .backgroundColor(this.tabStyle.backgroundColor ?? '#f2f3f5')
            .onAnimationStart((index: number, targetIndex: number, event: TabsAnimationEvent) => {
              this.currentIndex = targetIndex
              // let targetIndexInfo = this.getTabItemCurViewInfo(targetIndex)
              // this.startAnimateTo(targetIndexInfo.indicatorLeft, targetIndexInfo.indicatorWidth)
            })

            .onChange((index: number) => {
              this.currentIndex = index;
            })


          Row(){
            ForEach(this.tabContents,(item: tabItemContent,index)=>{
              ListItem(){
                this.TabBuilder(item,index)
              }.height(60)

            })
          }
          .alignItems(VerticalAlign.Center)
          .justifyContent(FlexAlign.SpaceAround)
          .height(60)
          .width('100%')
        }


      }
      .reverse(true)


    }

}

export interface TabStyle {
  fontSize?: number,
  fontColor?: ResourceColor,
  fontWeight?: FontWeight,
  fontSizeSelect   ?: number
  fontColorSelect  ?: ResourceColor
  fontWeightSelect ?: FontWeight
  showIcon?: boolean
  showText?: boolean
  imgSize?: SizeOptions
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
  barHeight?: Length
  barWidth?: Length
  backgroundColor?: ResourceColor
  barPosition?: BarPosition
  tabBarIsTop?: boolean

  //Tab Item 左右padding
  tabItemPadding?: number
  animationDuration?: number
}
