//
//  RequestHandler.swift
//  Intrigue
//
//  Created by Jonathan Kingsley on 12/09/2015.
//  Copyright (c) 2015 Jacob Banks. All rights reserved.
//

import Foundation

class RequestHandler: NSObject {
    func sendRequest(url: NSString, data: NSString?, postOrGet: Boolean, completionHandler: (Bool, AnyObject) -> ()) {
        
        let urlPath: String = "https://servis.on-aptible.com"
        
        var request = NSMutableURLRequest(URL: NSURL(string: "\(urlPath)\(url)")!)
        var session = NSURLSession.sharedSession()

        request.HTTPMethod = (postOrGet ? "POST" : "GET")
        
        if(data!.length > 0) {
            let dataStr = data!.dataUsingEncoding(NSUTF8StringEncoding)
            request.HTTPBody = dataStr
        }
        
        var task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            
            if(data == nil) {
                completionHandler(true, error)
            } else {
                completionHandler(false, NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil)!)
            }
        })
        
        task.resume();
    }
}