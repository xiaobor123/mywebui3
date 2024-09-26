import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { webview } from '@kit.ArkWeb';
import {createNWeb} from "../pages/common";

const localStorage: LocalStorage = new LocalStorage('uiContext');

export default class EntryAbility extends UIAbility {
  storage: LocalStorage = localStorage;
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam) {
    console.info('EntryAbility onCreate');
    // 初始化 Web 引擎s
    webview.WebviewController.initializeWebEngine();
    // 将网址替换为百度，并进行预连接
    webview.WebviewController.prepareForPageLoad('https://m.baidu.com/', true, 2);
    //webview.WebviewController.prepareForPageLoad('http://www.people.com.cn/', true, 2);
    webview.WebviewController.prepareForPageLoad('https://www.thepaper.cn/', true, 2);
    //webview.WebviewController.prepareForPageLoad('https://news.sina.com.cn/', true, 2);
    // 存储要传递的参数
    AppStorage.setOrCreate('abilityWant', want);
    console.info('EntryAbility onCreate done');
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    windowStage.loadContent('pages/Index', this.storage, (err, data) => {
      // 创建ArkWeb动态组件（需传入UIContext），loadContent之后的任意时机均可创建
      //createNWeb('https://m.baidu.com/','http://www.people.com.cn/');
      //createNWeb('http://www.people.com.cn/','https://www.thepaper.cn/', windowStage.getMainWindowSync().getUIContext());
      //createNWeb('https://www.thepaper.cn/','https://news.sina.com.cn/');
      //createNWeb('https://news.sina.com.cn/','https://news.sina.com.cn/' , windowStage.getMainWindowSync().getUIContext());
      this.storage.setOrCreate<UIContext>("uiContext", windowStage.getMainWindowSync().getUIContext());
      if (err.code) {
        return;
      }
    });
    /*hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
    });*/
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}

