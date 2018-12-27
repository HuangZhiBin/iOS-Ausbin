//
//  MainVcRouter.swift
//  Ausbin
//
//  Created by bin on 2018/12/25.
//  Copyright © 2018年 BinHuang. All rights reserved.
//

import UIKit

class MainVcRouter: AusbinVcRouter {
    
    //MARK: - 处理View的Action事件，通过Service刷新Model数据
    @objc var handler : MainVcService!;
    //MARK: - Model提供给View刷新界面的model数据
    @objc var dataSet : MainVcModel!;

    init(vcView : MainVcView) {
        super.init(handler: MainVcService(), vcModelKeyPath: #keyPath(MainVcService.vcModel), handlerKeyPath: #keyPath(MainVcRouter.handler), dataSetKeyPath: #keyPath(MainVcRouter.dataSet), vcView: vcView);
    }
    
    required init(coder aDecoder: NSCoder?) {
        super.init(coder: aDecoder);
    }
    
    //MARK: - KVC 监听Model变化->刷新View
    override func asb_handleKeyPathChange(keyPath: String?, object: Any?){
        self.handleKeyPathChange(keyPath: keyPath, object: object, targetKeyPathsAndRouterKeys:
            [
                "items": #keyPath(MainVcRouter.dataSet.items),
                "innerText": #keyPath(MainVcRouter.dataSet.innerText),
                "childModel.innerText": #keyPath(MainVcRouter.dataSet.childModel.innerText),
                "childModel.childItemModel.innerText": #keyPath(MainVcRouter.dataSet.childModel.childItemModel.innerText)
            ]
        );
    }
    
    //MARK: - 解除监听vcModel的数据改变(-KVC)
    override func asb_deinitRouter(){
        super.asb_deinitRouter();
    }
}
