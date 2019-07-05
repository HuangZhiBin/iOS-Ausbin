# Ausbin框架
代码不再更新，最新代码请参考https://github.com/HuangZhiBin/Ausbin
### 基于数据驱动的iOS开源框架
Ausbin框架是基于数据驱动的iOS开源框架，其原理类似于前端的VUE/react框架。
PS: 业务再多也不怕啦~
> Ausbin is an iOS open-source framework based on Data-driven project, just like frontend frameworks, like VUE/react etc.

![](http://wxtopik.oss-cn-shanghai.aliyuncs.com/app/images/ausbin.png)

### 推荐使用数据驱动框架的原因
- 在iOS的开发过程中，我们将ViewController（以下简称vc）区分不同的功能页面
- vc的代码包括了view的创建和刷新、数据的访问、以及vc间的跳转
- 为了快速完成业务，将所有view、model的操作写在vc里面，随着业务的深入，代码的维护成本越来越高
- MVC解决了业务分层的需要，但存在的缺点较为明显，view与model之间的操作过于直接，导致业务混杂，还会造成数据不一致的情况
- 前端的VUE/react框架提供了基于数据驱动的框架思想，分离了model和view，引入了中间层，作为model和view之间相互信任的媒介，在model数据更新时通知view进行UI刷新，以及接收view的UI触发事件对model进行数据的更新
- 数据驱动框架的优点在于view、model各司其职，view的代码只需处理前端UI的渲染与交互，而不直接操作model数据。可以由独立的service处理业务逻辑，对model进行数据的更新
- view与model之间动态绑定，由model决定view的显示，而model也可以根据view的交互做出相应的处理，两者的交互由中间件完成，实现业务的解耦

### Ausbin框架实现语言
`Swift4`

### Ausbin框架核心技术
`KVC` `反射`

### Ausbin框架版本
`1.1.0`

### Ausbin框架结构图
![](http://wxtopik.oss-cn-shanghai.aliyuncs.com/app/images/network3.jpg)

### 基于Ausbin的最简单的例子
以一个最简单的Sample作为例子，分析一下Ausbin的运行过程。下面是Sample这个vc的目录结构（具体参考/Ausbin/Controllers/Sample）, Sample的文件夹里面有5个文件:

+ **SampleViewController.swift**
	> vc代码

+ **SampleVcModel.swift**
	> vc的model，数据持久层，存储数据

+ **SampleVcService.swift**
	> vc的service，逻辑处理层，直接操作model

+ **SampleVcView.swift**
	> vc的view，视图层，只负责UI相关的业务

+ **SampleVcRouter.swift**
	> vc的router，中间层，service与view互相信任的中间件

##### 提示： 
+ Ausbin框架的核心代码位于/Ausbin/AusbinFramework/
+ Ausbin框架的引入步骤写在注释里，用注释`// [Ausbin] ……`注明，没有注明的代码就和我们之前开发vc的流程类似，大家可以适当忽略。
+ Ausbin框架的代理方法或扩展方法均以`asb_`开头，以便区分。
    + vcModel的扩展方法以`asb_vc_model_`开头
	+ vcView的扩展方法以`asb_vc_view_`开头

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
    
    // 必须为变量添加objc特性支持KVC:@objc dynamic
    @objc dynamic var innerText : String! = "这是最初始的值:0";
    
}
```

###### （3）SampleVcService.swift

vcService直接操作vcModel，为vcRouter提供接口，不参与其他的事务。

```swift
class SampleVcService: NSObject {
    
    // [Ausbin] 必须为变量vcModel添加objc特性支持KVC:@objc
    var vcModel: SampleVcModel!;
    
    override init() {
        super.init();
        // 初始化vcModel
        self.vcModel = SampleVcModel();
    }
    
    // 提供修改model的接口
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

- 1.&nbsp;创建`weak`类型的vcRouter实例(weak防止强制持有，避免循环引用)，引入外部vcRouter，刷新当前view
- 2.&nbsp;vcView实现`AusbinVcViewDelegate`代理
- 3.&nbsp;代理方法`asb_refreshViews()`接受vcRouter的UI更新请求

```swift
class SampleVcView: UIView {
    
    // [Ausbin] 必须为变量vcRouter添加objc特性支持KVC:@objc，定义为weak防止强制持有
    @objc weak var vcRouter : SampleVcRouter!{
        didSet{
            // model初始化view
            self.asb_refreshViews(fullKeyPath: nil);
        }
    }

    //UI初始化代码，此处省略……
    
    func initAllViews(){
        //UI初始化代码，此处省略……
        
        self.btn.setAction(kUIButtonBlockTouchUpInside, with: {[weak self] () in
            //向vcRouter发送事件
            self?.vcRouter.handler.changeInnerText();
        });
    }
    
    //UI初始化代码，此处省略……
}

// [Ausbin] 必须为VcView实现AusbinVcViewDelegate代理
extension SampleVcView : AusbinVcViewDelegate{
    
    // 接受vcRouter的UI更新请求，并让vcView作出相应的UI刷新操作
    func asb_refreshViews(fullKeyPath: String?){
        //fullKeyPath为nil默认执行代码，用于view的数据初始化
        if(fullKeyPath == nil || fullKeyPath == "innerText"){
            self.label.text = self.vcRouter.dataSet.innerText;
        }
    }
}
```
> 关于`asb_refreshViews()`代理方法的参数`fullKeyPath`的说明，请参考下面的进阶例子中关于“子对象互相嵌套时，获取vcModel子对象的keyPath”的解释。

###### （5）SampleVcRouter.swift

新增vcRouter类，作为vcView和vcService的信任中介。这是Ausbin框架的重点。

- 1.&nbsp;继承AusbinVcRouter
- 2.&nbsp;引入外部vcView，初始化vcRouter
- 3.&nbsp;创建**dataSet** (vcRouter提供给vcView的变量集)
- 4.&nbsp;创建**handler** (vcRouter调用vcService的接口更新vcModel数据)

```swift
class SampleVcRouter: AusbinVcRouter {
    
    // 处理View的Action事件，通过Service刷新Model数据，必须为变量vcRouter添加objc特性支持KVC:@objc
    @objc var handler : SampleVcService!;
    
    // Model提供给View刷新界面的model数据，必须为变量vcRouter添加objc特性支持KVC:@objc
    @objc var dataSet : SampleVcModel!;
    
    init(vcView : SampleVcView) {
        super.init(
            vcService: SampleVcService(),
            vcModelKeyPath: #keyPath(SampleVcService.vcModel),
            vcView: vcView,
            vcRouterPathKey: #keyPath(SampleVcView.vcRouter),
            handlerKeyPath: #keyPath(SampleVcRouter.handler),
            dataSetKeyPath: #keyPath(SampleVcRouter.dataSet)
        );
    }
    
    required init(coder aDecoder: NSCoder?) {
        super.init(coder: nil);
    }
}
```

**关于Ausbin的设计模式：**
> - 1.&nbsp;遵循vcView与vcService(或vcModel)互不信任的模式: 
>   - (1)&nbsp;vcView不直接操作vcService(或vcModel)，只得到vcRouter提供的dataSet数据，以及通过vcRouter提供的handler处理数据
>   - (2)&nbsp;vcService(或vcModel)不直接操作vcView，通过KVC由vcRouter通知vcView刷新UI
>   - (3)&nbsp;vcRouter作为vcView与vcService都信任的中间层，负责二者的交互
> - 2.&nbsp;Ausbin的引入步骤简单易上手：
>   - (1)&nbsp;**vc层**:&nbsp;只需初始化vcRouter，并在vc的deinit时销毁，无其他额外的引入代码
>   - (2)&nbsp;**vcModel层**:&nbsp;无额外的引入代码，只需保证KVC监听的变量支持objc+dynamic特性
>   - (3)&nbsp;**vcService层**:&nbsp;无额外的引入代码，只需保证KVC监听的变量vcModel支持objc特性
>   - (4)&nbsp;**vcView层**:&nbsp;只需定义weak变量vcRouter，保证vcRouter支持objc特性，并实现AusbinVcViewDelegate代理
>   - (5)&nbsp;**vcRouter层**:&nbsp;Ausbin的核心实现，是在原有的vc+model+service+view的基础上新增的中间层，需要定义`handler`(vcRouter -> vcService)和`dataSet`(vcRouter -> vcView)两大变量

##### 最终效果
![](http://wxtopik.oss-cn-shanghai.aliyuncs.com/app/images/1545819873521.gif)
------------

### 基于Ausbin的进阶例子
以Main作为例子，分析一下实际业务应用时可能遇到的情况。（具体参考/Ausbin/Controllers/Main）
- 1.&nbsp;当vcModel为多个子对象互相嵌套时，使所有子对象都能响应KVC
    + vcModel
        + **innerText** (1级子变量)
        + childModel: ChildModel
            + **innerText** (2级子变量)
            + childItemModel: ChildItemModel
	            + **innerText** (3级子变量)
- 2.&nbsp;子对象互相嵌套时，获取vcModel子对象的keyPath<br />fullKeyPath为完整的keyPath，以上面的vcModel对象为例：
   - vcModel下面的innerText的fullKeyPath为`innerText`
   - childModel下面的innerText的fullKeyPath为`childModel.innerText`
   - childItemModel下面的innerText的fullKeyPath为`childModel.childItemModel.innerText`
   - 以此类推
- 3.&nbsp;变量为数组时，数组任一对象(索引值为index)的属性值改变不会触发KVC，可通过`vcModel.arr = vcModel.arr`或者`vcModel.arr[index] = vcModel.arr[index]`的形式强制触发KVC
- 4.&nbsp;KVC监听的变量需要objc特性的支持，Int、Float等基础类型不支持，建议使用NSNumber
- 5.&nbsp;网络访问的情况
- 6.&nbsp;UITableView的数据刷新

##### 最终效果
![](http://wxtopik.oss-cn-shanghai.aliyuncs.com/app/images/1545813617457.gif)

> PS: 业务再多也不怕啦~


### 讨论
项目还存在以下的问题，欢迎批评指正：
- 1.&nbsp;如何更加方便地引入Ausbin？（代码更精简）
- 2.&nbsp;如何使vcRouter更精简？
- 3.&nbsp;vc间的跳转应该在哪里处理？
- 4.&nbsp;Ausbin能多大程度给繁杂的业务带来维护的好处？
- 5.&nbsp;Ausbin最大的问题，你发现了吗？
- 6.&nbsp;Ausbin的定位是一种框架、一种工具，还是一种分层思想？

待续……

| Item      | Value |
| --------- | -----:|
| 作者  | **黄智彬** |
| 原创  | **YES** |
| 微信  | **ikrboy** |
| 邮箱  |   **ikrboy@163.com** |
