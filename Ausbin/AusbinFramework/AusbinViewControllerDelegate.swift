//
//  AusbinViewControllerDelegate.swift
//  Acupuncture
//
//  Created by bin on 2018/12/24.
//  Copyright © 2018年 TechTCM. All rights reserved.
//

import UIKit

protocol AusbinViewControllerDelegate: NSObjectProtocol {
    func asb_didWhenViewChange(action : String, params: [Any]);
    func asb_didWhenModelChange(keyPath : String?);
}
