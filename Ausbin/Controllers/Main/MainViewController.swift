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
    var vcService : MainVcService!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.title = "演示";
        
        //初始化vcService
        self.vcService = MainVcService();
        
        //初始化vcView
        self.vcView = MainVcView(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height:ScreenHeight-Status_Bar_Height-Navigation_Bar_Height), service: self.vcService);
        self.view.addSubview(self.vcView);
        
        //MARK: - 开始监听vcModel的数据改变(+KVC)
        self.asb_addObserver(vcModel: self.vcService.vcModel);
    }
    
    deinit {
        //MARK: - 解除监听vcModel的数据改变(-KVC)
        self.asb_removeObserver(vcModel: self.vcService.vcModel);
    }
    
    //MARK: - KVC 监听Model变化->刷新View
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.vcView.asb_needToRefreshViews(object: object, keyPath: keyPath);
    }
}
