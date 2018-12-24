//
//  UIViewController+Ausbin.swift
//  Ausbin
//
//  Created by bin on 2018/12/24.
//  Copyright © 2018年 BinHuang. All rights reserved.
//

import UIKit

private var actionsKey: Void?

extension UIViewController{
    
    private var asb_actions : [String]? {
        get {
            return objc_getAssociatedObject(self, &actionsKey) as? [String];
        }
        set(newValue) {
            objc_setAssociatedObject(self, &actionsKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    };
    
    func asb_addObserverFor(_ obj : AnyObject){
        let properties : [String] = getAllProperties(obj: obj);
        for property in properties{
            obj.addObserver(self, forKeyPath:property , options: .new, context: nil);
        }
    }
    
    func asb_removeObserverFor(_ obj : AnyObject){
        let properties : [String] = getAllProperties(obj: obj);
        for property in properties{
            obj.removeObserver(self, forKeyPath:property , context: nil);
        }
    }
    
    private func getAllProperties(obj : AnyObject) -> [String]{
        var properties : [String] = [];
        var count: UInt32 = 0
        //获取类的属性列表,返回属性列表的数组,可选项
        
        let list = class_copyPropertyList(obj.classForCoder, &count)
        print("属性个数:\(count)")
        //遍历数组
        for i in 0..<Int(count) {
            //根据下标获取属性
            let pty = list?[i]
            //获取属性的名称<C语言字符串>
            //转换过程:Int8 -> Byte -> Char -> C语言字符串
            let cName = property_getName(pty!)
            //转换成String的字符串
            let name = String(utf8String: cName)
//            print("field=" + name!);
            properties.append(name!);
            
            let dName = property_getAttributes(pty!)
            //转换成String的字符串
            let name2 = String(utf8String: dName!)
            print("[Property]field=" + name! + "; prop=" + name2!);
        }
        free(list) //释放list
        return properties;
    }
    
}
