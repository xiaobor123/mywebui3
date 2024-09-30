export class tabPage{
  type: TabPageType
  url: string = ""
  text: string = ""

  constructor(type: TabPageType, url: string = "https://www.baidu.com",text: string="") {
    this.type=type
    this.url = url
    this.text = text
  }
}

export interface   tabItemContent{
  normalImg?: ResourceStr
  selectedImg?: ResourceStr
  normalText?: ResourceStr
  selectedText?: ResourceStr
}
export enum TabPageType{
  //Web网页
  Web,
  //文字页面
  Normal,
  //自定义页面
  Custom
}