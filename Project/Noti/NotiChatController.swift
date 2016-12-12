//
//  NotiChatController.swift
//  Noti
//
//  Created by 이채원 on 2016. 11. 2..
//  Copyright © 2016년 이채원. All rights reserved.
//

import Foundation
import UIKit
import JSQMessagesViewController
import Firebase

class NotiChatController: JSQMessagesViewController{
    
    var messages = [JSQMessage]()
    var channel : Channel?
    
    var channelRef: FIRDatabaseReference!
    var messageRef: FIRDatabaseReference!
    
    private var newMessageRefHandle: FIRDatabaseHandle?
    
    lazy var outgoingBubbleImageView: JSQMessagesBubbleImage = self.setupOutgoingBubble()
    lazy var incomingBubbleImageView: JSQMessagesBubbleImage = self.setupIncomingBubble()
    
    var selectedCellIndexPath:IndexPath?
    
    private func setupOutgoingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.outgoingMessagesBubbleImage(with: UIColor.jsq_messageBubbleBlue())
        
    }
    
    private func setupIncomingBubble() -> JSQMessagesBubbleImage {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        return bubbleImageFactory!.incomingMessagesBubbleImage(with: UIColor.jsq_messageBubbleLightGray())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(self.view.subviews[0])
        // 관리자 권한인 공지방이 아닐 때, 메세지를 보낼 수 없음
        if(channel?.admin != FIRAuth.auth()?.currentUser?.uid)
        {
            self.view.subviews[1].removeFromSuperview()
        }
        
        self.channelRef = FIRDatabase.database().reference().child("channels").child((channel?.id)!)
        self.messageRef = self.channelRef.child("messages")
        
        self.senderId = FIRAuth.auth()?.currentUser?.uid
        self.senderDisplayName = self.channel?.name
        
        observeMessages()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /*
         // messages from someone else
         addMessage(withId: "foo", name: "Mr.Bolt", text: "I am so fast!")
         // messages sent from local sender
         addMessage(withId: senderId, name: "Me", text: "I bet I can run faster than you!")
         addMessage(withId: senderId, name: "Me", text: "I like to run!")
         // animates the receiving of a new message on the view
         finishReceivingMessage()*/
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, didTapMessageBubbleAt indexPath: IndexPath!) {
        var toVC = storyboard?.instantiateViewController(withIdentifier: "ParsedMessageController") as! ParsedMessageController
        
        toVC.originalMessage = self.messages[indexPath.row].text
        
        self.navigationController?.pushViewController(toVC, animated: true)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        //let message = messages[indexPath.item] // 1
        //if message.senderId == senderId { // 2
        //  return outgoingBubbleImageView
        //} else { // 3
        return incomingBubbleImageView
        //}
    }
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        let itemRef = messageRef.childByAutoId() // 1
        let messageItem = [ // 2
            "senderId": "noway",
            "senderName": senderDisplayName!,
            "text": text!,
            ]
        
        itemRef.setValue(messageItem) // 3
        
        JSQSystemSoundPlayer.jsq_playMessageSentSound() // 4
        
        finishSendingMessage() // 5
    }
    
    private func observeMessages() {
        messageRef = channelRef.child("messages")
        // 1.
        let messageQuery = messageRef.queryLimited(toLast:25)
        
        // 2. We can use the observe method to listen for new
        // messages being written to the Firebase DB
        newMessageRefHandle = messageQuery.observe(.childAdded, with: { (snapshot) -> Void in
            // 3
            let messageData = snapshot.value as! Dictionary<String, String>
            
            if let id = messageData["senderId"] as String!, let name = messageData["senderName"] as String!, let text = messageData["text"] as String!, text.characters.count > 0 {
                // 4
                self.addMessage(withId: id, name: name, text: text)
                
                // 5
                self.finishReceivingMessage()
            } else {
                print("Error! Could not decode message data")
            }
        })
    }
    
    private func addMessage(withId id: String, name: String, text: String) {
        if let message = JSQMessage(senderId: id, displayName: name, text: text) {
            messages.append(message)
        }
    }
}
