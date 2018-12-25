//
//  MainVcService.swift
//  Ausbin
//
//  Created by BinHuang on 2018/9/18.
//  Copyright © 2018年 BinHuang. All rights reserved.
//

import UIKit

class MainVcService: NSObject {
    
    var mainVcModel : MainVcModel!;
    
    init(model : MainVcModel) {
        super.init();
        self.mainVcModel = model;
    }
    
    func changeTopValue(){
        let now = Date()
        let timeInterval: TimeInterval = now.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        self.mainVcModel.topText = "顶部时间戳：" + String(millisecond);
    }
    
    func changeBottomValue(){
        let now = Date()
        let timeInterval: TimeInterval = now.timeIntervalSince1970
        let millisecond = CLongLong(round(timeInterval*1000))
        self.mainVcModel.childModel.innerText = "底部时间戳：" + String(millisecond);
    }
    
    func changeTableValue(index : Int){
        for item in self.mainVcModel.items{
            item.itemTitle = item.itemTitle.replacingOccurrences(of: "（已选中）", with: "");
        }
        self.mainVcModel.items[index].itemTitle = self.mainVcModel.items[index].itemTitle + "（已选中）";
        self.mainVcModel.items[index] = self.mainVcModel.items[index];
    }
    
    func webLoadList(success: @escaping ServiceSuccessCallback, error: @escaping ServiceErrorCallback,  fail : @escaping ServiceNetworkFailCallback){
        API.getAllSymptoms(success: { (dict : Dictionary<String, Any>) in
            success();
            
            var items : [ItemModel] = [];
            
            let dataDict : Dictionary<String,Any>? = dict as Dictionary<String,Any>?;
            let arr : [Any]? = dataDict!["data"] as? Array;
            for item in arr! {
                var itemDict:Dictionary<String,Any>? = item as? Dictionary<String, Any>;
                items.append(ItemModel.init(itemTitle: itemDict!["name"] as! String, itemContent: itemDict!["value"] as! String));
            }
            
            self.mainVcModel.items = items;
        }, error: { (errorCode : String, errorMsg : String) in
            print(errorCode);
            print(errorMsg);
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
