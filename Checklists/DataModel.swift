//
//  DataModel.swift
//  Checklists
//
//  Created by Rachana Acharya on 7/6/15.
//  Copyright (c) 2015 Rachana Acharya. All rights reserved.
//

import Foundation

// takes over the responsibilities of loading and saving the to-do lists from AllListsViewController
class DataModel {
    var lists = [Checklist]()
    
    init() { //as soon as DataModel object is created, it will attempt to load Checklists.plist
        loadChecklists()
        registerDefaults()
        handleFirstTime()
    }
    //load/save code
    func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true) as! [String]
        return paths[0]
    }
    func dataFilePath() -> String {
        return documentsDirectory().stringByAppendingPathComponent("Checklists.plist")
    }
    
    func saveChecklists() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(lists, forKey: "Checklists")
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    func loadChecklists() {
        let path = dataFilePath()
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            if let data = NSData(contentsOfFile: path){
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                lists = unarchiver.decodeObjectForKey("Checklists") as! [Checklist]
                unarchiver.finishDecoding()
                sortChecklists()
            }
        }
    }// end of load/save code
    
    func registerDefaults() {
        //creates a new dictionary and adds the value -1 for the key ChecklistIndex
        // dictionary contains two items
        let dictionary = ["ChecklistIndex": -1, "FirstTime": true]
        
        NSUserDefaults.standardUserDefaults().registerDefaults(dictionary)
    }
    
    var indexOfSelectedChecklist: Int {
        get {// when app reads the value
            return NSUserDefaults.standardUserDefaults().integerForKey("ChecklistIndex")
        }
        
        set{// when app writes a value
            NSUserDefaults.standardUserDefaults().setInteger(newValue, forKey: "ChecklistIndex")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    func handleFirstTime() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let firstTime = userDefaults.boolForKey("FirstTime")
        if firstTime {
            let checklist = Checklist(name: "List")
            lists.append(checklist)
            indexOfSelectedChecklist = 0
            userDefaults.setBool(false, forKey: "FirstTime")
        }
    }
    
    func sortChecklists() {
        lists.sort({checklist1, checklist2 in return
            checklist1.name.localizedStandardCompare(checklist2.name) == NSComparisonResult.OrderedAscending})
    }
}
