//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Rachana Acharya on 6/15/15.
//  Copyright (c) 2015 Rachana Acharya. All rights reserved.
//

import Foundation

class ChecklistItem {
    var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
}