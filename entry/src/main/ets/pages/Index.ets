
import { webview } from '@kit.ArkWeb';
import {WebTab, tabPage, tabItemContent, TabPageType} from 'supfast'


class newI extends tabPage{
  x: string=""
}

@Entry
@Component
struct Index {
  @State currentIndex: number = 0;
  private tabsController: TabsController = new TabsController();
  private webviewController1: webview.WebviewController = new webview.WebviewController();
  aboutToAppear(): void {
    webview.WebviewController.prepareForPageLoad('https://m.baidu.com/', true, 2);
  }
  @Builder xxx(item:tabPage, index: number){
    Column(){
      Text('hello')
    }
  }


  build() {
    Column(){
      WebTab({
        tabsController:this.tabsController,
        tabPages:[
          new tabPage(TabPageType.Web,"https://m.baidu.com"),
          new tabPage(TabPageType.Web,"https://m.thepaper.cn/"),
          new tabPage(TabPageType.Web,"https://www.openharmony.cn/")
        ],
        tabContents: [
          {normalText:"hi"},
          {normalText:"HHH",selectedText:"oooo",normalImg:$r('app.media.home_selected')},
          {normalText:"gg",normalImg:$r('app.media.mine2_selected'),selectedImg:$r('app.media.mine2_normal')}
        ],
        tabStyle:{
          imgSize: {width:20,height:20},
          barHeight: 30,
          fontWeight: FontWeight.Lighter,
          barPosition: BarPosition.Start

        },
        pageBuilder: this.xxx


      })
    }
  }

}
