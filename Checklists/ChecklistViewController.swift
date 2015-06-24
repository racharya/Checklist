//
//  ViewController.swift
//  Checklists
//
//  Created by Rachana Acharya on 6/10/15.
//  Copyright (c) 2015 Rachana Acharya. All rights reserved.
//

import UIKit
//import ChecklistItem

class ChecklistViewController: UITableViewController, AddItemViewControllerDelegate {//Changed regular UIViewController to this
    // This declares that items will hold an array of ChecklistItems objects
    // but it does not actually create that array.
    // At this point, items does not have a value yet.
    var items: [ChecklistItem]
    
    required init(coder aDecoder: NSCoder) {
        // This instantiates the array. Now items contains a valid array object,
        // but the array has no ChecklistItems objects inside it yet.
        items = [ChecklistItem]()
        
        // This instantiates a new ChecklistItem object. Notice the ().
        let row0item = ChecklistItem()
        row0item.text = "Walk the dog"
        row0item.checked = false
        // This adds the ChecklistItem object into the items array.
        items.append(row0item)
        
        let row1item = ChecklistItem()
        row1item.text = "Brush my teeth"
        row1item.checked = true
        items.append(row1item)
        
        let row2item = ChecklistItem()
        row2item.text = "Learn iOS development"
        row2item.checked = true
        items.append(row2item)
        
        let row3item = ChecklistItem()
        row3item.text = "Soccer practice"
        row3item.checked = false
        items.append(row3item)
        
        let row4item = ChecklistItem()
        row4item.text = "Eat ice cream"
        row4item.checked = true
        items.append(row4item)
        
        super.init(coder: aDecoder)
    }
    
    
    
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
        return items.count // number of rows to be displayed
    }
    // this method is called to obtain the cell for the row
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //dequeue.....ifier makes new copy of cell as needed or recycles an existing cell no longer in use
        let cell = tableView.dequeueReusableCellWithIdentifier("ChecklistItem") as! UITableViewCell
        //        print(indexPath.row)
        //        print(indexPath.section)
        
        let item = items[indexPath.row]
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
        
        configureCheckmarkForCell(cell, withChecklistItem: item)
        configureTextForCell(cell, withChecklistItem: item)
        return cell
    }//end of data source method
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        //1
        items.removeAtIndex(indexPath.row) // removing the item from data model
        
        //2
        let indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)// removing from tabel view
    }
    
    /*method to toggle the chekmark */
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath){// gives the cell at the indexPath
            let item = items[indexPath.row]
            item.toggleChecked()
            
            configureCheckmarkForCell(cell, withChecklistItem: item)
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func configureCheckmarkForCell(cell: UITableViewCell, withChecklistItem item: ChecklistItem) {
        
        let label = cell.viewWithTag(1001) as! UILabel
        if item.checked {
            label.text = "√"
        } else {
            label.text = " "
        }
    }
    
    func configureTextForCell(cell: UITableViewCell, withChecklistItem item: ChecklistItem){
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
    
    //implementing delegatge methods
    func addItemViewControllerDidCancel(controller: AddItemViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addItemViewController(controller: AddItemViewController, didFinishAddingItem item: ChecklistItem) {
        let newRowIndex = items.count
        items.append(item)
        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)// creating NSIndexPath object to point to new row
        let indexPaths = [indexPath]//temporary array to hold just one inded path item
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic) //telling table view about this new row
        dismissViewControllerAnimated(true, completion: nil)
    }//end of implementing delegate methods
    
    
    func addItemViewController(controller: AddItemViewController, didFinishEditingItem item: ChecklistItem){
        if let index = find(items, item) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            if let cell = tableView.cellForRowAtIndexPath(indexPath){
                configureTextForCell(cell, withChecklistItem:item)
            }
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //1
        if segue.identifier == "AddItem" {
            //2
            let navigationController = segue.destinationViewController as! UINavigationController
            //3
            let controller = navigationController.topViewController as! AddItemViewController
            //4
            controller.delegate = self
            
        } else if segue.identifier == "EditItem" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! AddItemViewController
            controller.delegate = self
            
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                controller.itemToEdit = items[indexPath.row]
            }
        }
    }
}

