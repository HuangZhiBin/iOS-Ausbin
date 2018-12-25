//
//  NSObject+VcRouter+Ausbin.swift
//  Ausbin
//
//  Created by bin on 2018/12/25.
//  Copyright © 2018年 BinHuang. All rights reserved.
//

import UIKit

extension NSObject {
    func asb_vc_router_addObserver(vcModel : AnyObject){
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
                asb_vc_router_addObserver(vcModel: obj.value(forKey: propertyName) as AnyObject);
            }
            obj.addObserver(self, forKeyPath:propertyName , options: .new, context: nil);
            print("[Ausbin] ♥️add Observer for propertyName " + propertyName);
        }
    }
    
    func asb_vc_router_removeObserver(vcModel : AnyObject){
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
                asb_vc_router_removeObserver(vcModel: obj.value(forKey: propertyName) as AnyObject);
            }
            obj.removeObserver(self, forKeyPath:propertyName , context: nil);
            print("[Ausbin] 🔥remove Observer for propertyName " + propertyName);
        }
    }
    
    func asb_vc_router_getKeyPath(obj : Any?) -> String? {
        let properties : [String:String] = self.asb_getProperties()!;//getAllProperties(obj: obj);
        for property in properties{
            let propertyName = property.key;
            //let typeName = property.value;
            let isTheSameProperty : Bool = ((self.value(forKey: propertyName) as AnyObject) === (obj as AnyObject));
            if(isTheSameProperty){
                return propertyName;
            }
        }
        return nil;
    }
}
