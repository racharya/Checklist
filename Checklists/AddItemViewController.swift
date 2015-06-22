//
//  AddItemViewController.swift
//  Checklists
//
//  Created by Rachana Acharya on 6/22/15.
//  Copyright (c) 2015 Rachana Acharya. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController {
    
    @IBAction func cancel(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func done(){
        dismissViewControllerAnimated(true, completion: nil)
    }
}
