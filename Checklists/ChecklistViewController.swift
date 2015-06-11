//
//  ViewController.swift
//  Checklists
//
//  Created by Rachana Acharya on 6/10/15.
//  Copyright (c) 2015 Rachana Acharya. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {//Changed regular UIViewController to this

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
        return 100 // number of rows to be displayed
    }
    // this method is called to obtain the cell for the row
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //dequeue.....ifier makes new copy of cell as needed or recycles an existing cell no longer in use
        let cell = tableView.dequeueReusableCellWithIdentifier("ChecklistItem") as! UITableViewCell
//        print(indexPath.row)
//        print(indexPath.section)
        let label = cell.viewWithTag(1000) as! UILabel
        if indexPath.row % 5 == 0{
            label.text = "Walk the dog"
        }
        if indexPath.row % 5 == 1{
            label.text = "Brush my teeth"
        }
        if indexPath.row % 5 == 2{
            label.text = "Learn iOS development"
        }
        if indexPath.row % 5 == 3{
            label.text = "Soccer Practice"
        }
        if indexPath.row % 5 == 4{
            label.text = "Eat ice cream"
        }
        return cell
    }//end of data source method
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

