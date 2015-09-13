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
        var url: NSURL = NSURL(string: "\(urlPath)\(url)")!
        var request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = (postOrGet ? "POST" : "GET")
        
        if(data != nil) {
            let dataStr = data!.dataUsingEncoding(NSUTF8StringEncoding)
            request.HTTPBody = dataStr
        }
        
        request.timeoutInterval = 60
        request.HTTPShouldHandleCookies = false
        
        let queue: NSOperationQueue = NSOperationQueue()
        
        NSURLConnection.sendAsynchronousRequest(request, queue: queue, completionHandler:{ (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var err: NSError
            
            completionHandler(false, NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil)!)
        })
    }
}