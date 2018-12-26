//
//  AusbinVcRouterDelegate.swift
//  Ausbin
//
//  Created by bin on 2018/12/26.
//  Copyright © 2018年 BinHuang. All rights reserved.
//

import UIKit
protocol AusbinVcRouterDelegate : NSObjectProtocol{
    func asb_handleKeyPathChange(keyPath: String?, object: Any?);
    func asb_deinitRouter();
}
