//
//  SampleVcService.swift
//  Ausbin
//
//  Created by BinHuang on 2018/9/18.
//  Copyright © 2018年 BinHuang. All rights reserved.
//

import UIKit

class SampleVcService: NSObject {
    
    var vcModel: SampleVcModel!;
    
    override init() {
        super.init();
        self.vcModel = SampleVcModel();
    }
    
    func changeLevelValue1(){
        let now = Date()
        let timeInterval: TimeInterval = now.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        self.vcModel.innerText = "最新的innerText的值:"+String(millisecond);
    }
}
