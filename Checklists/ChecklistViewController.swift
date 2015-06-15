//
//  ViewController.swift
//  Checklists
//
//  Created by Rachana Acharya on 6/10/15.
//  Copyright (c) 2015 Rachana Acharya. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {//Changed regular UIViewController to this
    
    var row0text = "Walk the dog"
    var row1text = "Brush teeth"
    var row2text = "Learn iOS development"
    var row3text = "Soccer practice"
    var row4text = "Eat ice cream"
    var row0checked = false
    var row1checked = false
    var row2checked = false
    var row3checked = false
    var row4checked = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* Methods for UITableView's data source - link betwn data and the table view */
    // this method simply tells table view about the number(return statement value) of row of in the screen
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 5 // number of rows to be displayed
    }
    // this method is called to obtain the cell for the row
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //dequeue.....ifier makes new copy of cell as needed or recycles an existing cell no longer in use
        let cell = tableView.dequeueReusableCellWithIdentifier("ChecklistItem") as! UITableViewCell
        //        print(indexPath.row)
        //        print(indexPath.section)
        let label = cell.viewWithTag(1000) as! UILabel
        if indexPath.row % 5 == 0{
            label.text = row0text
        }
        if indexPath.row % 5 == 1{
            label.text = row1text
        }
        if indexPath.row % 5 == 2{
            label.text = row2text
        }
        if indexPath.row % 5 == 3{
            label.text = row3text
        }
        if indexPath.row % 5 == 4{
            label.text = row4text
        }
        return cell
    }//end of data source method
    
    /*method to toggle the chekmark */
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath){// gives the cell at the indexPath
            
            var isChecked = false
            if indexPath.row == 0{
                row0checked = !row0checked
                isChecked = row0checked
                
            } else if indexPath.row == 1{
                row1checked = !row1checked
                isChecked = row1checked
                
            } else if indexPath.row == 2 {
                row2checked = !row2checked
                isChecked = row2checked
                
            } else if indexPath.row == 3 {
                row3checked = !row3checked
                isChecked = row3checked
                
            } else if indexPath.row == 4 {
                row4checked = !row4checked
                isChecked = row4checked
            }
            if isChecked {
                cell.accessoryType = .Checkmark
            } else {
                cell.accessoryType = .None
            }
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

