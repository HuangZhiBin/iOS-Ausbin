//
//  AusbinVcViewDelegate.swift
//  Ausbin
//
//  Created by bin on 2018/12/24.
//  Copyright © 2018年 BinHuang. All rights reserved.
//
import UIKit
protocol AusbinVcViewDelegate : NSObjectProtocol{
    func asb_getActions() -> [String];
    func asb_needToRefreshViews(object: Any?, keyPath : String?);
    func asb_handleAction(action : String, params: [Any]);
}
