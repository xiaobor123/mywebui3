import web_webview from '@ohos.web.webview'

import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { webview } from '@kit.ArkWeb';
import {createNWeb, getNWeb} from './common'
import { ListTabs, Tab } from './ListTabs'
import { ListTabsConfig, getConfig } from './ListTabsConfig'

class Tab2 implements Tab {
  _name: string
  title:string
  url:string
  constructor(name: string,title:string,url:string) {
    this.title=title
    this._name = name
    this.url = url
  }
}

@Entry
@Component
struct TabsExample {
  @State
  title: Array<Tab2> = [
    new Tab2('百度新闻','页面1','https://news.baidu.com/'),
    new Tab2('京东','页面2','https://www.jd.com/'),
    new Tab2('淘宝','页面3','https://www.taobao.com/'),
    new Tab2('新浪新闻','页面4','https://news.sina.com.cn/'),
  ]

  config:ListTabsConfig=getConfig({
    itemWidth:'30%',
    lineColor:Color.Red,
    fontSelectColor:Color.Red,
    indicatorHeight:2,
    borderRadius:{bottomLeft:5,bottomRight:5},
    //indicatorWidth:$r('app.float.vp_20')
    indicatorWidth:40
  })

  build() {
    Column(){
      ListTabs({
        currentIndex:0,
        titles:this.title,
        content:(val,index):void=>this.content(val as Tab2,index),
        barPosition:ItemAlign.Start,
        tabsConfig:{
          itemHeight:28,
          fontSelectColor:Color.Brown,
          lineColor:Color.Red,
          indicatorWidth:20
        },
        idTag:'tab4'
      }).height('100%')
        .width('100%')
    }.height('100%')
    .width('100%')
    .justifyContent(FlexAlign.Start)
  }
  @Builder
  content(val:Tab2,index:number){
    Column(){
      NodeContainer(getNWeb(val.url))
        .height('90%')
        .width('100%')
    }
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height('100%')
  }
}