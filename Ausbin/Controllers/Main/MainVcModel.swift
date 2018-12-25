//
//  MainVcModel.swift
//  Ausbin
//
//  Created by BinHuang on 2018/9/18.
//  Copyright © 2018年 BinHuang. All rights reserved.
//

import UIKit

class MainVcModel: NSObject {
    
    @objc dynamic var items : [ListItemModel] = [
        ListItemModel.init(itemTitle: "可乐", itemContent: "2.00元"),
        ListItemModel.init(itemTitle: "雪碧", itemContent: "3.00元")
    ];
    
    @objc dynamic var innerText : String! = "1级子变量innerText的值:0";
    
    @objc dynamic var childModel : ChildModel! = ChildModel.init(innerText: "2级子变量innerText的值:0",
                                childItemModel: ChildItemModel.init(innerText: "3级子变量innerText的值:0"));
    
    @objc dynamic var checkedRowIndex : NSNumber = -1;
    
    @objc dynamic var optionalModel : OptionalModel?;
    
    required init(coder aDecoder: NSCoder?) {
        super.init();
    }
}

class ListItemModel: NSObject {
    
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

class ChildModel: NSObject {
    
    @objc dynamic var innerText : String!;
    @objc dynamic var childItemModel : ChildItemModel!;
    
    init(innerText : String, childItemModel: ChildItemModel) {
        super.init();
        self.innerText = innerText;
        self.childItemModel = childItemModel;
    }
    
    required init(coder aDecoder: NSCoder?) {
        super.init();
    }
}

class ChildItemModel: NSObject {
    
    @objc dynamic var innerText : String!;
    
    init(innerText : String) {
        super.init();
        self.innerText = innerText;
    }
    
    required init(coder aDecoder: NSCoder?) {
        super.init();
    }
}

class OptionalModel: NSObject {
    
    @objc dynamic var optionalProperty : String?;
    
}
