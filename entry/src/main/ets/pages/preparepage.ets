// 创建NodeController
// common.ets
import { UIContext, RenderOptions } from '@kit.ArkUI';
import { webview } from '@kit.ArkWeb';
import { NodeController, BuilderNode, Size, FrameNode }  from '@kit.ArkUI';
import {configs,Config,basicResources,ResourceConfig} from './myjava'
import {createCommonWeb, getCommonWeb} from './common'
// @Builder中为动态组件的具体组件内容
// Data为入参封装类
class Data{
  url: string = '';
  controller: WebviewController = new webview.WebviewController();
}

class urlData{
  url: string = '';
}

const storage = LocalStorage.getShared();
let array1: Array<urlData>=[
  {
    url : 'https://m.baidu.com/'
  },
  {
    url : 'https://m.thepaper.cn/'
  },
  {
    url : 'https://app.people.cn/'
  },
]

@Builder
function WebBuilder(data:Data) {
  Column() {
    Web({ src: data.url, controller: data.controller })
      .domStorageAccess(true)
      .zoomAccess(true)
      .fileAccess(true)
      .mixedMode(MixedMode.All)
      .width('100%')
      .height('100%')
      .onAppear(() => {
      })
      .onPageBegin((event) => {
        // 此步骤大概花费60ms;
        // console.log("before prefetchPage");
        // for (let url1 of array1) {
        //   data.controller.prefetchPage(url1.url);
        // }
        // console.log("after prefetchPage");
        //
        //createCommonWeb('https://m.thepaper.cn/');
        //createCommonWeb('https://app.people.cn/');
      })
      .onPageEnd((event) => {
        //console.log("click end ")
      })
    //预编译加资源拦截注入大概花费1100ms
      /*.onControllerAttached(async () => {
        //预下载
        // 读取配置，进行预编译
        let array2: Array<Config> = configs
        for (let config of array2) {
          let content = await getContext().resourceManager.getRawFileContentSync(config.localPath);
          try {
            data.controller.precompileJavaScript(config.url, content, config.options)
              .then((errCode: number) => {
                console.log('precompile successfully!' );
              }).catch((errCode: number) => {
              console.error('precompile failed.' + errCode);
            })
          } catch (err) {
            console.error('precompile failed!.' + err.code + err.message);
          }
        }

        //离线资源免拦截
        try {
          data.controller.injectOfflineResources(await getData ());
        } catch (err) {
          console.error("error: " + err.code + " " + err.message);
        }

        //console.log('precompilejava end')



      })*/

  }
}

let wrap = wrapBuilder<Data[]>(WebBuilder);

// 用于控制和反馈对应的NodeContainer上的节点的行为，需要与NodeContainer一起使用
export class myNodeController extends NodeController {
  private rootnode: BuilderNode<Data[]> | null = null;
  private root: FrameNode | null = null;
  // 必须要重写的方法，用于构建节点数、返回节点挂载在对应NodeContainer中
  // 在对应NodeContainer创建的时候调用、或者通过rebuild方法调用刷新
  makeNode(uiContext: UIContext): FrameNode | null {
    console.log(' uicontext is undifined : '+ (uiContext === undefined));
    if (this.rootnode != null) {
      const parent = this.rootnode.getFrameNode()?.getParent();
      if (parent) {
        console.info(JSON.stringify(parent.getInspectorInfo()));
        parent.removeChild(this.rootnode.getFrameNode());
        this.root = null;
      }
      this.root = new FrameNode(uiContext);
      this.root.appendChild(this.rootnode.getFrameNode());
      // 返回FrameNode节点
      return this.root;
    }
    // 返回null控制动态组件脱离绑定节点
    return null;
  }
  // 当布局大小发生变化时进行回调
  aboutToResize(size: Size) {
    console.log('aboutToResize width : ' + size.width  +  ' height : ' + size.height )
  }

  // 当controller对应的NodeContainer在Appear的时候进行回调
  aboutToAppear() {
    console.log('aboutToAppear')
  }

  // 当controller对应的NodeContainer在Disappear的时候进行回调
  aboutToDisappear() {
    console.log('aboutToDisappear')
  }

  // 此函数为自定义函数，可作为初始化函数使用
  // 通过UIContext初始化BuilderNode，再通过BuilderNode中的build接口初始化@Builder中的内容
  initWeb(url:string, control:WebviewController) {
    if(this.rootnode != null)
    {
      return;
    }
    // 创建节点，需要uiContext
    const uiContext: UIContext = storage.get<UIContext>("uiContext") as UIContext;
    if (!uiContext) {
      return;
    }
    this.rootnode = new BuilderNode(uiContext)


    // 创建动态Web组件
    this.rootnode.build(wrap, { url:url, controller:control})
  }
}
// 创建Map保存所需要的NodeController
let NodeMap:Map<string, myNodeController | undefined> = new Map();
// 创建Map保存所需要的WebViewController
let controllerMap:Map<string, WebviewController | undefined> = new Map();

// 初始化需要UIContext 需在Ability获取
export const createNWeb = (url: string) => {
  // 创建NodeController
  let baseNode = new myNodeController();
  let controller = new webview.WebviewController() ;
  // 初始化自定义web组件
  baseNode.initWeb(url, controller);
  controllerMap.set(url, controller)
  NodeMap.set(url, baseNode);
}
// 自定义获取NodeController接口
export const getNWeb = (url : string) : myNodeController | undefined => {
  return NodeMap.get(url);
}


export async function getData() {
  const resourceMapArr: Array<webview.OfflineResourceMap> = [];

  let myResources: Array<ResourceConfig> = basicResources;
  // 读取配置，从rawfile目录中读取文件内容
  for (let config of myResources) {
    let buf: Uint8Array = new Uint8Array(0);
    if (config.localPath) {
      buf = await readRawFile(config.localPath);
    }

    resourceMapArr.push({
      urlList: config.urlList,
      resource: buf,
      responseHeaders: config.responseHeaders,
      type: config.type,
    })
  }

  return resourceMapArr;
}

export async function readRawFile(url: string) {
  try {
    return await getContext().resourceManager.getRawFileContent(url);
  } catch (err) {
    return new Uint8Array(0);
  }
}
