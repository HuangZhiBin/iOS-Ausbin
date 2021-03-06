//
//  MainTableViewCell.swift
//  Ausbin
//
//  Created by BinHuang on 2018/9/19.
//  Copyright © 2018年 BinHuang. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    lazy var topLabel : UILabel! = {
        let label = UILabel.init(frame: CGRect.init(x: 15, y: 15, width: ScreenWidth-30, height: 20));
        label.font = UIFont.systemFont(ofSize: 16);
        label.textColor = UIColor.init(hexString: "333333");
        return label;
    }();
    
    lazy var bottomLabel : UILabel! = {
        let label = UILabel.init(frame: CGRect.init(x: 15, y: 40, width: ScreenWidth-30, height: 20));
        label.font = UIFont.systemFont(ofSize: 14);
        label.textColor = UIColor.init(hexString: "888888");
        return label;
    }();
    
    lazy var checkImageView : UIImageView! = {
        let checkImageView = UIImageView.init(frame: CGRect.init(x: ScreenWidth-50, y: 20, width: 30, height: 30));
        checkImageView.image = UIImage.init(named: "uncheck");
        return checkImageView;
    }();
    
    //MARK: - 初始化View
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initializeAllView()
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
    }
    
    func initializeAllView() {
        // Initialization code
        print("initializeAllView()");
        self.addSubview(self.topLabel);
        self.addSubview(self.bottomLabel);
        self.addSubview(self.checkImageView);
    }
    
    func updateCell(title : String, content : String) {
        self.topLabel.text = title;
        self.bottomLabel.text = content;
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
