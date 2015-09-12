//
//  Message.swift
//  FireChat-Swift
//
//  Created by Katherine Fang on 8/20/14.
//  Copyright (c) 2014 Firebase. All rights reserved.
//

import Foundation

class Message : NSObject, JSQMessageData {
    var text_: String
    var sender_: String
    var date_: NSDate
    var imageUrl_: String?
    var senderId_: String?
    var senderDisplayName_: String?
    var isMediaMessage_: Bool?
    var messageHash_: Int?
    
    convenience init(text: String?, sender: String?) {
        self.init(text: text, sender: sender, imageUrl: nil)
    }
    
    init(text: String?, sender: String?, imageUrl: String?) {
        self.text_ = text!
        self.sender_ = sender!
        self.date_ = NSDate()
        self.imageUrl_ = imageUrl
    }
    
    func text() -> String! {
        return text_;
    }
    
    func sender() -> String! {
        return sender_;
    }
    
    func date() -> NSDate! {
        return date_;
    }
    
    func imageUrl() -> String? {
        return imageUrl_;
    }
    
    func senderId() -> String! {
        return senderId_;
    }
    
    func senderDisplayName() -> String! {
        return senderDisplayName_;
    }
    
    func isMediaMessage() -> Bool {
        return isMediaMessage_!;
    }
    
    func messageHash() -> UInt {
        return messageHash();
    }
}