//
//  SampleVcService.swift
//  Ausbin
//
//  Created by BinHuang on 2018/9/18.
//  Copyright © 2018年 BinHuang. All rights reserved.
//

import UIKit

// vcService单纯地操作model，不做其他任何处理，包括view、router的操作
class SampleVcService: NSObject {
    
    // [Ausbin] 必须为变量vcModel添加objc特性支持KVC:@objc
    @objc var vcModel: SampleVcModel!;
    
    override init() {
        super.init();
        // [Ausbin] 初始化vcModel
        self.vcModel = SampleVcModel();
    }
    
    // [Ausbin] 提供修改model的接口
    func changeInnerText(){
        let now = Date()
        let timeInterval: TimeInterval = now.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        self.vcModel.innerText = "最新的innerText的值:"+String(millisecond);
    }
}
