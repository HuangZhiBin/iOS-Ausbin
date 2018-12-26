# Ausbin框架
### 基于数据驱动的iOS开源框架
Ausbin框架是基于数据驱动的iOS开源框架，其原理类似于前端的VUE/react框架。
> Ausbin is an iOS open-source framework based on Data-driven project, just like frontend frameworks, like VUE/react etc.

### iOS开发使用数据驱动框架的原因
- 在iOS的开发过程中，我们将ViewController（以下简称vc）区分不同的功能页面
- vc的代码包括了view的创建和刷新、数据的访问、以及vc间的跳转
- 为了快速完成业务，将所有view、model的操作写在vc里面，随着业务的深入，代码的维护成本越来越高
- MVC解决了业务分层的需要，但存在的缺点较为明显，view与model之间的操作过于直接，导致业务混杂
- 前端的VUE/react框架提供了基于数据驱动的框架思想，分离了model和view，引入了中间层，作为model和view之间相互信任的媒介，在model数据更新时通知view进行UI刷新，以及接收view的UI触发事件对model进行数据的更新
- 数据驱动框架的优点在于view、model各司其职，view的代码只需处理前端UI的渲染与交互，而不直接操作model数据。可以由独立的service处理业务逻辑，对model进行数据的更新
- view与model之间动态绑定，由model决定view的显示，而model也可以根据view的交互做出相应的处理，两者的交互由中间件完成，实现业务的解耦

### 最简单基于Ausbin的例子
以一个最简单的Sample作为例子，分析一下Ausbin的运行过程。下面是Sample这个vc的目录结构（具体参考master/Ausbin/Controllers/Sample）, Sample的文件夹里面有五个文件:
+ Sample
+ **SampleViewController.swift**
+ **SampleVcModel.swift**： vc的model
+ **SampleVcService.swift**： vc的service，直接操作model
+ **SampleVcView.swift**： vc的view，只负责UI相关的业务
+ **SampleVcRouter.swift**： vc的router，service与view互相信任的中间件

> 下面对每个文件进行分析

##### （1）SampleViewController.swift

ViewController代码简洁，没有额外的特殊操作。最重要的步骤就是初始化vcRouter，并在vc的deinit时清除。

> Ausbin框架的引入步骤写在注释里，用注释`// [Ausbin] ……`注明，没有注明的代码就和我们之前开发vc的流程类似，大家可以适当忽略

```swift
class SampleViewController: UIViewController {

var vcView : SampleVcView!;
var vcRouter : SampleVcRouter!;

override func viewDidLoad() {
super.viewDidLoad();

self.title = "最简单的例子";

self.vcView = SampleVcView(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height:ScreenHeight-Status_Bar_Height-Navigation_Bar_Height));
self.view.addSubview(self.vcView);

// [Ausbin] 初始化vcRouter
self.vcRouter = SampleVcRouter.init(vcView: self.vcView);
}

deinit {
// [Ausbin] 清除vcRouter
self.vcRouter.asb_deinitRouter();
}
}
```

### 绘制表格 Tables

| 项目        | 价格   |  数量  |
| --------   | -----:  | :----:  |
| 计算机      | $1600   |   5     |
| 手机        |   $12   |   12   |
| 管线        |    $1    |  234  |

First Header  | Second Header
------------- | -------------
Content Cell  | Content Cell
Content Cell  | Content Cell

| First Header  | Second Header |
| ------------- | ------------- |
| Content Cell  | Content Cell  |
| Content Cell  | Content Cell  |

![](http://wxtopik.oss-cn-shanghai.aliyuncs.com/app/images/ausbin.png)

**目录 (Table of Contents)**

[TOC]
