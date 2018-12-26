//
//  MainVcRouter.swift
//  Ausbin
//
//  Created by bin on 2018/12/25.
//  Copyright © 2018年 BinHuang. All rights reserved.
//

import UIKit

class MainVcRouter: AusbinVcRouter {
    
    private var vcService : MainVcService!;
    
    private weak var vcView : MainVcView!;
    
    init(vcView : MainVcView) {
        super.init();
        
        self.vcService = MainVcService();
        self.dataSet = DataSet.init(vcModel: self.vcService.vcModel);
        self.handler = Handler.init(vcService: self.vcService);
        
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
        //self.asb_handleKeyPathChange(object: object, keyPath: keyPath);
    }
    
    //MARK: - Model提供给View刷新界面的部分公开变量
    @objc var dataSet : DataSet!;
    
    class DataSet: NSObject {
        
        private var vcModel : MainVcModel!;
        
        init(vcModel : MainVcModel) {
            super.init();
            self.vcModel = vcModel;
        }
        
        required init(coder aDecoder: NSCoder?) {
            super.init();
        }
        
        @objc var items : [ListItemModel]!{
            get{
                return self.vcModel.items;
            }
        };
        
        @objc var checkedRowIndex : NSNumber!{
            get{
                return self.vcModel.checkedRowIndex;
            }
        };
        
        @objc var innerText1  : String!{
            get{
                return self.vcModel.innerText;
            }
        };
        
        @objc var innerText2  : String!{
            get{
                return self.vcModel.childModel.innerText;
            }
        };
        
        @objc var innerText3  : String!{
            get{
                return self.vcModel.childModel.childItemModel.innerText;
            }
        };
    }
    
    //MARK: - 处理View的Action事件，通过Service刷新Model数据
    var handler : Handler!;
    class Handler: NSObject {
        
        private var vcService : MainVcService!;
        
        init(vcService : MainVcService) {
            super.init();
            self.vcService = vcService;
        }
        
        required init(coder aDecoder: NSCoder?) {
            super.init();
        }
        
        func changeLevelValue1(){
            self.vcService.changeLevelValue1();
        }
        
        func changeLevelValue2(){
            self.vcService.changeLevelValue2();
        }
        
        func changeLevelValue3(){
            self.vcService.changeLevelValue3();
        }
        
        func changeTableValue(index : Int){
            self.vcService.changeTableValue(index: index);
        }
        
        func webLoadList(success: @escaping ServiceSuccessCallback, error: @escaping ServiceErrorCallback,  fail : @escaping ServiceNetworkFailCallback){
            self.vcService.webLoadList(success: success, error: error, fail: fail);
        }
    }

}

extension MainVcRouter : AusbinVcRouterDelegate{
    
    //MARK: - KVC 监听Model变化->刷新View
    func asb_handleKeyPathChange(keyPath: String?, object: Any?){
        let fullKeyPath = self.vcService.vcModel.asb_vc_model_getFullKeyPath(object: object, keyPath: keyPath);
        
        if(fullKeyPath == "items"){
            self.vcView.asb_refreshViews(routerKey: #keyPath(MainVcRouter.dataSet.items));
        }
        if(fullKeyPath == "innerText"){
            self.vcView.asb_refreshViews(routerKey: #keyPath(MainVcRouter.dataSet.innerText1));
        }
        if(fullKeyPath == "childModel.innerText"){
            self.vcView.asb_refreshViews(routerKey: #keyPath(MainVcRouter.dataSet.innerText2));
        }
        if(fullKeyPath == "childModel.childItemModel.innerText"){
            self.vcView.asb_refreshViews(routerKey: #keyPath(MainVcRouter.dataSet.innerText3));
        }
    }
    
    //MARK: - 解除监听vcModel的数据改变(-KVC)
    func asb_deinitRouter(){
        self.asb_vc_router_removeObserver(vcModel: self.vcService.vcModel);
    }
}
