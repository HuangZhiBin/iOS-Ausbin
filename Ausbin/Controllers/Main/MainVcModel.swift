//
//  MainVcModel.swift
//  Acupuncture
//
//  Created by BinHuang on 2018/9/18.
//  Copyright © 2018年 TechTCM. All rights reserved.
//

import UIKit

class MainVcModel: NSObject {
    
    @objc dynamic var topText : String! = "这是最原始的顶部文字";
    
    @objc dynamic var childModel : ChildModel! = ChildModel.init(innerText: "这是最原始的底部文字");
    
    @objc dynamic var items : [ItemModel] = [ItemModel.init(itemTitle: "可乐", itemContent: "可乐的价格是2.00元"),ItemModel.init(itemTitle: "雪碧", itemContent: "雪碧的价格是3.00元")];
    
    required init(coder aDecoder: NSCoder?) {
        super.init();
    }
}

class ChildModel: NSObject {
    
    @objc dynamic var innerText : String!;
    
    init(innerText : String) {
        super.init();
        self.innerText = innerText;
    }
    
    required init(coder aDecoder: NSCoder?) {
        super.init();
    }
}

class ItemModel: NSObject {
    
    @objc dynamic var itemTitle : String!;
    
    @objc dynamic var itemContent : String!;
    
    init(itemTitle : String, itemContent : String) {
        super.init();
        self.itemTitle = itemTitle;
        self.itemContent = itemContent;
    }
    
    required init(coder aDecoder: NSCoder?) {
        super.init();
    }
}
