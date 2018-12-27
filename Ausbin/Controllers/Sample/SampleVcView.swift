//
//  SampleVcView.swift
//  Ausbin
//
//  Created by BinHuang on 2018/9/18.
//  Copyright © 2018年 BinHuang. All rights reserved.
//

import UIKit

class SampleVcView: UIView {
    
    // [Ausbin] vcRouter实例，定义为weak防止强制持有
    @objc weak var vcRouter : SampleVcRouter!{
        didSet{
            // [Ausbin] model初始化view
            self.asb_refreshViews(fullKeyPath: nil);
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame);
        self.initAllViews();
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!;
    }
    
    func initAllViews(){
        self.backgroundColor = UIColor.white;
        
        self.addSubview(self.label);
        self.addSubview(self.btn);
        
        self.btn.setAction(kUIButtonBlockTouchUpInside, with: {[weak self] () in
            self?.vcRouter.handler.changeInnerText();
        });
    }
    
    lazy var label : UILabel! = {
        let label = UILabel.init(frame: CGRect.init(x: 10, y: 220, width: ScreenWidth-20, height: 20));
        label.font = UIFont.boldSystemFont(ofSize: 14);
        label.textColor = UIColor.init(hexString: "f03a39");
        return label;
    }();
    
    lazy var btn : UIButton! = {
        let btn : UIButton = UIButton.init(type: .system);
        btn.frame = CGRect.init(x: 10, y: 250, width: ScreenWidth-20, height: 50);
        btn.layer.masksToBounds = true;
        btn.layer.cornerRadius = 3;
        btn.setTitle("更新innerText", for: .normal);
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.setTitleColor(UIColor.init(hexString: "ffffff"), for: .normal);
        btn.backgroundColor = UIColor.init(hexString: "f03a39");
        return btn;
    }();
}

// [Ausbin] 必须为VcView实现AusbinVcViewDelegate代理
extension SampleVcView : AusbinVcViewDelegate{
    
    // [Ausbin] 接受vcRouter的UI更新请求，并让vcView作出相应的UI刷新操作
    func asb_refreshViews(fullKeyPath: String?){
        if(fullKeyPath == nil || fullKeyPath == "innerText"){
            self.label.text = self.vcRouter.dataSet.innerText;
        }
    }
}
