//
//  NotiRoomSearchViewController.swift
//  Noti
//
//  Created by 이채원 on 2016. 12. 1..
//  Copyright © 2016년 이채원. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class NotiRoomSearchViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating {
    
    private lazy var channelRef: FIRDatabaseReference = FIRDatabase.database().reference().child("channels")
    private var channelRefHandle: FIRDatabaseHandle?

    @IBOutlet var notiRoomTableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var searchDB : [String:Channel] = [:]
    var filteredDB : [String:Channel] = [:]
    var filteredDBKeys : [String] = []
    
    deinit {
        if let refHandle = channelRefHandle {
            channelRef.removeObserver(withHandle: refHandle)
        }
    }
    
    override func viewDidLoad() {
        
        observeChannels()
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        notiRoomTableView.tableHeaderView = searchController.searchBar

        // notiRoomTableView delegate와 datasourse segue는 스토리보드에서 연결됨.
        
        super.viewDidLoad()
        
        //searchController.searchBar.frame.origin = CGPoint(x: 0, y: UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.frame.height)!)
        //self.view.addSubview(searchController.searchBar)
        
        //
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredDB.count
        }
        
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotiRoomSearchViewCell", for: indexPath) as! NotiRoomSearchViewCell
        
        cell.resultLabel.text = filteredDBKeys[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }

    func updateSearchResults(for searchController: UISearchController) {
        
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    
    /* function for data filter */
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        
        
        
        let tempDB = searchDB.filter { room in
            return room.key.lowercased().contains(searchText.lowercased())
            }
        
        self.filteredDBKeys.removeAll()
        self.filteredDB.removeAll()
        for text in tempDB
        {
            self.filteredDB[text.key] = text.value
            self.filteredDBKeys.append(text.key)
        }
        
        notiRoomTableView.reloadData()
    }
    
    /*
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }*/
    
    // MARK: Firebase related methods
    private func observeChannels() {
        // Use the observe method to listen for new
        // channels being written to the Firebase DB
        channelRefHandle = channelRef.observe(.childAdded, with: { (snapshot) -> Void in // 1
            let channelData = snapshot.value as! Dictionary<String, AnyObject> // 2
            let id = snapshot.key
            if let name = channelData["name"] as! String!,let about = channelData["about"] as! String!, name.characters.count > 0 { // 3
                self.searchDB[name] = Channel(id:id,name:name,about:about)
                //self.notiRoomTableView.reloadData()
            } else {
                print("Error! Could not decode channel data")
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "detailViewSegue")
        {
            let toVC = segue.destination as! RoomDetailViewController
            let cell = sender as! NotiRoomSearchViewCell
            
            toVC.channel = searchDB[cell.resultLabel.text!]
        }
    }
}

class NotiRoomSearchViewCell: UITableViewCell {
    
    @IBOutlet var resultLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
