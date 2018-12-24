//
//  MainTableViewCell.swift
//  Acupuncture
//
//  Created by BinHuang on 2018/9/19.
//  Copyright © 2018年 TechTCM. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    
    lazy var leftLabel : UILabel! = {
        let label = UILabel.init(frame: CGRect.init(x: 15, y: 17, width: ScreenWidth-30, height: 20));
        label.font = UIFont.systemFont(ofSize: 16);
        label.textColor = UIColor.init(hexString: "333333");
        return label;
    }();
    
    lazy var rightLabel : UILabel! = {
        let label = UILabel.init(frame: CGRect.init(x: 15, y: 40, width: ScreenWidth-30, height: 20));
        label.font = UIFont.systemFont(ofSize: 14);
        label.textColor = UIColor.init(hexString: "888888");
        return label;
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
        self.addSubview(self.leftLabel);
        self.addSubview(self.rightLabel);
    }
    
    func updateCell(title : String, content : String) {
        self.leftLabel.text = title;
        self.rightLabel.text = content;
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
