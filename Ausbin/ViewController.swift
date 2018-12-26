//
//  ViewController.swift
//  Ausbin
//
//  Created by bin on 2018/12/25.
//  Copyright © 2018年 BinHuang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.title = "Ausbin数据驱动型iOS框架";
        
        self.view.backgroundColor = UIColor.white;
        
        let btn : UIButton = UIButton.init(type: .system);
        btn.frame = CGRect.init(x: 10, y: 240, width: ScreenWidth-20, height: 50);
        btn.layer.masksToBounds = true;
        btn.layer.cornerRadius = 3;
        btn.setTitle("演示", for: .normal);
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.setTitleColor(UIColor.init(hexString: "ffffff"), for: .normal);
        btn.backgroundColor = UIColor.init(hexString: "00a85a");
        self.view.addSubview(btn);
        btn.addTarget(self, action: #selector(self.clickBtn), for: .touchUpInside);
        
        let btn2 : UIButton = UIButton.init(type: .system);
        btn2.frame = CGRect.init(x: 10, y: 300, width: ScreenWidth-20, height: 50);
        btn2.layer.masksToBounds = true;
        btn2.layer.cornerRadius = 3;
        btn2.setTitle("最简单的例子", for: .normal);
        btn2.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn2.setTitleColor(UIColor.init(hexString: "ffffff"), for: .normal);
        btn2.backgroundColor = UIColor.init(hexString: "00a85a");
        self.view.addSubview(btn2);
        btn2.addTarget(self, action: #selector(self.clickBtn2), for: .touchUpInside);
        // Do any additional setup after loading the view.
    }
    
    @objc func clickBtn(){
        self.show(MainViewController(), sender: nil);
    }
    
    @objc func clickBtn2(){
        self.show(SampleViewController(), sender: nil);
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
