import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';
import { webview } from '@kit.ArkWeb';
import systemDateTime from '@ohos.systemDateTime'

export  class TConfig {
  static url: string = 'https://m.baidu.com';
  static url2: string = 'https://m.thepaper.cn';
  static url3: string = 'https://www.openharmony.cn';
}

export default class EntryAbility extends UIAbility {
  static  EntryCreateTime: number = 0;
  static uiContext: UIContext;
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    // hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
    hilog.info(0x0001,'testTag','EntryAbility onCreate');
    EntryAbility.EntryCreateTime = systemDateTime.getTime(false)
    webview.WebviewController.initializeWebEngine();
    // 指定第二个参数为true，代表要进行预连接，如果为false该接口只会对网址进行DNS预解析
    webview.WebviewController.prepareForPageLoad(TConfig.url, true, 2);
    webview.WebviewController.prepareForPageLoad('https://m.thepaper.cn', true, 2);
    webview.WebviewController.prepareForPageLoad('https://www.openharmony.cn', true, 2);
    AppStorage.setOrCreate('abilityWant', want);
  }

  onDestroy(): void {
    // hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    // hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');
    windowStage.loadContent('pages/Index', (err) => {
      EntryAbility.uiContext = windowStage.getMainWindowSync().getUIContext();
      if (err.code) {
        // hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      // hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    // hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    // hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    // hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}
