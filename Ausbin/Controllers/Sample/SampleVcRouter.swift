//
//  SampleVcRouter.swift
//  Ausbin
//
//  Created by bin on 2018/12/25.
//  Copyright © 2018年 BinHuang. All rights reserved.
//

import UIKit

// [Ausbin] 新增Router类，作为vcView和vcService的信任中介
class SampleVcRouter: AusbinVcRouter {
    
    //MARK: - 处理View的Action事件，通过Service刷新Model数据
    @objc var handler : SampleVcService!;
    //MARK: - Model提供给View刷新界面的model数据
    @objc var dataSet : SampleVcModel!;
    
    init(vcView : SampleVcView) {
        super.init(handler: SampleVcService(), vcModelKeyPath: #keyPath(SampleVcService.vcModel), handlerKeyPath: #keyPath(SampleVcRouter.handler), dataSetKeyPath:#keyPath(SampleVcRouter.dataSet), vcView: vcView);
    }
    
    required init(coder aDecoder: NSCoder?) {
        super.init(coder: nil);
    }
    
    // [Ausbin]  KVC 监听vcModel变化->刷新vcView
    override func asb_handleKeyPathChange(keyPath: String?, object: Any?){
        self.handleKeyPathChange(keyPath: keyPath, object: object, targetKeyPathsAndRouterKeys: ["innerText": #keyPath(MainVcRouter.dataSet.innerText)]);
    }
    
    // [Ausbin]  解除监听vcModel的数据改变(-KVC)
    override func asb_deinitRouter(){
        super.asb_deinitRouter();
    }
}
