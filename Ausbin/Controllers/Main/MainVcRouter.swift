//
//  MainVcRouter.swift
//  Ausbin
//
//  Created by bin on 2018/12/25.
//  Copyright © 2018年 BinHuang. All rights reserved.
//

import UIKit

class MainVcRouter: NSObject {
    
    private var vcService : MainVcService!;
    
    private weak var vcView : MainVcView!;
    
    init(vcView : MainVcView) {
        super.init();
        
        self.vcService = MainVcService();
        self.vcView = vcView;
        self.vcView.asb_setRouter(router: self);
        
        //MARK: - Step1 开始监听vcModel的数据改变(+KVC)
        self.asb_vc_router_addObserver(vcModel: self.vcService.vcModel);
    }
    
    required init(coder aDecoder: NSCoder?) {
        super.init();
    }
    
    //MARK: - Step2 KVC 监听Model变化->刷新View
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        //self.asb_handleKeyPathChange(object: object, keyPath: keyPath);
        let fullKeyPath = self.vcService.vcModel.asb_vc_model_getFullKeyPath(object: object, keyPath: keyPath);
        if(fullKeyPath == "items"){
            self.vcView.asb_refreshViews(routerKey: "items");
        }
        if(fullKeyPath == "innerText"){
            self.vcView.asb_refreshViews(routerKey: "innerText1");
        }
        if(fullKeyPath == "childModel.innerText"){
            self.vcView.asb_refreshViews(routerKey: "innerText2");
        }
        if(fullKeyPath == "childModel.childItemModel.innerText"){
            self.vcView.asb_refreshViews(routerKey: "innerText3");
        }
    }
    
    //MARK: - Step3 提供给View刷新界面的数据
    var items : [ListItemModel]!{
        get{
            return self.vcService.vcModel.items;
        }
    };
    
    var checkedRowIndex : NSNumber!{
        get{
            return self.vcService.vcModel.checkedRowIndex;
        }
    };
    
    var innerText1  : String!{
        get{
            return self.vcService.vcModel.innerText;
        }
    };
    
    var innerText2  : String!{
        get{
            return self.vcService.vcModel.childModel.innerText;
        }
    };
    
    var innerText3  : String!{
        get{
            return self.vcService.vcModel.childModel.childItemModel.innerText;
        }
    };
    
    //MARK: - Step4 提供给View刷新数据的接口方法
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
    
    //MARK: - Step5 解除监听vcModel的数据改变(-KVC)
    func deinitRouter(){
        self.asb_vc_router_removeObserver(vcModel: self.vcService.vcModel);
    }

}
