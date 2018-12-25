//
//  UIViewController+Ausbin.swift
//  Ausbin
//
//  Created by bin on 2018/12/24.
//  Copyright © 2018年 BinHuang. All rights reserved.
//

import UIKit

/**
 ViewController的扩展方法
 */
extension UIViewController{
    
    func asb_addObserver(vcModel : AnyObject){
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
                asb_addObserver(vcModel: obj.value(forKey: propertyName) as AnyObject);
            }
            obj.addObserver(self, forKeyPath:propertyName , options: .new, context: nil);
            print("[Ausbin] ♥️add Observer for propertyName " + propertyName);
        }
    }
    
    func asb_removeObserver(vcModel : AnyObject){
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
                asb_removeObserver(vcModel: obj.value(forKey: propertyName) as AnyObject);
            }
            obj.removeObserver(self, forKeyPath:propertyName , context: nil);
            print("[Ausbin] 🔥remove Observer for propertyName " + propertyName);
        }
    }
    
    /*
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
    */
}
