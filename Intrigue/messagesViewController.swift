//
//  messagesViewController.swift
//  
//
//  Created by Jacob Banks on 9/12/15.
//
//

import UIKit

class MessagesViewController: JSQMessagesViewController {
    
    var userName = ""
    var serviceID = 1
    var messages = [JSQMessage]()
    let incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImageWithColor(UIColor(red: 10/255, green: 180/255, blue: 230/255, alpha: 1.0))
    let outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImageWithColor(UIColor.lightGrayColor())


    override func viewDidLoad() {
        super.viewDidLoad()

        self.senderId = "apple"
        self.senderDisplayName = "Apple"
        
        self.collectionView.collectionViewLayout.springinessEnabled = true
        
        //Add actual messages
        self.messages += [JSQMessage(senderId: "jon", displayName: "Jonathan", text: "I've always been fascinated with communication, using iMessage, Slack and Hipchat day-to-day.")]
        self.messages += [JSQMessage(senderId: "jon", displayName: "Jonathan", text: "From communicating with clients to even building my own little chat servers.")]
        self.messages += [JSQMessage(senderId: "jon", displayName: "Jonathan", text: "But I don't just use these personally.")]
        
        self.messages += [JSQMessage(senderId: "matt", displayName: "Matt", text: "Sure! lorem ipsum dolor sit amet bla bla bla bla bla")]
        self.messages += [JSQMessage(senderId: "virgin", displayName: "Virgin Media", text: "Hey! We had a lot of fun working with Jon over autumn building Kipstr, and maybe bringing it to Apple Watch soon ;)")]
        self.messages += [JSQMessage(senderId: "jon", displayName: "Jonathan", text: "Ahah, maybe. :P")]
        
        self.messages += [JSQMessage(senderId: "jon", displayName: "Jonathan", text: "So yeah, straight from the horses mouth. Thanks for your time! :)")]
        
        self.collectionView.reloadData()
        self.collectionView.reloadData()
        self.senderDisplayName = self.userName
        self.senderId = self.userName
        
        self.title = "Recipient name"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        var data = self.messages[indexPath.row]
        return data
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        var data = self.messages[indexPath.row]
        if (data.senderId == self.senderId) {
            return self.outgoingBubble
        } else {
            return self.incomingBubble
        }
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        return JSQMessagesAvatarImageFactory.avatarImageWithUserInitials("MTS", backgroundColor: UIColor(white: 0.85, alpha: 1.0), textColor: UIColor(white: 0.60, alpha: 1.0), font: UIFont.systemFontOfSize(CGFloat(14.0)), diameter: UInt(kJSQMessagesCollectionViewAvatarSizeDefault))
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.messages.count;
    }
    
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        var newMessage = JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text);
        messages += [newMessage]
        self.finishSendingMessage()
    }

}
