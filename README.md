

# fast-tab



## 接口说明

### FastTab组件

| 属性           | 类型             | 是否必须指定 | 说明                  |
| -------------- | ---------------- | ------------ | --------------------- |
|                |                  |              |                       |
| tabsController | TabsController   | 是           | tab控制器             |
| tabsItem       | TabsPage[]       | 是           | 每个tab对应页面的内容 |
| tabStyle       | TabsStyle        | 否           | tab的样式             |
| pageBuilder    | Builder          | 否           | 用户指定tab的构建函数 |
| tabContents    | tabItemContent[] | 是           | tab内容               |
|                |                  |              |                       |
|                |                  |              |                       |
|                |                  |              |                       |



### TabsPage类

### 

| 属性             | 类型   | 是否必须指定 | 说明                                    |
| ---------------- | ------ | ------------ | --------------------------------------- |
| type             | string | 是           | 页面类型                                |
| url              | string | 否           | 类型为“web”时可指定                     |
| text             | string | 否           | 类型为“normal”时显示                    |
| type枚举变量说明 |        |              |                                         |
| "web"            |        |              | 此时将显示url对应的网页                 |
| "normal"         |        |              | 此时将显示text对应的文字内容            |
| "custom"         |        |              | 此时将调用用户提供的builder函数构建页面 |



### tabItemContent

每个tab的内容

| 属性         | 类型        | 是否必须指定 | 说明             |
| ------------ | ----------- | ------------ | ---------------- |
| normalImg    | ResourceStr | 否           | 正常图片         |
| selectedImg  | ResourceStr | 否           | 选中时的图片     |
| normalText   | ResourceStr | 否           | 正常文字提示     |
| selectedText | ResourceStr | 否           | 选中时的文字提示 |
|              |             |              |                  |



### TabsStyle

interface

| 属性             | 类型          | 是否必须指定 | 说明           |
| ---------------- | ------------- | ------------ | -------------- |
| fontSize         | ResourceStr   | 否           | 字体大小       |
| fontColor        | ResourceStr   | 否           | 字体颜色       |
| fontWeight       | FontWeight    | 否           | 字体粗细       |
| fontSizeSelect   | ResourceStr   | 否           | 选中的字体大小 |
| fontColorSelect  | ResourceStr   | 否           | 选中的字体颜色 |
| fontWeightSelect | FontWeight    | 否           | 选中的字体粗细 |
| showText         | boolean       | 否           | 是否展示文字   |
| imgSize          | SizeOption    | 否           | 图标的大小     |
| showIcon         | boolean       | 否           | 是否展示图片   |
| tabWidth         | Length        | 否           | tab指示器宽度  |
| tabHeight        | Length        | 否           | tab指示器宽度  |
| backgroundColor  | ResourceColor | 否           | tab背景颜色    |
|                  |               |              |                |



