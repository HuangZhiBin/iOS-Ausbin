//
//  NSObject+Fields.swift
//  Ausbin
//
//  Created by bin on 2018/12/25.
//  Copyright © 2018年 BinHuang. All rights reserved.
//

import Foundation

/// 如果需要用对应的类型，字典定义Dictionary<String, Any>，对应value为Int8.self、Int16.self，下面用到的方法都需要更改为Dictionary<String, Any>
let valueTypesMap: Dictionary<String, String> = [
    "c" : "Int8",
    "s" : "Int16",
    "i" : "Int32",
    "q" : "Int", //also: Int64, NSInteger, only true on 64 bit platforms
    "S" : "UInt16",
    "I" : "UInt32",
    "Q" : "UInt", //also UInt64, only true on 64 bit platforms
    "B" : "Bool",
    "d" : "Double",
    "f" : "Float",
    "{" : "Decimal"
]

//private var keyPathsKey: Void?

/**
 ViewController的Model的扩展方法
 */
extension NSObject{
//
//    var abs_keyPathsDict : [String : Any]? {
//        get {
//            return objc_getAssociatedObject(self, &keyPathsKey) as? [String : Any];
//        }
//        set(newValue) {
//            objc_setAssociatedObject(self, &keyPathsKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//        }
//    };

    func asb_vc_model_getFullKeyPath(object: Any?, keyPath : String?) -> String?{
        if(object == nil){
            return nil;
        }
        if (object as! NSObject) == self{
            return keyPath;
        }
        var fullKeyPath = "";
        var count = UInt32()
        guard let properties = class_copyPropertyList(self.classForCoder, &count) else { return nil }
        for i in 0..<Int(count) {
            let property: objc_property_t = properties[i]
            /// 获取属性名
            guard let name = getNameOf(property: property)
                else { continue }
            /// 获取属性类型
            let type : String = getTypeOf(property: property)!
            if(type.contains(ProjectName)){
                let childObject = self.value(forKey: name);
                if(childObject != nil){
                    fullKeyPath = findKeyPath(childKeyPath: name, childObject: childObject as AnyObject, parentObject: object as AnyObject);
                }
                
            }
        }
        free(properties)
        if(fullKeyPath != ""){
            fullKeyPath = fullKeyPath + "." + keyPath!;
        }
        return fullKeyPath;
    }
    
    private func findKeyPath(childKeyPath: String, childObject: AnyObject?, parentObject: AnyObject?) -> String{
        if(childObject == nil){
            return "";
        }
        if(childObject === parentObject){
            return childKeyPath;
        }
        var fullKeyPath = "";
        var count = UInt32();
        guard let properties = class_copyPropertyList(childObject?.classForCoder, &count) else { return fullKeyPath }
        for i in 0..<Int(count) {
            let property: objc_property_t = properties[i]
            /// 获取属性名
            guard let name = getNameOf(property: property)
                else { continue }
            /// 获取属性类型
            let type : String = getTypeOf(property: property)!
            if(type.contains(ProjectName)){
                let childChildObject = childObject?.value(forKey: name);
                let tmpKeyPath = findKeyPath(childKeyPath: name, childObject: childChildObject as AnyObject, parentObject: parentObject);
                if(tmpKeyPath != ""){
                    if(fullKeyPath == ""){
                        fullKeyPath = childKeyPath;
                    }
                    fullKeyPath = fullKeyPath + (tmpKeyPath != "" ? ("." + tmpKeyPath) : "");
                }
            }
        }
        free(properties)
        return fullKeyPath;
    }
    
    /// 获取继承自该类的所有子类
    ///
    /// - Returns: 子类名称数组
    private func subclasses() -> [NSString] {
        var count: UInt32 = 0, result: [NSString] = []
        let allClasses = objc_copyClassList(&count)!
        
        for n in 0 ..< count {
            let someClass: AnyClass = allClasses[Int(n)]
            guard let someSuperClass = class_getSuperclass(someClass), String(describing: someSuperClass) == String(describing: self) else { continue }
            //返回的类会带module名，如果把module名截取了，就无法转换成对应的类了
            let className: NSString = NSStringFromClass(someClass) as NSString
            
            result.append(className)
        }
        return result
    }

}
