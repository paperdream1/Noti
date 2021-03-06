//
//  MyNotiRoomController.swift
//  Noti
//
//  Created by 이채원 on 2016. 11. 2..
//  Copyright © 2016년 이채원. All rights reserved.
//

import Foundation
import Firebase
import UIKit

class MyNotiRoomController: UITableViewController {
    
    
    @IBOutlet var menuButton: UIBarButtonItem!
    
    static var rooms : [Channel] = []//[Channel(id: "1", name: "한양대학교")]
    
    private lazy var channelRef: FIRDatabaseReference = FIRDatabase.database().reference().child("channels")
    private var channelRefHandle: FIRDatabaseHandle?
    private var relationRef: FIRDatabaseReference = FIRDatabase.database().reference().child("relation")
    private var relationRefHandle: FIRDatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.revealViewController() != nil {
            
            menuButton.target = self.revealViewController()
            
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
        
        observeChannels()
    }
    
    deinit {
        if let refHandle = channelRefHandle {
            channelRef.removeObserver(withHandle: refHandle)
        }
    }
    
    /*
     @IBAction func createChannel(_ sender: Any) {
     
     if let name = newChannelTextField?.text {
     let newChannelRef = channelRef.childByAutoId()
     let channelItem = [
     "name": name
     ]
     newChannelRef.setValue(channelItem)
     }
     
     }*/
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MyNotiRoomController.rooms.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyNotiRoomCell", for: indexPath) as! MyNotiRoomCell
        cell.roomLabel.text = MyNotiRoomController.rooms[indexPath.row].name
        cell.index = indexPath.row
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if(segue.identifier == "MyNotiRoomCellSegue")
        {
            let cell = sender as! MyNotiRoomCell
            let toVC = segue.destination as! NotiChatController
            
            toVC.channel = MyNotiRoomController.rooms[cell.index!]
        }
    }
    
    // MARK: Firebase related methods
    private func observeChannels() {
        
        MyNotiRoomController.rooms.removeAll()
        
        relationRefHandle = relationRef.observe(.value, with: {(snapshot) in
            
            // 해당 유저가 가입한 공지방 목록 먼저 참조
            let currentUser = FIRAuth.auth()?.currentUser?.uid
            
            let relations = snapshot.value as? [String:AnyObject]
            
            if(relations == nil)
            {
                return
            }
            
            for channelID in relations!
            {
                if(channelID.key == currentUser)
                {
                    
                    
                    // 각 공지방들을 하나씩 검색
                    for b in channelID.value as! [String]
                    {
                        
                        //print(b)
                        
                        // Use the observe method to listen for new
                        // channels being written to the Firebase DB
                        self.channelRefHandle = self.channelRef.observe(.childAdded, with: { (snapshot) -> Void in // 1
                            
                            // 해당 공지방이 유저가 가입한 공지방 중 하나일때
                            if(b == snapshot.key)//snapshot.key == b as! String)
                            {
                                let channelData = snapshot.value as! Dictionary<String, AnyObject> // 2
                                let id = snapshot.key
                                if let name = channelData["name"] as! String!,let about = channelData["about"] as! String!,let admin = channelData["admin"] as! String!, name.characters.count > 0 { // 3
                                    MyNotiRoomController.rooms.append(Channel(id:id,name:name,about:about,admin:admin))
                                    self.tableView.reloadData()
                                } else {
                                    print("Error! Could not decode channel data")
                                }
                            }
                        })
                    }
                }
            }
        })
        
        
    }
    
    @IBAction func addChannel(segue:UIStoryboardSegue){
        
        let channelName = (segue.source as! ChannelAddController).channelTextField.text! as String
        let channelExp = (segue.source as! ChannelAddController).aboutTextField.text! as String
        let currentUser = FIRAuth.auth()?.currentUser
        
        let newChannelRef = channelRef.childByAutoId()
        let newRelationRef = relationRef.child((currentUser?.uid)!)
        
        
        
        let channelItem = [
            "name": channelName,
            "about": channelExp,
            "admin": currentUser?.uid
        ]
        
        var relationItem = [
            newChannelRef.key
        ]
        
        for room in MyNotiRoomController.rooms
        {
            relationItem.append(room.id)
        }
        
        newChannelRef.setValue(channelItem)
        newRelationRef.setValue(relationItem)
        
        
        MyNotiRoomController.rooms.removeAll()
        //observeChannels()
        
        self.tableView.reloadData()
        
    }
    
}

class MyNotiRoomCell: UITableViewCell {
    
    @IBOutlet var roomLabel: UILabel!
    @IBOutlet var roomImageView: UIImageView!
    
    var index : Int?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let rand = arc4random_uniform(11) + 1;
        
        roomImageView.layer.cornerRadius=roomImageView.frame.height/2
        roomImageView.clipsToBounds=true
        
        let imageName = String(rand)
        roomImageView.image = UIImage(named: imageName)
    }
}
