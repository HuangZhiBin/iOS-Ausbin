//
//  MyNavigationBar.swift
//  Languages
//
//  Created by bin on 2017/9/28.
//  Copyright © 2017年 Dianbo.co. All rights reserved.
//

import UIKit

class MyNavigationBar: UINavigationBar {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if #available(iOS 11, *){
            for aView in self.subviews {
                if NSStringFromClass(type(of: aView)) == "_UINavigationBarContentView" {
                    aView.frame = CGRect(x: 0, y: Status_Bar_Height, width: aView.frame.width, height: aView.frame.height)
                }
                else if NSStringFromClass(type(of: aView)) == "_UIBarBackground" {
                    aView.frame = CGRect(x: 0, y: 0, width: aView.frame.width, height: self.frame.height)
                }
            }
        }
        
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
