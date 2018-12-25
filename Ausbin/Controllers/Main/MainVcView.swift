//
//  MainVcView.swift
//  Ausbin
//
//  Created by BinHuang on 2018/9/18.
//  Copyright © 2018年 BinHuang. All rights reserved.
//

import UIKit

class MainVcView: UIView {
    
    let ACTION_CLICK_CENTER_BTN = "click center button to change table";
    let ACTION_CLICK_LEVEL_BTN_1 = "click level button 1 to change level 1 property's value";
    let ACTION_CLICK_LEVEL_BTN_2 = "click level button 2 to change level 2 property's value";
    let ACTION_CLICK_LEVEL_BTN_3 = "click level button 3 to change level 3 property's value";
    let ACTION_CLICK_LEVEL_BTN_4 = "click level button 4 to change level 4 property's value";
    let ACTION_SELECT_TABLE_ROW = "select one table row";
    
    var vcService : MainVcService! //可读，不可改变对象的值
    
    let CELL_IDENTIFIER = "cell";

    //可以将外界的参数传进来
    init(frame: CGRect, service: MainVcService) {
        super.init(frame: frame);
        self.vcService = service;
        self.initAllViews();
        self.asb_needToRefreshViews(object: nil, keyPath: nil);//根据model初始化view
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
        self.tableView.addSubview(self.levelLabel4);
        self.tableView.addSubview(self.levelBtn1);
        self.tableView.addSubview(self.levelBtn2);
        self.tableView.addSubview(self.levelBtn3);
        self.tableView.addSubview(self.levelBtn4);
        
        self.centerBtn.setAction(kUIButtonBlockTouchUpInside, with: {[weak self] () in
            self?.asb_handleAction(action: (self?.ACTION_CLICK_CENTER_BTN)!, params: []);
        });
        
        self.levelBtn1.setAction(kUIButtonBlockTouchUpInside, with: {[weak self] () in
            self?.asb_handleAction(action: (self?.ACTION_CLICK_LEVEL_BTN_1)!, params: []);
        });
        
        self.levelBtn2.setAction(kUIButtonBlockTouchUpInside, with: {[weak self] () in
            self?.asb_handleAction(action: (self?.ACTION_CLICK_LEVEL_BTN_2)!, params: []);
        });
        
        self.levelBtn3.setAction(kUIButtonBlockTouchUpInside, with: {[weak self] () in
            self?.asb_handleAction(action: (self?.ACTION_CLICK_LEVEL_BTN_3)!, params: []);
        });
        
        self.levelBtn4.setAction(kUIButtonBlockTouchUpInside, with: {[weak self] () in
            self?.asb_handleAction(action: (self?.ACTION_CLICK_LEVEL_BTN_4)!, params: []);
        });
    }
    
    override func layoutSubviews() {
        print("layoutSubviews...");
    }
    
    lazy var levelLabel1 : UILabel! = {
        let label = UILabel.init(frame: CGRect.init(x: 10, y: 210, width: ScreenWidth-20, height: 20));
        label.font = UIFont.boldSystemFont(ofSize: 14);
        label.textColor = UIColor.init(hexString: "f03a39");
        return label;
    }();
    
    lazy var levelLabel2 : UILabel! = {
        let label = UILabel.init(frame: CGRect.init(x: 10, y: 310, width: ScreenWidth-20, height: 20));
        label.font = UIFont.boldSystemFont(ofSize: 14);
        label.textColor = UIColor.init(hexString: "0075fa");
        return label;
    }();
    
    lazy var levelLabel3 : UILabel! = {
        let label = UILabel.init(frame: CGRect.init(x: 10, y: 410, width: ScreenWidth-20, height: 20));
        label.font = UIFont.boldSystemFont(ofSize: 14);
        label.textColor = UIColor.init(hexString: "ff416a");
        return label;
    }();
    
    lazy var levelLabel4 : UILabel! = {
        let label = UILabel.init(frame: CGRect.init(x: 10, y: 510, width: ScreenWidth-20, height: 20));
        label.font = UIFont.boldSystemFont(ofSize: 14);
        label.textColor = UIColor.init(hexString: "d75201");
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
        btn.frame = CGRect.init(x: 10, y: 240, width: ScreenWidth-20, height: 50);
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
        btn.frame = CGRect.init(x: 10, y: 340, width: ScreenWidth-20, height: 50);
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
        btn.frame = CGRect.init(x: 10, y: 440, width: ScreenWidth-20, height: 50);
        btn.layer.masksToBounds = true;
        btn.layer.cornerRadius = 3;
        btn.setTitle("更新3级子变量innerText", for: .normal);
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.setTitleColor(UIColor.init(hexString: "ffffff"), for: .normal);
        btn.backgroundColor = UIColor.init(hexString: "ff416a");
        return btn;
    }();
    
    lazy var levelBtn4 : UIButton! = {
        let btn : UIButton = UIButton.init(type: .system);
        btn.frame = CGRect.init(x: 10, y: 540, width: ScreenWidth-20, height: 50);
        btn.layer.masksToBounds = true;
        btn.layer.cornerRadius = 3;
        btn.setTitle("更新4级子变量innerText", for: .normal);
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.setTitleColor(UIColor.init(hexString: "ffffff"), for: .normal);
        btn.backgroundColor = UIColor.init(hexString: "d75201");
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
        if(self.vcService.vcModel == nil){
            return 0;
        }
        return self.vcService.vcModel.items.count;
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
        let item : ListItemModel = self.vcService.vcModel.items[indexPath.row];
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER, for: indexPath) as! MainTableViewCell;
        
        cell.updateCell(title : item.itemTitle + " "+item.itemContent, content: "单击更新数组items的第" + String(indexPath.row+1) + "个子元素的标题");
        
        cell.selectedBackgroundView = UIView.init(frame: cell.frame);
        cell.selectedBackgroundView?.backgroundColor = UIColor.init(hexString: "f9f9f9");
        if(indexPath.row == self.vcService.vcModel.checkedIndex.intValue){
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
        
        self.asb_handleAction(action: ACTION_SELECT_TABLE_ROW, params: [indexPath.row]);
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //self.overflowView.setNeedsDisplay();
    }

}

extension MainVcView : AusbinVcViewDelegate{
    
    func asb_getActions() -> [String]{
        return [self.ACTION_CLICK_LEVEL_BTN_1, ACTION_CLICK_CENTER_BTN, ACTION_CLICK_LEVEL_BTN_2, ACTION_CLICK_LEVEL_BTN_3, ACTION_CLICK_LEVEL_BTN_4, ACTION_SELECT_TABLE_ROW];
    }
    
    func asb_handleAction(action : String, params: [Any]){
        if(self.asb_isActionAvailble(action: action, targetAction: ACTION_CLICK_LEVEL_BTN_1)){
            self.vcService.changeLevelValue1();
        }
        else if(self.asb_isActionAvailble(action: action, targetAction: ACTION_CLICK_LEVEL_BTN_2)){
            self.vcService.changeLevelValue2();
        }
        else if(self.asb_isActionAvailble(action: action, targetAction: ACTION_CLICK_LEVEL_BTN_3)){
            self.vcService.changeLevelValue3();
        }
        else if(self.asb_isActionAvailble(action: action, targetAction: ACTION_CLICK_LEVEL_BTN_4)){
            self.vcService.changeLevelValue4();
        }
        else if(self.asb_isActionAvailble(action: action, targetAction: ACTION_CLICK_CENTER_BTN)){
            self.showLoadingProgressHUB("请稍等");
            self.vcService.webLoadList(success: { () in
                self.hideLoadingProgressHUB();
            }, error: { (errorCode : String, errorMsg : String) in
                self.showProgressHUB(forSuccess: false, message: errorMsg);
            }, fail:{ () in
                self.showProgressHUB(forSuccess: false, message: "网络繁忙，请重试");
            });
        }
        else if(self.asb_isActionAvailble(action: action, targetAction: ACTION_SELECT_TABLE_ROW)){
            print(params[0] as! Int);
            let value = params[0] as! Int;
            self.vcService.changeTableValue(index: value);
        }
    }
    
    func asb_needToRefreshViews(object: Any?,keyPath : String?){
        
        let fullKeyPath = self.vcService.vcModel.asb_getFullKeyPath(object: object, keyPath: keyPath);
        print("refresh keyPath = " + (fullKeyPath ?? keyPath ?? "nil"));
        
        if(keyPath == nil || fullKeyPath == "items"){
            self.tableView.reloadData();
        }
        if(keyPath == nil || fullKeyPath == "innerText"){
            self.levelLabel1.text = "" + self.vcService.vcModel.innerText;
        }
        if(keyPath == nil || fullKeyPath == "childModel.innerText"){
            self.levelLabel2.text = self.vcService.vcModel.childModel.innerText;
        }
        if(keyPath == nil || fullKeyPath == "childModel.childItemModel.innerText"){
            self.levelLabel3.text = self.vcService.vcModel.childModel.childItemModel.innerText;
        }
        if(keyPath == nil || fullKeyPath == "childModel.childItemModel.childSubItemModel.innerText"){
            self.levelLabel4.text = self.vcService.vcModel.childModel.childItemModel.childSubItemModel.innerText;
        }
    }
}
