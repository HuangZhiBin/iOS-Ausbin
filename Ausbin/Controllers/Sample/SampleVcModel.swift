//
//  SampleVcModel.swift
//  Ausbin
//
//  Created by BinHuang on 2018/9/18.
//  Copyright © 2018年 BinHuang. All rights reserved.
//

import UIKit

class SampleVcModel: NSObject {
    
    // [Ausbin] 必须为变量添加objc特性支持KVC:@objc dynamic
    @objc dynamic var innerText : String! = "这是最初始的值:0";
    
}
