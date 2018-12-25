//
//  Constants.swift
//  Ausbin
//
//  Created by bin on 2018/12/25.
//  Copyright © 2018年 BinHuang. All rights reserved.
//

import UIKit

let ProjectName : String = Bundle.main.infoDictionary!["CFBundleExecutable"]! as! String;

let ScreenWidth : CGFloat = UIScreen.main.bounds.size.width;
let ScreenHeight : CGFloat = UIScreen.main.bounds.size.height;

struct Platform {
    static let isIphoneX: Bool = {
        if(UIScreen.main.bounds.width == 375 && UIScreen.main.bounds.height == 812) {
            return true;
        }
        return false;
    }();
    
}

let Status_Bar_Height : CGFloat = Platform.isIphoneX ? 44 : 20;
let Navigation_Bar_Height : CGFloat = 44;
let Tab_Bar_Height : CGFloat = Platform.isIphoneX ? 83 : 49;
let Tab_Bar_Add_Height_Iphonex : CGFloat = 34;
let Status_Bar_Add_Height_Iphonex : CGFloat = 24;
let NETWORK_TIMEOUT : Int = 15;

