//
//  NSObject+AusbinVcService.swift
//  Ausbin
//
//  Created by bin on 2018/12/24.
//  Copyright © 2018年 BinHuang. All rights reserved.
//

import UIKit

private var actionsKey: Void?
private var viewChangeKey: Void?

extension UIView {
    
    private var asb_actions : [String]? {
        get {
            return objc_getAssociatedObject(self, &actionsKey) as? [String];
        }
        set(newValue) {
            objc_setAssociatedObject(self, &actionsKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    };
    
    var asb_viewChangeDelegate : AusbinVcViewChangeDelegate? {
        get {
            return objc_getAssociatedObject(self, &viewChangeKey) as? AusbinVcViewChangeDelegate;
        }
        set(newValue) {
            objc_setAssociatedObject(self, &viewChangeKey, newValue, .OBJC_ASSOCIATION_ASSIGN);
        }
    };
    
    //MARK: - 自定义方法
    func asb_isAvailable(action: String) -> Bool {
        if(self.asb_actions != nil){
            return self.asb_actions!.contains(action);
        }
        return false;
    }
    
    func asb_setAction(_ initActions: [String]) {
        self.asb_actions = initActions;
    }

}
