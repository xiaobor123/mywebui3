// 创建NodeController
// common.ets
import taskpool from '@ohos.taskpool';
import { UIContext } from '@kit.ArkUI';
import { webview } from '@kit.ArkWeb';
import { NodeController, BuilderNode, Size, FrameNode }  from '@kit.ArkUI';
import { hiTraceMeter } from '@kit.PerformanceAnalysisKit';
import {configs,Config,basicResources,ResourceConfig} from './myjava'
import{mydata, uicontext,myWebUrl} from './WebTab'
// @Builder中为动态组件的具体组件内容
// Data为入参封装类
export let isload1:number = 0
export let isload2:number = 0

class createWebData{
  url: string = '';
  controller: WebviewController = new webview.WebviewController();
}
let mybusinessNode2: myNodeController | undefined = undefined
let mybusinessNode3: myNodeController | undefined = undefined

@Builder
function WebBuilder(data:createWebData) {
  Column() {
    Web({ src: data.url, controller: data.controller })
      .domStorageAccess(true)
      .fileAccess(true)
      .imageAccess(true)
      .onAppear(()=>{
        if(data.url != myWebUrl[0]) {
          webview.WebviewController.prepareForPageLoad(data.url, true, 2);
        }
      })
      .onPageVisible((event) => {
        console.log("Page visible "+data.url)
        if(data.url == myWebUrl[0]) {
          data.controller.prefetchPage(myWebUrl[2])
        }
        if(data.url == myWebUrl[0]&&isload1 ==0){
          isload1 = isload1+1
          mybusinessNode2=createCommonWeb(myWebUrl[1],uicontext,data.controller);
          mydata.pushData(mybusinessNode2)
        }
      })
      .onPageBegin((event) => {
        console.log("Page begin "+data.url)
        if(data.url == myWebUrl[1]&&isload2 ==0) {
          isload2 = isload2+1
          mybusinessNode3=createCommonWeb(myWebUrl[2],uicontext,data.controller);
          mydata.pushData(mybusinessNode3)
        }
      })
      .onPageEnd((event) => {
        console.log("Page end "+data.url)
      })
      .onControllerAttached(async () => {
        if(data.url == myWebUrl[0]){
            //taskPoolExecute(data.controller)
          //taskPoolExecute(data.controller)

          let array2: Array<Config> = configs

          for (let config of array2) {
            let content = await getContext().resourceManager.getRawFileContentSync(config.location);
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

          try {
            data.controller.injectOfflineResources(await getData ());
          } catch (err) {
            console.error("error: " + err.code + " " + err.message);
          }
        }

      })

  }
}

// async function taskPoolExecute(controler4:webview.WebviewController): Promise<[]> {
//   let task: taskpool.Task = new taskpool.Task(mockRequestData,getContext(),controler4);
//   return await taskpool.execute(task) as [];
// }
//
// @Concurrent
// async function mockRequestData(context: Context,controler1:webview.WebviewController): Promise<[]> {
//   let array2: Array<Config> = configs
//   for (let config of array2) {
//     let content = context.resourceManager.getRawFileContentSync(config.location);
//     try {
//       controler1.precompileJavaScript(config.url, content, config.options)
//         .then((errCode: number) => {
//           console.log('precompile successfully!' );
//         }).catch((errCode: number) => {
//         console.error('precompile failed.' + errCode);
//       })
//     } catch (err) {
//       console.error('precompile failed!.' + err.code + err.message);
//     }
//   }
//   return [];
// }

let wrap = wrapBuilder<createWebData[]>(WebBuilder);

// 用于控制和反馈对应的NodeContainer上的节点的行为，需要与NodeContainer一起使用
export class myNodeController extends NodeController {
  private rootnode: BuilderNode<createWebData[]> | null = null;
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
  initWeb(url:string, control:WebviewController,uiContext:UIContext) {
    if(this.rootnode != null)
    {
      return;
    }
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
export const createCommonWeb = (url: string,uiContext: UIContext,controller: webview.WebviewController) => {
  // 创建NodeController
  //console.log('createCommonWeb start'+url)
  let baseNode = new myNodeController();
  // 初始化自定义web组件
  baseNode.initWeb(url, controller,uiContext);
  controllerMap.set(url, controller)
  NodeMap.set(url, baseNode);
  return baseNode
  //console.log('createCommonWeb end'+url)
}

export const getCommonWeb = (url : string) : myNodeController | undefined => {
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