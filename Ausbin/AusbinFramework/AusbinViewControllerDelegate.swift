//
//  AusbinViewControllerDelegate.swift
//  Ausbin
//
//  Created by bin on 2018/12/24.
//  Copyright © 2018年 BinHuang. All rights reserved.
//

import UIKit

protocol AusbinViewControllerDelegate: NSObjectProtocol {
    func asb_didWhenViewChange(action : String, params: [Any]);
    func asb_didWhenModelChange(keyPath : String?);
}
