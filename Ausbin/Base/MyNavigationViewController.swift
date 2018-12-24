//
//  MyNavigationViewController.swift
//  Hanxin
//
//  Created by iMac on 16/10/12.
//  Copyright © 2016年 Dianbo.co. All rights reserved.
//

import UIKit

class MyNavigationViewController: UINavigationController,UINavigationControllerDelegate {
    
    let BAR_BACK_COLOR = UIColor.init(red: 252.0/255.0, green: 252.0/255.0, blue: 252.0/255.0, alpha: 1);
    
    let TINT_COLOR = UIColor.init(red: 80.0/255.0, green: 80.0/255.0, blue: 80.0/255.0, alpha: 1);

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self;
        
//        self.navigationBar.backgroundColor = BAR_BACK_COLOR
        self.navigationBar.barTintColor = BAR_BACK_COLOR;
        self.navigationBar.tintColor = TINT_COLOR;
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        let textAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.black,
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18)
            ] as [NSAttributedStringKey : Any]
        self.navigationBar.titleTextAttributes = textAttributes
        self.navigationBar.isTranslucent = false;
 
        //去掉NavigationBar底部的那条黑线
//        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        self.navigationBar.shadowImage = UIImage()
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool){
        let backButton : UIBarButtonItem = UIBarButtonItem.init(title: "", style: .plain, target: nil, action: nil);
        
        let imageNormal = UIImage.init(named: "icon_backward")?.resizableImage(withCapInsets: UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: -10));
        backButton.setBackgroundImage(imageNormal, for: .normal, barMetrics: .default);
//        backButton.setBackButtonBackgroundImage(imageNormal, for: .normal, barMetrics: .default)
//        backButton.setBackButtonBackgroundImage(imageNormal, for: .highlighted, barMetrics: .default)
//        backButton.setTitlePositionAdjustment(UIOffset.init(horizontal: 0, vertical: -40), for: .default)
//        viewController.navigationItem.hidesBackButton = true;
        viewController.navigationItem.backBarButtonItem = backButton;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
