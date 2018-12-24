//
//  API.swift
//  Languages
//
//  Created by lmb on 2017/4/26.
//  Copyright © Dianbo.co. All rights reserved.
//

import UIKit

typealias ServiceSuccessCallback = () ->Void;
typealias ServiceErrorCallback = (String,String) ->Void;
typealias ServiceNetworkFailCallback = () ->Void;

let ScreenWidth : CGFloat = UIScreen.main.bounds.size.width;
let ScreenHeight : CGFloat = UIScreen.main.bounds.size.height;

struct Platform {
    static let isIphoneX: Bool = {
        if(UIScreen.main.bounds.width == 375 && UIScreen.main.bounds.height == 812) {
            return true;
        }
        return false;
    }();
    
}

let Status_Bar_Height : CGFloat = Platform.isIphoneX ? 44 : 20;
let Navigation_Bar_Height : CGFloat = 44;
let Tab_Bar_Height : CGFloat = Platform.isIphoneX ? 83 : 49;
let Tab_Bar_Add_Height_Iphonex : CGFloat = 34;
let Status_Bar_Add_Height_Iphonex : CGFloat = 24;
let NETWORK_TIMEOUT : Int = 15;

class API: NSObject {
    
    typealias NetworkSuccessCallback = (Dictionary<String, Any>) ->Void;
    typealias NetworkErrorCallback = (String,String) ->Void;
    typealias NetworkFailCallback = (URLSessionDataTask?, Error) ->Void;
    
    private static func getManager() -> AFHTTPSessionManager{
        let manager = AFHTTPSessionManager();
        manager.requestSerializer.timeoutInterval = TimeInterval(NETWORK_TIMEOUT);
        var set = Set<String>();
        set.insert("application/json");
        manager.responseSerializer.acceptableContentTypes = set;
        return manager;
    }
    
    private static func handleResponseObject(responseObject : Any, task: URLSessionDataTask, success : NetworkSuccessCallback, error : NetworkErrorCallback){
        let responseDict = responseObject as! Dictionary<String, AnyObject>;
        if((responseDict["responseStatus"])!.isEqual(to: "success")){
            let dataDict = responseDict["data"] as! Dictionary<String,AnyObject>;
            
            if(dataDict["event"] != nil){
                
            }
            
            success(dataDict);
        }
        else if((responseDict["responseStatus"])!.isEqual(to: "error")){
            let errorCode : String = responseDict["errorCode"] as! String;
            let errorMsg : String = responseDict["errorMsg"] as! String;
            error(errorCode, errorMsg);
        }
    }
    
    @discardableResult
    static func getAllSymptoms(success: @escaping NetworkSuccessCallback, error: @escaping NetworkErrorCallback,  fail : @escaping NetworkFailCallback) -> URLSessionDataTask?{
        let urlString = "https://www.koudaikr.cn/WxTopiker/exam_allExams.action";
        
        let parameters : [String : Any] = [:];
        
        let sessionDataTask = getManager().post(urlString, parameters: parameters, progress: {(progress : Progress) -> Void in
            
        }, success: {(task : URLSessionDataTask, responseObj : Any?) -> Void in
            handleResponseObject(responseObject: responseObj!, task: task, success: success, error: error);
        }, failure: {(task : URLSessionDataTask?, error: Error) -> Void in
            fail(task, error);
        });
        
        return sessionDataTask;
    }
    
}
