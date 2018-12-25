//
//  MainViewController.swift
//  Hanxin
//
//  Created by iMac on 16/10/12.
//  Copyright © 2016年 Dianbo.co. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    var vcView : MainVcView!;
    var vcService : MainVcService!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.title = "Ausbin数据驱动型iOS框架";
        
        self.vcService = MainVcService();
        
        self.vcView = MainVcView(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height:ScreenHeight-Status_Bar_Height-Navigation_Bar_Height), service: self.vcService);
        self.view.addSubview(self.vcView);
        
        self.asb_addObserverFor(self.vcService.vcModel);
        //self.vcService.vcModel.checkedIndex = 0;
    }
    
    deinit {
        self.asb_removeObserverFor(self.vcService.vcModel);
    }
    
    //MARK: - 监听Model变化->刷新View
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.vcView.asb_needToRefreshViews(object: object, keyPath: keyPath);
    }
}
