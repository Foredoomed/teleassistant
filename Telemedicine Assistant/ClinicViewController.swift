//
//  SecondViewController.swift
//  Telemedicine Assistant
//
//  Created by Foredoomed on 2/14/16.
//  Copyright © 2016 liuxuan. All rights reserved.
//

import UIKit
import Firebase


class ClinicViewController: JSQMessagesViewController {


    
    
    var messages = [JSQMessage]()
    var outgoingBubbleImageView = JSQMessagesBubbleImageFactory.outgoingMessageBubbleImageViewWithColor(UIColor.jsq_messageBubbleGreenColor())
    var incomingBubbleImageView = JSQMessagesBubbleImageFactory.incomingMessageBubbleImageViewWithColor(UIColor.jsq_messageBubbleLightGrayColor())
    var batchMessages = true
    var messagesRef: Firebase!
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        automaticallyScrollsToMostRecentMessage = true
        self.sender = "sysc5094"
        setupFirebase()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        collectionView!.collectionViewLayout.springinessEnabled = true
    }
    
    func setupFirebase() {
        
        messagesRef = Firebase(url: "https://sysc5409.firebaseio.com/")
        
        messagesRef.queryLimitedToLast(10).observeEventType(FEventType.ChildAdded, withBlock: { (snapshot) in
            let data = snapshot.value
            let text = data["text"] as? String
            let sender = data["name"] as? String
            
            if text != nil && sender != nil {
                let message = JSQMessage(text: text, sender: sender)
                self.messages.append(message)
            }
            
            self.finishReceivingMessage()
        })
    }
    
    
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, sender: String!, date: NSDate!) {
        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        
        messagesRef.childByAutoId().setValue([
            "text":text,
            "name":sender
            ])
        
//        if text != nil && sender != nil {
//            let message = JSQMessage(text: text, sender: sender)
//            self.messages.append(message)
//        }
        
        finishSendingMessage()
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!,
        messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
            return messages[indexPath.item]
    }
    
    override func collectionView(collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
            return messages.count
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, bubbleImageViewForItemAtIndexPath indexPath: NSIndexPath!) -> UIImageView! {
        let message = messages[indexPath.item]
        
        if message.sender == sender {
            return UIImageView(image: outgoingBubbleImageView.image, highlightedImage: outgoingBubbleImageView.highlightedImage)
        }
        
        return UIImageView(image: incomingBubbleImageView.image, highlightedImage: incomingBubbleImageView.highlightedImage)
    }
    
    override func collectionView(collectionView: UICollectionView,
        cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
            let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath)
                as! JSQMessagesCollectionViewCell
            
            let message = messages[indexPath.item]
            
            if message.sender == sender {
                cell.textView!.textColor = UIColor.whiteColor()
            } else {
                cell.textView!.textColor = UIColor.blackColor()
            }
            
            return cell
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageViewForItemAtIndexPath indexPath: NSIndexPath!) -> UIImageView! {
        return nil
    }

    
//    override func collectionView(collectionView: JSQMessagesCollectionView!,
//        messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
//            let message = messages[indexPath.item]
//            if message.sender == sender {
//                return outgoingBubbleImageView
//            } else {
//                return incomingBubbleImageView
//            }
//    }
//    
//    override func collectionView(collectionView: JSQMessagesCollectionView!,
//        avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
//            return nil
//    }

    
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//        collectionView!.collectionViewLayout.springinessEnabled = true
//    }
//    
//    override func viewWillDisappear(animated: Bool) {
//        super.viewWillDisappear(animated)
//        
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        self.msgField.resignFirstResponder()
//        return true;
//    }
//
//    
//    func receivedMessagePressed(sender: UIBarButtonItem) {
//        // Simulate reciving message
//        showTypingIndicator = !showTypingIndicator
//        scrollToBottomAnimated(true)
//    }
//    
//    override func didPressSendButton(button: UIButton!, withMessageText text: String!, sender: String!, date: NSDate!) {
//        JSQSystemSoundPlayer.jsq_playMessageSentSound()
//        
//        sendMessage(text, sender: sender)
//        
//        finishSendingMessage()
//    }
//    
////    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
////        return messages[indexPath.item]
////    }
////    
////    override func collectionView(collectionView: JSQMessagesCollectionView!, bubbleImageViewForItemAtIndexPath indexPath: NSIndexPath!) -> UIImageView! {
////        let message = messages[indexPath.item]
////        
////        if message.sender() == sender {
////            return UIImageView(image: outgoingBubbleImageView.image, highlightedImage: outgoingBubbleImageView.highlightedImage)
////        }
////        
////        return UIImageView(image: incomingBubbleImageView.image, highlightedImage: incomingBubbleImageView.highlightedImage)
////    }
////    
////
////    
////    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
////        return messages.count
////    }
////    
////    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
////        let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath) as! JSQMessagesCollectionViewCell
////        
////        let message = messages[indexPath.item]
////        if message.sender() == sender {
////            cell.textView!.textColor = UIColor.blackColor()
////        } else {
////            cell.textView!.textColor = UIColor.whiteColor()
////        }
////        
////        let attributes : [String:AnyObject] = [NSForegroundColorAttributeName:cell.textView!.textColor!, NSUnderlineStyleAttributeName: 1]
////        cell.textView!.linkTextAttributes = attributes
////        
////
////        return cell
////    }
////    
////    
////    // View  usernames above bubbles
////    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
////        let message = messages[indexPath.item];
////        
////        // Sent by me, skip
////        if message.sender() == sender {
////            return nil;
////        }
////        
////        // Same as previous sender, skip
////        if indexPath.item > 0 {
////            let previousMessage = messages[indexPath.item - 1];
////            if previousMessage.sender() == message.sender() {
////                return nil;
////            }
////        }
////        
////        return NSAttributedString(string:message.sender())
////    }
////    
////    override func collectionView(collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
////        let message = messages[indexPath.item]
////        
////        // Sent by me, skip
////        if message.sender() == sender {
////            return CGFloat(0.0);
////        }
////        
////        // Same as previous sender, skip
////        if indexPath.item > 0 {
////            let previousMessage = messages[indexPath.item - 1];
////            if previousMessage.sender() == message.sender() {
////                return CGFloat(0.0);
////            }
////        }
////        
////        return kJSQMessagesCollectionViewCellLabelHeightDefault
////    }
//    
//    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return self.messages.count
//    }
//    
//    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
//        let data = self.messages[indexPath.row]
//        return data
//    }
//    
//    
//    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
//        let data = messages[indexPath.row]
//        switch(data.senderId) {
//        case self.senderId:
//            return self.outgoingBubble
//        default:
//            return self.incomingBubble
//        }
//    }
//    
//    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
//        return nil
//    }

}

