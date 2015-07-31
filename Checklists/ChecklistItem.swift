//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Rachana Acharya on 6/15/15.
//  Copyright (c) 2015 Rachana Acharya. All rights reserved.
//

import Foundation
import UIKit

class ChecklistItem: NSObject, NSCoding {
    var text = ""
    var checked = false
    
    var dueDate = NSDate()
    var shouldRemind = false
    var itemID: Int
//    
//    init(text: String, checked: Bool) {
//        self.text = text
//        self.checked = checked
//        super.init()
//    }
    
    func toggleChecked() {
        checked = !checked
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(text, forKey: "Text")
        aCoder.encodeBool(checked, forKey: "Checked")
        aCoder.encodeObject(dueDate, forKey: "DueDate")
        aCoder.encodeBool(shouldRemind, forKey: "shouldRemind")
        aCoder.encodeInteger(itemID, forKey: "itemID")
    }
    
    //needed to make the app compile without errors
    required init(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObjectForKey("Text") as! String
        checked = aDecoder.decodeBoolForKey("Checked")
        dueDate = aDecoder.decodeObjectForKey("DueDate") as! NSDate
        shouldRemind = aDecoder.decodeBoolForKey("shouldRemind")
        itemID = aDecoder.decodeIntegerForKey("ItemID")
        super.init()
    }
    
    //needed to build the app, keeps compiler happy
    override init() {
        itemID = DataModel.nextChecklistItemID()
        super.init()
    }
   
    func scheduleNotification() {
        if shouldRemind && dueDate.compare(NSDate()) != NSComparisonResult.OrderedAscending {
            let localNotification = UILocalNotification()
            localNotification.fireDate = dueDate
            localNotification.timeZone = NSTimeZone.defaultTimeZone()
            localNotification.alertBody = text
            localNotification.soundName = UILocalNotificationDefaultSoundName
            localNotification.userInfo = ["ItemID": itemID]
            UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
            println("Scheduled notification \(localNotification) for itemID \(itemID)")
        }
    }
    
}