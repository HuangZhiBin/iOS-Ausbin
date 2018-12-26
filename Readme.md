# Ausbin框架
### 基于数据驱动的iOS开源框架
Ausbin框架是基于数据驱动的iOS开源框架，其原理类似于前端的VUE/react框架。
> Ausbin is an iOS open-source framework based on Data-driven project, just like frontend frameworks, like VUE/react etc.

![](http://wxtopik.oss-cn-shanghai.aliyuncs.com/app/images/ausbin.png)

**目录 (Table of Contents)**
[TOC]

### 推荐使用数据驱动框架的原因
- 在iOS的开发过程中，我们将ViewController（以下简称vc）区分不同的功能页面
- vc的代码包括了view的创建和刷新、数据的访问、以及vc间的跳转
- 为了快速完成业务，将所有view、model的操作写在vc里面，随着业务的深入，代码的维护成本越来越高
- MVC解决了业务分层的需要，但存在的缺点较为明显，view与model之间的操作过于直接，导致业务混杂，还会造成数据不一致的情况
- 前端的VUE/react框架提供了基于数据驱动的框架思想，分离了model和view，引入了中间层，作为model和view之间相互信任的媒介，在model数据更新时通知view进行UI刷新，以及接收view的UI触发事件对model进行数据的更新
- 数据驱动框架的优点在于view、model各司其职，view的代码只需处理前端UI的渲染与交互，而不直接操作model数据。可以由独立的service处理业务逻辑，对model进行数据的更新
- view与model之间动态绑定，由model决定view的显示，而model也可以根据view的交互做出相应的处理，两者的交互由中间件完成，实现业务的解耦

### Ausbin框架核心技术
`KVC`

### 基于Ausbin的最简单的例子
以一个最简单的Sample作为例子，分析一下Ausbin的运行过程。下面是Sample这个vc的目录结构（具体参考master/Ausbin/Controllers/Sample）, Sample的文件夹里面有5个文件:

+ **SampleViewController.swift**
	> vc代码

+ **SampleVcModel.swift**
	> vc的model，存储数据

+ **SampleVcService.swift**
	> vc的service，直接操作model

+ **SampleVcView.swift**
	> vc的view，只负责UI相关的业务

+ **SampleVcRouter.swift**
	> vc的router，service与view互相信任的中间件

##### 提示： 
+ Ausbin框架的引入步骤写在注释里，用注释`// [Ausbin] ……`注明，没有注明的代码就和我们之前开发vc的流程类似，大家可以适当忽略。
+ Ausbin框架的代理方法或扩展方法均以`asb_`开头，以便区分。
    + vcModel的扩展方法以`asb_vc_model_`开头
	+ vcView的扩展方法以`asb_vc_view_`开头
    + vcRouter的扩展方法以`asb_vc_router_`开头

##### 代码分析
###### （1）SampleViewController.swift
ViewController代码简洁，没有额外的特殊操作。
- 在`viewDidLoad()`初始化vcRouter
- 在`deinit()`时清除初始化vcRouter

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

###### （2）SampleVcModel.swift

vcModel需要注意的是，变量需要加入objc特性`@objc dynamic`实现KVC。

```swift
class SampleVcModel: NSObject {
    
    // [Ausbin] 必须为变量添加objc特性支持KVC:@objc dynamic
    @objc dynamic var innerText : String! = "这是最初始的值:0";
    
}
```

###### （3）SampleVcService.swift

vcService直接操作vcModel，为vcRouter提供接口，不参与其他的事务。

```swift
class SampleVcService: NSObject {
    
    var vcModel: SampleVcModel!;
    
    override init() {
        super.init();
        // [Ausbin] 初始化vcModel
        self.vcModel = SampleVcModel();
    }
    
    // [Ausbin] 提供修改model的接口
    func changeInnerText(){
        let now = Date()
        let timeInterval: TimeInterval = now.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        self.vcModel.innerText = "最新的innerText的值:"+String(millisecond);
    }
}
```
>  vcService提供了changeInnerText的方法，调用该方法，实现对vcModel的变量innerText的修改。为了便于展示变化效果，每一次调用后将改为时间戳的形式进行展示。


###### （4）SampleVcView.swift

vcView需要建立与vcRouter的联系，一是将接收到的UI事件（点击按钮、长按、切换图片等）反馈给vcRouter，二是响应vcRouter返回的UI刷新请求。

- 1.为每一个UI响应事件添加action
- 2.创建`weak`类型的vcRouter实例(weak防止强制持有，避免循环引用)
- 3.vcRouter实例赋值后执行刷新当前view
- 4.vcView实现`AusbinVcViewDelegate`代理
- 5.代理方法`asb_setRouter()`引入外部vcRouter
- 6.代理方法`asb_getAvailableActions()`定义可执行的action数组，没有设置可行的action将无法更新model
- 7.代理方法`asb_handleAction()`接受vcView的action事件
- 8.代理方法`asb_refreshViews()`接受vcRouter的UI更新请求

```swift
class SampleVcView: UIView {
    
    // [Ausbin] 为每一个UI响应事件添加action(前提是这个action的触发会更新model的数据)
    let ACTION_CLICK_BTN = UIView.asb_vc_view_generateAction();
    
    // [Ausbin] vcRouter实例，定义为weak防止强制持有
    private weak var vcRouter : SampleVcRouter!{
        didSet{
            // [Ausbin] model刷新当前view
            self.asb_refreshViews(routerKey: nil);
        }
    }
    
    //初始化vcView时执行
    func initAllViews(){
        //UI初始化代码，此处省略……
        
        //btn按钮的点击事件（kUIButtonBlockTouchUpInside 为第三方方法，通过block响应btn的点击事件，感兴趣的可自行google）
        self.btn.setAction(kUIButtonBlockTouchUpInside, with: {[weak self] () in
            self?.asb_handleAction(action: (self?.ACTION_CLICK_BTN)!, params: [:]);
        });
    }
    
    //UI初始化代码，此处省略……
}

// [Ausbin] 必须为VcView实现AusbinVcViewDelegate代理
extension SampleVcView : AusbinVcViewDelegate{
    
    // [Ausbin] 引入外部vcRouter
    func asb_setRouter(router : NSObject){
        self.vcRouter = router as! SampleVcRouter;
    }
    
    // [Ausbin] 定义可执行的action数组，没有设置可行的action将无法更新model
    func asb_getAvailableActions() -> [String]{
        return [
            ACTION_CLICK_BTN
        ];
    }
    
    // [Ausbin] 接受vcView的action事件，让vcRouter调用vcService的接口更新数据
    func asb_handleAction(action : String, params: [String:Any?]){
        // [Ausbin] 必须判断该action的有效性
        if(self.asb_vc_view_isActionAvailble(action, ACTION_CLICK_BTN)){
            self.vcRouter.handler.changeInnerText();
        }
    }
    
    // [Ausbin] 让vcView接受vcRouter的UI更新请求，刷新UI
    func asb_refreshViews(routerKey: String?){
        if(routerKey == nil || routerKey == #keyPath(SampleVcRouter.dataSet.innerText)){
            self.label.text = self.vcRouter.dataSet.innerText;
        }
    }
}
```
**关于vcView的设计模式：**
- 1.为每个有效UI事件（点击、长按等，并会触发model数据的更新等事件）定义一个action，常量名为`ACTION_...`(名称必须可读且有意义，标记好该action实际对应的事件)
- 2.规定有效的actions数组，必须判断该action的有效性，没有设置可行的action将无法向vcRouter发送请求
- 3.vcView无法获取model数据，只能得到vcRouter提供的可用数据（来自model），并且为只读模式，即vcView无法修改model的数据
- 4.通过将所有的有效UI事件封装为action，所有事件作为action交付代理方法`asb_handleAction()`进行统一处理，限制了vcRouter处理action的唯一入口，还可以封禁某个action，使其事件失效
- 5.遵循vcView与vcService(或vcModel)互不信任的模式，vcView无法直接操作vcService(或vcModel)，只能得到vcRouter提供的只读数据；vcService(或vcModel)也无法直接操作vcView

##### 最终效果
![](http://wxtopik.oss-cn-shanghai.aliyuncs.com/app/images/1545810778989.gif)

> PS: 业务再多也不怕啦~

### 基于Ausbin的进阶例子
待续
微信交流：**ikrboy**