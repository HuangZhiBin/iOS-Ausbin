//
//  MainViewController.swift
//  Ausbin
//
//  Created by iMac on 16/10/12.
//  Copyright © 2016年 Dianbo.co. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var vcView : MainVcView!;
    var vcRouter : MainVcRouter!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.title = "演示";
        
        //初始化vcView
        self.vcView = MainVcView(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height:ScreenHeight-Status_Bar_Height-Navigation_Bar_Height));
        self.view.addSubview(self.vcView);
        
        //初始化vcRouter
        self.vcRouter = MainVcRouter.init(vcView: self.vcView);
    }
    
    deinit {
        //清除vcRouter
        self.vcRouter.deinitRouter();
    }
}
