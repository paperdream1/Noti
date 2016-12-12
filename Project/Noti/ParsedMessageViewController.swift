//
//  ParsedMessageViewController.swift
//  Noti
//
//  Created by 이채원 on 2016. 11. 3..
//  Copyright © 2016년 이채원. All rights reserved.
//

import Foundation
import UIKit
import EventKit
import Reductio

class ParsedMessageController: UIViewController {
    
    
    
    @IBOutlet var titleLabel: UITextField!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var datePicker: UIDatePicker!
    
    @IBAction func whenCanceled(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var originalMessage:String?
    
    //var eventStore = EKEventStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //checkCalendarAuthorizationStatus()
        
        Reductio.keywords(from: originalMessage!, count: 20, completion: { words in
            self.titleLabel.text = Reductio.keyPhrase(word: words[0])
        })
        
        self.descriptionTextView.text = originalMessage
        self.descriptionTextView.layer.cornerRadius = 5
        self.descriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        self.descriptionTextView.layer.borderWidth = 2
        

        //self.datePicker.date
    }
    /*
    func checkCalendarAuthorizationStatus() {
        let status = EKEventStore.authorizationStatus(for: EKEntityType.event)
        
        switch (status) {
        case EKAuthorizationStatus.notDetermined:
            // This happens on first-run
            requestAccessToCalendar()
        case EKAuthorizationStatus.authorized:
            // Things are in line with being able to show the calendars in the table view
            loadCalendars()
            refreshTableView()
        case EKAuthorizationStatus.restricted, EKAuthorizationStatus.denied:
            // We need to help them give us permission
            needPermissionView.fadeIn()
        }
    }*/
    
    @IBAction func whenEventCreate(_ sender: Any) {
        
        let startDate = (self.datePicker.date as NSDate).addingTimeInterval(3600)
        let endDate = startDate.addingTimeInterval(3600)
        
        addEventToCalendar(title: self.titleLabel.text!, description: self.descriptionTextView.text, startDate: startDate, endDate: endDate)
        
        let alertView = UIAlertController(title: "캘린더에 등록되었습니다", message: "", preferredStyle: UIAlertControllerStyle.alert)
        let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        alertView.addAction(alertAction)
        self.present(alertView, animated: true, completion: nil)
        
        //self.dismiss(animated: true, completion: nil)
    }
    
    func addEventToCalendar(title: String, description: String?, startDate: NSDate, endDate: NSDate, completion: ((_ success: Bool, _ error: NSError?) -> Void)? = nil) {
        let eventStore = EKEventStore()
        
        eventStore.requestAccess(to: .event, completion: { (granted, error) in
            if (granted) && (error == nil) {
                let event = EKEvent(eventStore: eventStore)
                event.title = title
                event.startDate = startDate as Date
                event.endDate = endDate as Date
                event.notes = description
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                } catch let e as NSError {
                    completion?(false, e)
                    return
                }
                completion?(true, nil)
            } else {
                completion?(false, error as NSError?)
            }
        })
    }
}
