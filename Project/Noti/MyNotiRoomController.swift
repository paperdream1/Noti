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
    
    var rooms : [Channel] = []//[Channel(id: "1", name: "한양대학교")]
    
    private lazy var channelRef: FIRDatabaseReference = FIRDatabase.database().reference().child("channels")
    private var channelRefHandle: FIRDatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        return rooms.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyNotiRoomCell", for: indexPath) as! MyNotiRoomCell
        cell.roomLabel.text = rooms[indexPath.row].name
        cell.index = indexPath.row
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if(segue.identifier == "MyNotiRoomCellSegue")
        {
            let cell = sender as! MyNotiRoomCell
            let toVC = segue.destination as! NotiChatController
            
            toVC.channel = self.rooms[cell.index!]
        }
    }
    
    // MARK: Firebase related methods
    private func observeChannels() {
        // Use the observe method to listen for new
        // channels being written to the Firebase DB
        channelRefHandle = channelRef.observe(.childAdded, with: { (snapshot) -> Void in // 1
            let channelData = snapshot.value as! Dictionary<String, AnyObject> // 2
            let id = snapshot.key
            if let name = channelData["name"] as! String!, name.characters.count > 0 { // 3
                self.rooms.append(Channel(id:id,name:name))
                self.tableView.reloadData()
            } else {
                print("Error! Could not decode channel data")
            }
        })
    }
    
    @IBAction func addChannel(segue:UIStoryboardSegue){
    
        var channelName = (segue.source as! ChannelAddController).channelTextField.text! as String
        
        let newChannelRef = channelRef.childByAutoId()
        let channelItem = [
            "name": channelName
        ]
        newChannelRef.setValue(channelItem)
        
        self.rooms.removeAll()
        observeChannels()
        
        self.tableView.reloadData()

    }
    
    
    
    
    
}

class MyNotiRoomCell: UITableViewCell {
    
    @IBOutlet var roomLabel: UILabel!
    
    var index : Int?
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
