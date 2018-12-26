//
//  SampleViewController.swift
//  Ausbin
//
//  Created by iMac on 16/10/12.
//  Copyright © 2016年 Dianbo.co. All rights reserved.
//

import UIKit

class SampleViewController: UIViewController {
    
    var vcView : SampleVcView!;
    var vcRouter : SampleVcRouter!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.title = "最简单的例子";
        
        self.vcView = SampleVcView(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height:ScreenHeight-Status_Bar_Height-Navigation_Bar_Height));
        self.view.addSubview(self.vcView);
        
        // [Ausbin] 初始化vcRouter
        self.vcRouter = SampleVcRouter.init(vcView: self.vcView);
    }
    
    deinit {
        // [Ausbin] 清除vcRouter
        self.vcRouter.asb_deinitRouter();
    }
}
