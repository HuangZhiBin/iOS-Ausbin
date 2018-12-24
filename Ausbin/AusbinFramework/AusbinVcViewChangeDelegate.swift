//
//  AusbinVcViewChangeDelegate.swift
//  Acupuncture
//
//  Created by bin on 2018/12/24.
//  Copyright © 2018年 TechTCM. All rights reserved.
//

import UIKit

protocol AusbinVcViewChangeDelegate : NSObjectProtocol{
    func asb_viewDidChanged(action: String, params: [Any]);
}
