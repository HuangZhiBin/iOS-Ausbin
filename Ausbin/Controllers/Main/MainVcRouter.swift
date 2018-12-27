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
        super.init(
            vcService: MainVcService(),
            vcModelKeyPath: #keyPath(MainVcService.vcModel),
            vcView: vcView,
            vcRouterPathKey: #keyPath(MainVcView.vcRouter),
            handlerKeyPath: #keyPath(MainVcRouter.handler),
            dataSetKeyPath: #keyPath(MainVcRouter.dataSet)
        );
    }
    
    required init(coder aDecoder: NSCoder?) {
        super.init(coder: aDecoder);
    }
}
