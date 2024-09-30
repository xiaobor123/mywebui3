
import { webview } from '@kit.ArkWeb';
import {TabsExample, tabPage, tabItemContent, TabPageType} from 'supfast'


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
      TabsExample({
        tabsController:this.tabsController,
        tabPages:[
          new tabPage(TabPageType.Web,"https://m.baidu.com"),
          new tabPage(TabPageType.Web,"https://app.people.cn"),
          new tabPage(TabPageType.Web,"https://news.baidu.com")
        ],
        tabContents: [
          {normalText:"hi"},
          {normalText:"HHH",selectedText:"oooo",normalImg:$r('app.media.home_selected')},
          {normalText:"gg",normalImg:$r('app.media.mine2_selected'),selectedImg:$r('app.media.mine2_normal')}
        ],
        tabStyle:{
          imgSize: {width:30,height:30},
          barHeight: 60,
          //fontWeightSelect: FontWeight.Bold,
          fontWeight: FontWeight.Lighter,
          barPosition: BarPosition.End

        },
        pageBuilder: this.xxx


      })
    }
  }

}
