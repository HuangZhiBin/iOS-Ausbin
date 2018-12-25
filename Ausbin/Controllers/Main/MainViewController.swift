//
//  MainViewController.swift
//  Hanxin
//
//  Created by iMac on 16/10/12.
//  Copyright © 2016年 Dianbo.co. All rights reserved.
//

import UIKit

class MainViewController: UIViewController,AusbinVcViewChangeDelegate {
    
    var vcService : MainVcService!;
    var vcView : MainVcView!;
    var vcModel : MainVcModel!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.title = "Ausbin数据驱动型iOS框架";
        
        self.vcModel = MainVcModel(coder: nil);
        
        self.vcView = MainVcView(frame: CGRect.init(x: 0, y: 0, width: ScreenWidth, height:ScreenHeight-Status_Bar_Height-Navigation_Bar_Height), model:self.vcModel);
        self.vcView.asb_viewChangeDelegate = self;
        self.view.addSubview(self.vcView);
        
        self.vcService = MainVcService(model:self.vcModel);
        
        self.asb_addObserverFor(self.vcModel);
        self.asb_addObserverFor(self.vcModel.childModel);
    }
    
    deinit {
        self.asb_removeObserverFor(self.vcModel);
        self.asb_removeObserverFor(self.vcModel.childModel);
    }
    
    //MARK: - 监听Model变化->刷新View
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if((object as! NSObject) == self.vcModel){
            self.asb_didWhenModelChange(keyPath: keyPath);
        }
        else if((object as! NSObject) == self.vcModel.childModel){
            self.asb_didWhenModelChange(keyPath: "childModel." + keyPath!);
        }
//        var targetKeyPath = keyPath;
//        if((object as AnyObject?) === (self.vcModel as! MainVcModel).egg){
//            targetKeyPath = "egg." + keyPath!;
//        }
//        self.asb_didWhenModelChange(keyPath: keyPath);
    }
    
    //MARK: - 监听View事件->更新Model数据
    func asb_viewDidChanged(action: String, params: [Any]) {
        self.asb_didWhenViewChange(action: action, params: params);
    }
}

//MARK: - Model <-> View交互
extension MainViewController : AusbinViewControllerDelegate{
    func asb_didWhenViewChange(action : String, params: [Any]){
        if(action == self.vcView.ACTION_CLICK_LEFT_BTN){
            self.vcService.changeTopValue();
        }
        else if(action == self.vcView.ACTION_CLICK_CENTER_BTN){
            self.view.showLoadingProgressHUB("请稍等");
            self.vcService.webLoadList(success: { () in
                self.view.hideLoadingProgressHUB();
            }, error: { (errorCode : String, errorMsg : String) in
                self.view.showProgressHUB(forSuccess: false, message: errorMsg);
            }, fail:{ () in
                self.view.showProgressHUB(forSuccess: false, message: "网络繁忙，请重试");
            });
        }
        else if(action == self.vcView.ACTION_CLICK_RIGHT_BTN){
            self.vcService.changeBottomValue();
        }
        else if(action == self.vcView.ACTION_SELECT_TABLE_ROW){
            print(params[0] as! Int);
            let value = params[0] as! Int;
            self.vcService.changeTableValue(index: value);
        }
    }
    
    func asb_didWhenModelChange(keyPath : String?){
        self.vcView.asb_needToRefreshViews(keyPath: keyPath);
    }
}
