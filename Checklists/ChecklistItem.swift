//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Rachana Acharya on 6/15/15.
//  Copyright (c) 2015 Rachana Acharya. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject, NSCoding {
    var text = ""
    var checked = false
    
    init(text: String, checked: Bool) {
        self.text = text
        self.checked = checked
        super.init()
    }
    
    func toggleChecked() {
        checked = !checked
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(text, forKey: "Text")
        aCoder.encodeBool(checked, forKey: "Checked")
    }
    
    //needed to make the app compile without errors
    required init(coder aDecoder: NSCoder) {
        text = aDecoder.decodeObjectForKey("Text") as! String
        checked = aDecoder.decodeBoolForKey("Checked")
        super.init()
    }
    
    //needed to build the app, keeps compiler happy
    override init() {
        super.init()
    }
}