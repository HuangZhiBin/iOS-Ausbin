//
//  NSObject+Property.swift
//  Ausbin
//
//  Created by bin on 2018/12/25.
//  Copyright © 2018年 BinHuang. All rights reserved.
//

import UIKit

extension NSObject {
    /// 获取属性名和类型列表
    ///
    /// - Returns: 属性名和类型的字典
    func asb_getProperties() -> Dictionary<String, String>? {
        var count = UInt32()
        guard let properties = class_copyPropertyList(self.classForCoder, &count) else { return nil }
        var types: Dictionary<String, String> = [:]
        for i in 0..<Int(count) {
            let property: objc_property_t = properties[i]
            /// 获取属性名
            guard let name = getNameOf(property: property)
                else { continue }
            /// 获取属性类型
            let type = getTypeOf(property: property)
            types[name] = type
            //            print(name);
            //            print(type!);
            //            print("=====");
        }
        free(properties)
        return types
    }
    
    /// 获取属性名
    ///
    /// - Parameter property: 属性对象
    /// - Returns: 属性名
    func getNameOf(property: objc_property_t) -> String? {
        guard
            let name: NSString = NSString(utf8String: property_getName(property))
            else { return nil }
        return name as String
    }
    
    /// attributes对应的类型
    ///
    /// - Parameter attributes: attributes
    /// - Returns: 类型名
    private func valueType(withAttributes attributes: String) -> String? {
        let tmp = attributes as NSString
        let letter = tmp.substring(with: NSMakeRange(1, 1))
        guard let type = valueTypesMap[letter] else { return nil }
        return type
    }
    
    /// 获取属性类型
    ///
    /// - Parameter property: 属性对象
    /// - Returns: 属性类型
    func getTypeOf(property: objc_property_t) -> String? {
        guard let attributesAsNSString: NSString = NSString(utf8String: property_getAttributes(property)!) else { return nil }
        let attributes = attributesAsNSString as String
        let slices = attributes.components(separatedBy: "\"")
        guard slices.count > 1 else { return valueType(withAttributes: attributes) }
        let objectClassName = slices[1]
        return objectClassName
    }
}
