//
//  MainVcView.swift
//  Ausbin
//
//  Created by BinHuang on 2018/9/18.
//  Copyright © 2018年 BinHuang. All rights reserved.
//

import UIKit

class MainVcView: UIView {
    
    //action的值可以随意取，但要保证不重复
    let ACTION_CLICK_CENTER_BTN = UIView.asb_vc_view_generateAction();
    let ACTION_CLICK_LEVEL_BTN_1 = UIView.asb_vc_view_generateAction();
    let ACTION_CLICK_LEVEL_BTN_2 = UIView.asb_vc_view_generateAction();
    let ACTION_CLICK_LEVEL_BTN_3 = UIView.asb_vc_view_generateAction();
    let ACTION_SELECT_TABLE_ROW = UIView.asb_vc_view_generateAction();
    
    private weak var vcRouter : MainVcRouter!{
        didSet{
            //model初始化view
            self.asb_refreshViews(routerKey: nil);
        }
    }
    
    let CELL_IDENTIFIER = "cell";

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
        self.addSubview(self.tableView);
        self.tableView.addSubview(self.centerBtn);
        
        self.tableView.addSubview(self.levelLabel1);
        self.tableView.addSubview(self.levelLabel2);
        self.tableView.addSubview(self.levelLabel3);
        self.tableView.addSubview(self.levelBtn1);
        self.tableView.addSubview(self.levelBtn2);
        self.tableView.addSubview(self.levelBtn3);
        
        self.centerBtn.setAction(kUIButtonBlockTouchUpInside, with: {[weak self] () in
            self?.asb_handleAction(action: (self?.ACTION_CLICK_CENTER_BTN)!, params: [:]);
        });
        
        self.levelBtn1.setAction(kUIButtonBlockTouchUpInside, with: {[weak self] () in
            self?.asb_handleAction(action: (self?.ACTION_CLICK_LEVEL_BTN_1)!, params: [:]);
        });
        
        self.levelBtn2.setAction(kUIButtonBlockTouchUpInside, with: {[weak self] () in
            self?.asb_handleAction(action: (self?.ACTION_CLICK_LEVEL_BTN_2)!, params: [:]);
        });
        
        self.levelBtn3.setAction(kUIButtonBlockTouchUpInside, with: {[weak self] () in
            self?.asb_handleAction(action: (self?.ACTION_CLICK_LEVEL_BTN_3)!, params: [:]);
        });
    }
    
    override func layoutSubviews() {
        print("MainVcView layoutSubviews...");
    }
    
    lazy var levelLabel1 : UILabel! = {
        let label = UILabel.init(frame: CGRect.init(x: 10, y: 220, width: ScreenWidth-20, height: 20));
        label.font = UIFont.boldSystemFont(ofSize: 14);
        label.textColor = UIColor.init(hexString: "f03a39");
        return label;
    }();
    
    lazy var levelLabel2 : UILabel! = {
        let label = UILabel.init(frame: CGRect.init(x: 10, y: 320, width: ScreenWidth-20, height: 20));
        label.font = UIFont.boldSystemFont(ofSize: 14);
        label.textColor = UIColor.init(hexString: "0075fa");
        return label;
    }();
    
    lazy var levelLabel3 : UILabel! = {
        let label = UILabel.init(frame: CGRect.init(x: 10, y: 420, width: ScreenWidth-20, height: 20));
        label.font = UIFont.boldSystemFont(ofSize: 14);
        label.textColor = UIColor.init(hexString: "ff416a");
        return label;
    }();
    
    lazy var centerBtn : UIButton! = {
        let btn : UIButton = UIButton.init(type: .system);
        btn.frame = CGRect.init(x: 10, y: 150, width: ScreenWidth-20, height: 50);//CGRect.init(x: (ScreenWidth-40)/3+20, y: 240, width: (ScreenWidth-40)/3, height: 50);
        btn.layer.masksToBounds = true;
        btn.layer.cornerRadius = 3;
        btn.setTitle("更新数组items", for: .normal);
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.setTitleColor(UIColor.init(hexString: "ffffff"), for: .normal);
        btn.backgroundColor = UIColor.init(hexString: "00a85a");
        return btn;
    }();
    
    lazy var levelBtn1 : UIButton! = {
        let btn : UIButton = UIButton.init(type: .system);
        btn.frame = CGRect.init(x: 10, y: 250, width: ScreenWidth-20, height: 50);
        btn.layer.masksToBounds = true;
        btn.layer.cornerRadius = 3;
        btn.setTitle("更新1级子变量innerText", for: .normal);
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.setTitleColor(UIColor.init(hexString: "ffffff"), for: .normal);
        btn.backgroundColor = UIColor.init(hexString: "f03a39");
        return btn;
    }();
    
    lazy var levelBtn2 : UIButton! = {
        let btn : UIButton = UIButton.init(type: .system);
        btn.frame = CGRect.init(x: 10, y: 350, width: ScreenWidth-20, height: 50);
        btn.layer.masksToBounds = true;
        btn.layer.cornerRadius = 3;
        btn.setTitle("更新2级子变量innerText", for: .normal);
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.setTitleColor(UIColor.init(hexString: "ffffff"), for: .normal);
        btn.backgroundColor = UIColor.init(hexString: "0075fa");
        return btn;
    }();
    
    lazy var levelBtn3 : UIButton! = {
        let btn : UIButton = UIButton.init(type: .system);
        btn.frame = CGRect.init(x: 10, y: 450, width: ScreenWidth-20, height: 50);
        btn.layer.masksToBounds = true;
        btn.layer.cornerRadius = 3;
        btn.setTitle("更新3级子变量innerText", for: .normal);
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.setTitleColor(UIColor.init(hexString: "ffffff"), for: .normal);
        btn.backgroundColor = UIColor.init(hexString: "ff416a");
        return btn;
    }();
    
    lazy var tableView: UITableView! = {
        let tableView = UITableView.init(frame: self.bounds, style: .plain);
        let DEFAULT_BG_COLOR : UIColor = UIColor.init(hexString: "f8f8f8");
        
        tableView.backgroundColor = DEFAULT_BG_COLOR;
        tableView.delegate = self;
        tableView.dataSource = self;
        
        if #available(iOS 11, *){
            tableView.estimatedRowHeight = 0;
            tableView.estimatedSectionHeaderHeight = 0;
            tableView.estimatedSectionFooterHeight = 0;
            tableView.contentInsetAdjustmentBehavior = .never;
        }
        
        //创建一个重用的单元格
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: CELL_IDENTIFIER);
        
        if(tableView.responds(to: #selector(setter: UITableView.separatorInset))) {
            tableView.separatorInset = UIEdgeInsets.zero;
        }
        if(tableView.responds(to: #selector(setter: UITableView.layoutMargins))) {
            tableView.layoutMargins = UIEdgeInsets.zero;
        }
        
        return tableView;
    }();
}

extension MainVcView : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.vcRouter == nil){
            return 0;
        }
        return self.vcRouter.dataSet.items.count;
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item : ListItemModel = self.vcRouter.dataSet.items[indexPath.row];
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER, for: indexPath) as! MainTableViewCell;
        
        cell.updateCell(title : item.itemTitle + " "+item.itemContent, content: "单击更新数组items的第" + String(indexPath.row+1) + "个子元素的标题");
        
        cell.selectedBackgroundView = UIView.init(frame: cell.frame);
        cell.selectedBackgroundView?.backgroundColor = UIColor.init(hexString: "f9f9f9");
        if(indexPath.row == self.vcRouter.dataSet.checkedRowIndex.intValue){
            cell.checkImageView.image = UIImage.init(named: "checked");
        }
        else{
            cell.checkImageView.image = UIImage.init(named: "uncheck");
        }
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false);
        print("didSelectRowAt=\(indexPath.row)");
        
        self.asb_handleAction(action: ACTION_SELECT_TABLE_ROW, params: ["index":indexPath.row]);
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //self.overflowView.setNeedsDisplay();
    }

}

extension MainVcView : AusbinVcViewDelegate{
    
    func asb_setRouter(router : NSObject){
        self.vcRouter = router as! MainVcRouter;
    }
    
    func asb_getAvailableActions() -> [String]{
        return [
            ACTION_CLICK_LEVEL_BTN_1,
            ACTION_CLICK_LEVEL_BTN_2,
            //ACTION_CLICK_LEVEL_BTN_3,
            ACTION_CLICK_CENTER_BTN,
            ACTION_SELECT_TABLE_ROW
        ];
    }
    
    func asb_handleAction(action : String, params: [String:Any?]){
        guard (self.asb_vc_view_isActionAvailble(action: action)) else { return; }
        
        if(action == ACTION_CLICK_LEVEL_BTN_1){
            self.vcRouter.handler.changeLevelValue1();
        }
        else if(action == ACTION_CLICK_LEVEL_BTN_2){
            self.vcRouter.handler.changeLevelValue2();
        }
        else if(action == ACTION_CLICK_LEVEL_BTN_3){
            self.vcRouter.handler.changeLevelValue3();
        }
        else if(action == ACTION_CLICK_CENTER_BTN){
            self.showLoadingProgressHUB("请稍等");
            self.vcRouter.handler.webLoadList(success: { () in
                self.hideLoadingProgressHUB();
            }, error: { (errorCode : String, errorMsg : String) in
                self.showProgressHUB(forSuccess: false, message: errorMsg);
            }, fail:{ () in
                self.showProgressHUB(forSuccess: false, message: "网络繁忙，请重试");
            });
        }
        else if(action == ACTION_SELECT_TABLE_ROW){
            print(params["index"] as! Int);
            let indexValue = params["index"] as! Int;
            self.vcRouter.handler.changeTableValue(index: indexValue);
        }
    }
    
    func asb_refreshViews(routerKey: String?){
        
        if(routerKey == nil || routerKey == #keyPath(MainVcRouter.dataSet.items)){
            self.tableView.reloadData();
        }
        
        if(routerKey == nil || routerKey == #keyPath(MainVcRouter.dataSet.innerText1)){
            self.levelLabel1.text = self.vcRouter.dataSet.innerText1;
        }
        
        if(routerKey == nil || routerKey == #keyPath(MainVcRouter.dataSet.innerText2)){
            self.levelLabel2.text = self.vcRouter.dataSet.innerText2;
        }
        
        if(routerKey == nil || routerKey == #keyPath(MainVcRouter.dataSet.innerText3)){
            self.levelLabel3.text = self.vcRouter.dataSet.innerText3;
        }
    }
}
