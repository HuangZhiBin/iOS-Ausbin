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
    static func getAllList(success: @escaping NetworkSuccessCallback, error: @escaping NetworkErrorCallback,  fail : @escaping NetworkFailCallback) -> URLSessionDataTask?{
        let urlString = "https://www.koudaikr.cn/ios/list.json";
        
        let parameters : [String : Any] = [:];
        
        let sessionDataTask = getManager().get(urlString, parameters: parameters, progress: {(progress : Progress) -> Void in
            
        }, success: {(task : URLSessionDataTask, responseObj : Any?) -> Void in
            handleResponseObject(responseObject: responseObj!, task: task, success: success, error: error);
        }, failure: {(task : URLSessionDataTask?, error: Error) -> Void in
            fail(task, error);
        });
        
        return sessionDataTask;
    }
    
}
