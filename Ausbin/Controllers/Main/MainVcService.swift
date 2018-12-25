//
//  MainVcService.swift
//  Ausbin
//
//  Created by BinHuang on 2018/9/18.
//  Copyright © 2018年 BinHuang. All rights reserved.
//

import UIKit

class MainVcService: NSObject {
    
    private(set) var vcModel: MainVcModel!;
    
    override init() {
        super.init();
        self.vcModel = MainVcModel(coder: nil);
    }
    
    func changeLevelValue1(){
        let now = Date()
        let timeInterval: TimeInterval = now.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        self.vcModel.innerText = "1级子变量innerText的值:"+String(millisecond);
    }
    
    func changeLevelValue2(){
        let now = Date()
        let timeInterval: TimeInterval = now.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        self.vcModel.childModel.innerText = "2级子变量innerText的值:"+String(millisecond);
    }
    
    func changeLevelValue3(){
        let now = Date()
        let timeInterval: TimeInterval = now.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        self.vcModel.childModel.childItemModel.innerText = "3级子变量innerText的值:"+String(millisecond);
    }
    
    func changeLevelValue4(){
        let now = Date()
        let timeInterval: TimeInterval = now.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        self.vcModel.childModel.childItemModel.childSubItemModel.innerText = "4级子变量innerText的值:"+String(millisecond);
    }
    
    func changeTableValue(index : Int){
        self.vcModel.checkedRowIndex = NSNumber.init(value: index);
        for item in self.vcModel.items{
            item.itemTitle = item.itemTitle.replacingOccurrences(of: "（已选中）", with: "");
        }
        self.vcModel.items[index].itemTitle = self.vcModel.items[index].itemTitle + "（已选中）";
        self.vcModel.items = self.vcModel.items;//强制刷新数组
    }
    
    func webLoadList(success: @escaping ServiceSuccessCallback, error: @escaping ServiceErrorCallback,  fail : @escaping ServiceNetworkFailCallback){
        API.getAllList(success: { (dict : Dictionary<String, Any>) in
            success();
            print("load success");
            
            var items : [ListItemModel] = [];
            
            let dataDict : Dictionary<String,Any>? = dict as Dictionary<String,Any>?;
            let arr : [Any]? = dataDict!["list"] as? Array;
            for item in arr! {
                var itemDict:Dictionary<String,Any>? = item as? Dictionary<String, Any>;
                items.append(ListItemModel.init(itemTitle: itemDict!["name"] as! String, itemContent: itemDict!["value"] as! String));
            }
            
            self.vcModel.items = items;
            self.vcModel.checkedRowIndex = -1;
        }, error: { (errorCode : String, errorMsg : String) in
            print(errorCode,errorMsg);
            error(errorCode,errorMsg);
        }, fail:{ (task : URLSessionDataTask?, error : Error) in
            print("error description = "+error.localizedDescription);
            if(!error.localizedDescription.isEqual("cancelled")){
                print("network fail = " + (task?.currentRequest?.url?.absoluteString)!);
            }
            else{
                print("network has been cancelled");
            }
            fail();
        });
    }
}
