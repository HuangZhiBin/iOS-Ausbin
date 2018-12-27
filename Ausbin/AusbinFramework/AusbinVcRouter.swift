//
//  AusbinVcRouter.swift
//  Ausbin
//
//  Created by bin on 2018/12/27.
//  Copyright © 2018年 BinHuang. All rights reserved.
//

import UIKit

class AusbinVcRouter: NSObject{
    
    private var dataK : Any!;
    private weak var vcView : UIView!;//vcView实例，定义为weak防止强制持有
    
    init(vcService: NSObject, vcModelKeyPath: String, vcView : UIView, vcRouterPathKey : String, handlerKeyPath: String, dataSetKeyPath: String) {
        super.init();
        
        self.setValue(vcService, forKey: handlerKeyPath);
        
        self.dataK = vcService.value(forKey: vcModelKeyPath);
        self.setValue(self.dataK, forKey: dataSetKeyPath);
        
        self.vcView = vcView;
        self.vcView.setValue(self, forKey: vcRouterPathKey);
        
        //MARK: - 开始监听vcModel的数据改变(+KVC)
        self.addRouterObserver(vcModel: self.dataK as AnyObject);
    }
    
    required init(coder aDecoder: NSCoder?) {
        super.init();
    }
    
    //MARK: - 解除监听vcModel的数据改变(-KVC)
    func asb_deinitRouter(){
        self.removeRouterObserver(vcModel: self.dataK as AnyObject);
    }
    
    //MARK: - KVC 监听Model变化->刷新View
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        //print(keyPath);
        //self.asb_handleKeyPathChange(keyPath: keyPath, object: object);
        
        let fullKeyPath = (self.dataK as! NSObject).asb_vc_model_getFullKeyPath(object: object, keyPath: keyPath);
        (self.vcView as! AusbinVcViewDelegate).asb_refreshViews(fullKeyPath: fullKeyPath);
    }
    
    private func addRouterObserver(vcModel : AnyObject){
        let obj = vcModel;
        if(obj is NSNull){
            return;
        }
        let properties : [String:String] = (obj as! NSObject).asb_getProperties()!;
        for property in properties{
            let propertyName = property.key;
            let typeName = property.value;
            if(typeName.contains(ProjectName)){
                //print("<=====");
                self.addRouterObserver(vcModel: obj.value(forKey: propertyName) as AnyObject);
            }
            obj.addObserver(self, forKeyPath:propertyName , options: .new, context: nil);
            print("[Ausbin] ♥️add Observer for propertyName " + propertyName);
        }
    }
    
    private func removeRouterObserver(vcModel : AnyObject){
        let obj = vcModel;
        if(obj is NSNull){
            return;
        }
        let properties : [String:String] = (obj as! NSObject).asb_getProperties()!;
        for property in properties{
            let propertyName = property.key;
            let typeName = property.value;
            if(typeName.contains(ProjectName)){
                //print("<=====");
                self.removeRouterObserver(vcModel: obj.value(forKey: propertyName) as AnyObject);
            }
            obj.removeObserver(self, forKeyPath:propertyName , context: nil);
            print("[Ausbin] 🔥remove Observer for propertyName " + propertyName);
        }
    }

}
