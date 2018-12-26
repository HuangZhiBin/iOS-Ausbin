//
//  SampleVcView.swift
//  Ausbin
//
//  Created by BinHuang on 2018/9/18.
//  Copyright © 2018年 BinHuang. All rights reserved.
//

import UIKit

class SampleVcView: UIView {
    
    // [Ausbin] 为每一个UI响应事件添加action(前提是这个action的触发会更新model的数据)
    let ACTION_CLICK_BTN = UIView.asb_vc_view_generateAction();
    
    // [Ausbin] vcRouter实例，定义为weak防止强制持有
    private weak var vcRouter : SampleVcRouter!{
        didSet{
            // [Ausbin] model初始化view
            self.asb_refreshViews(routerKey: nil);
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

// [Ausbin] 必须为VcView实现AusbinVcViewDelegate代理
// MARK: - 实现AusbinVcViewDelegate代理
extension SampleVcView : AusbinVcViewDelegate{
    
    // [Ausbin] 引入外部vcRouter
    func asb_setRouter(router : NSObject){
        self.vcRouter = router as! SampleVcRouter;
    }
    
    // [Ausbin] 定义可执行的action数组，没有设置可行的action将无法更新model
    func asb_getAvailableActions() -> [String]{
        return [
            ACTION_CLICK_BTN
        ];
    }
    
    // [Ausbin] 接受vcView的action事件，并让vcRouter作出相应的处理(即vcRouter调用vcService的接口更新数据)
    func asb_handleAction(action : String, params: [String:Any?]){
        // [Ausbin] 必须判断该action的有效性
        if(self.asb_vc_view_isActionAvailble(action, ACTION_CLICK_BTN)){
            self.vcRouter.handler.changeInnerText();
        }
    }
    
    // [Ausbin] 接受vcRouter的UI更新请求，并让vcView作出相应的UI刷新操作
    func asb_refreshViews(routerKey: String?){
        if(routerKey == nil || routerKey == #keyPath(SampleVcRouter.dataSet.innerText)){
            self.label.text = self.vcRouter.dataSet.innerText;
        }
    }
}
