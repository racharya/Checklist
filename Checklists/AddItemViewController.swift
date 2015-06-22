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
    
    // ? says tells swift that you can return nil from this method. Only allowed if ? behind that return type
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil // nil means no value | nothing found | don't do anything etc
    }
}
