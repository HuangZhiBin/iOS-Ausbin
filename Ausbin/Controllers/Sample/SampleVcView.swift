//
//  SampleVcView.swift
//  Ausbin
//
//  Created by BinHuang on 2018/9/18.
//  Copyright © 2018年 BinHuang. All rights reserved.
//

import UIKit

class SampleVcView: UIView {
    
    let ACTION_CLICK_BTN = UIView.asb_vc_view_generateAction();
    
    private weak var vcRouter : SampleVcRouter!{
        didSet{
            //model初始化view
            self.asb_refreshViews(routerKey: nil);
        }
    }

    //可以将外界的参数传进来
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
            self?.asb_handleAction(action: (self?.ACTION_CLICK_BTN)!, params: [:]);
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

extension SampleVcView : AusbinVcViewDelegate{
    
    func asb_setRouter(router : NSObject){
        self.vcRouter = router as! SampleVcRouter;
    }
    
    func asb_getAvailableActions() -> [String]{
        return [
            ACTION_CLICK_BTN
        ];
    }
    
    func asb_handleAction(action : String, params: [String:Any?]){
        if(self.asb_vc_view_isActionAvailble(action, ACTION_CLICK_BTN)){
            self.vcRouter.handler.changeLevelValue1();
        }
    }
    
    func asb_refreshViews(routerKey: String?){
        if(routerKey == nil || routerKey == #keyPath(SampleVcRouter.dataSet.innerText)){
            self.label.text = self.vcRouter.dataSet.innerText;
        }
    }
}
