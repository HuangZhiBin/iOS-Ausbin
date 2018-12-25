//
//  MainVcView.swift
//  Ausbin
//
//  Created by BinHuang on 2018/9/18.
//  Copyright © 2018年 BinHuang. All rights reserved.
//

import UIKit

class MainVcView: UIView {
    
    let ACTION_CLICK_LEFT_BTN = "click left button to change top text";
    let ACTION_CLICK_CENTER_BTN = "click center button to change table";
    let ACTION_CLICK_RIGHT_BTN = "click center button to change bottom text";
    let ACTION_SELECT_TABLE_ROW = "select one table row";
    
    var mainVcModel : MainVcModel! //可读，不可改变对象的值

    //可以将外界的参数传进来
    init(frame: CGRect, model : MainVcModel) {
        super.init(frame: frame);
        self.asb_setAction([ACTION_CLICK_LEFT_BTN, ACTION_CLICK_CENTER_BTN, ACTION_CLICK_RIGHT_BTN, ACTION_SELECT_TABLE_ROW]);
        self.mainVcModel = model;
        self.initAllViews();
        self.asb_needToRefreshViews(keyPath: nil);//根据model初始化view
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!;
    }
    
    func initAllViews(){
        self.backgroundColor = UIColor.white;
        self.addSubview(self.tableView);
        self.addSubview(self.topLabel);
        self.addSubview(self.bottomLabel);
        self.addSubview(self.leftBtn);
        self.addSubview(self.centerBtn);
        self.addSubview(self.rightBtn);
        
        if(self.asb_isAvailable(action: ACTION_CLICK_LEFT_BTN)){
            self.leftBtn.setAction(kUIButtonBlockTouchUpInside, with: {[weak self] () in
                self?.asb_viewChangeDelegate?.asb_viewDidChanged(action: (self?.ACTION_CLICK_LEFT_BTN)!, params: []);
            });
        }
        
        if(self.asb_isAvailable(action: ACTION_CLICK_CENTER_BTN)){
            self.centerBtn.setAction(kUIButtonBlockTouchUpInside, with: {[weak self] () in
                self?.asb_viewChangeDelegate?.asb_viewDidChanged(action: (self?.ACTION_CLICK_CENTER_BTN)!, params: []);
            });
        }
        
        if(self.asb_isAvailable(action: ACTION_CLICK_RIGHT_BTN)){
            self.rightBtn.setAction(kUIButtonBlockTouchUpInside, with: {[weak self] () in
                self?.asb_viewChangeDelegate?.asb_viewDidChanged(action: (self?.ACTION_CLICK_RIGHT_BTN)!, params: []);
            });
        }
    }
    
    override func layoutSubviews() {
        print("layoutSubviews...");
    }
    
    lazy var topLabel : UILabel! = {
        let label = UILabel.init(frame: CGRect.init(x: 10, y: 10, width: ScreenWidth-20, height: 20));
        label.font = UIFont.systemFont(ofSize: 14);
        label.textColor = UIColor.init(hexString: "333333");
        return label;
    }();
    
    lazy var bottomLabel : UILabel! = {
        let label = UILabel.init(frame: CGRect.init(x: 10, y: 210, width: ScreenWidth-20, height: 20));
        label.font = UIFont.systemFont(ofSize: 14);
        label.textColor = UIColor.init(hexString: "333333");
        return label;
    }();
    
    lazy var leftBtn : UIButton! = {
        let btn : UIButton = UIButton.init(type: .system);
        btn.frame = CGRect.init(x: 10, y: 240, width: (ScreenWidth-40)/3, height: 50);
        btn.setTitle("更新顶部文字", for: .normal);
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.setTitleColor(UIColor.init(hexString: "ffffff"), for: .normal);
        btn.backgroundColor = UIColor.init(hexString: "f03a39");
        return btn;
    }();
    
    lazy var centerBtn : UIButton! = {
        let btn : UIButton = UIButton.init(type: .system);
        btn.frame = CGRect.init(x: (ScreenWidth-40)/3+20, y: 240, width: (ScreenWidth-40)/3, height: 50);
        btn.setTitle("更新列表", for: .normal);
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.setTitleColor(UIColor.init(hexString: "ffffff"), for: .normal);
        btn.backgroundColor = UIColor.init(hexString: "00a85a");
        return btn;
    }();
    
    lazy var rightBtn : UIButton! = {
        let btn : UIButton = UIButton.init(type: .system);
        btn.frame = CGRect.init(x: ScreenWidth-10-(ScreenWidth-40)/3, y: 240, width: (ScreenWidth-40)/3, height: 50);
        btn.setTitle("更新底部文字", for: .normal);
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.setTitleColor(UIColor.init(hexString: "ffffff"), for: .normal);
        btn.backgroundColor = UIColor.init(hexString: "0075fa");
        return btn;
    }();
    
    let CELL_IDENTIFIER = "cell";
    let DEFAULT_BG_COLOR : UIColor = UIColor.init(hexString: "f8f8f8");
    
    lazy var tableView: UITableView! = {
        let tableView = UITableView.init(frame: self.bounds, style: .grouped);
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

extension MainVcView : AusbinVcViewDelegate{
    
    func asb_needToRefreshViews(keyPath : String?){
        //print(keyPath);
        if(keyPath == nil || keyPath == "topText"){
            self.topLabel.text = self.mainVcModel.topText;
        }
        if(keyPath == nil || keyPath == "items"){
            self.tableView.reloadData();
        }
        if(keyPath == nil || keyPath == "childModel.innerText"){
            self.bottomLabel.text = self.mainVcModel.childModel.innerText;
        }
    }
}

extension MainVcView : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.mainVcModel == nil){
            return 0;
        }
        return self.mainVcModel.items.count;
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude;
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item : ItemModel = self.mainVcModel.items[indexPath.row];
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER, for: indexPath) as! MainTableViewCell;
        
        cell.updateCell(title : item.itemTitle, content: item.itemContent);
        
        cell.selectedBackgroundView = UIView.init(frame: cell.frame);
        cell.selectedBackgroundView?.backgroundColor = UIColor.init(hexString: "f9f9f9");
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false);
        print("didSelectRowAt=\(indexPath.row)");
        
        if(self.asb_isAvailable(action: ACTION_SELECT_TABLE_ROW)){
            self.asb_viewChangeDelegate?.asb_viewDidChanged(action: ACTION_SELECT_TABLE_ROW, params: [indexPath.row]);
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //self.overflowView.setNeedsDisplay();
    }

}
