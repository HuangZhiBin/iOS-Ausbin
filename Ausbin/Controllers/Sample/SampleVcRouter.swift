//
//  SampleVcRouter.swift
//  Ausbin
//
//  Created by bin on 2018/12/25.
//  Copyright © 2018年 BinHuang. All rights reserved.
//

import UIKit

// [Ausbin] 新增Router类，作为vcView和vcService的信任中介
class SampleVcRouter: NSObject {
    
    private var vcService : SampleVcService!;
    
    private weak var vcView : SampleVcView!;
    
    init(vcView : SampleVcView) {
        super.init();
        
        self.vcService = SampleVcService();
        self.dataSet = DataSet.init(model: self.vcService.vcModel);
        self.handler = Handler.init(service: self.vcService);
        
        self.vcView = vcView;
        self.vcView.asb_setRouter(router: self);
        
        //MARK: - 开始监听vcModel的数据改变(+KVC)
        self.asb_vc_router_addObserver(vcModel: self.vcService.vcModel);
    }
    
    required init(coder aDecoder: NSCoder?) {
        super.init();
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.asb_handleKeyPathChange(keyPath: keyPath, object: object);
    }
    
    // [Ausbin] vcService提供给vcView的变量，根据vcView的实际需要进行选择性的提供
    @objc var dataSet : DataSet!;
    
    class DataSet: NSObject {
        
        private var model : SampleVcModel!;
        
        init(model : SampleVcModel) {
            super.init();
            self.model = model;
        }
        
        required init(coder aDecoder: NSCoder?) {
            super.init();
        }
        
        @objc var innerText  : String!{
            get{
                return self.model.innerText;
            }
        };
    }
    
    // [Ausbin] 处理vcView的Action事件，通过vcService刷新vcModel数据
    var handler : Handler!;
    class Handler: NSObject {
        
        private var service : SampleVcService!;
        
        init(service : SampleVcService) {
            super.init();
            self.service = service;
        }
        
        required init(coder aDecoder: NSCoder?) {
            super.init();
        }
        
        func changeInnerText(){
            self.service.changeInnerText();
        }
    }
}

extension SampleVcRouter : AusbinVcRouterDelegate{
    
    // [Ausbin]  KVC 监听vcModel变化->刷新vcView
    func asb_handleKeyPathChange(keyPath: String?, object: Any?){
        let fullKeyPath = self.vcService.vcModel.asb_vc_model_getFullKeyPath(object: object, keyPath: keyPath);
        //若vcModel有子对象people,people对象有子对象child,child有属性subChild,则subChild的fullKeyPath为people.child.subChild(以此类推)
        if(fullKeyPath == "innerText"){
            self.vcView.asb_refreshViews(routerKey: #keyPath(SampleVcRouter.dataSet.innerText));
        }
    }
    
    // [Ausbin]  解除监听vcModel的数据改变(-KVC)
    func asb_deinitRouter(){
        self.asb_vc_router_removeObserver(vcModel: self.vcService.vcModel);
    }
}
