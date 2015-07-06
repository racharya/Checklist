//
//  ViewController.swift
//  Checklists
//
//  Created by Rachana Acharya on 6/10/15.
//  Copyright (c) 2015 Rachana Acharya. All rights reserved.
//

import UIKit
//import ChecklistItem

class ChecklistViewController: UITableViewController, ItemDetailViewControllerDelegate {//Changed regular UIViewController to this
    // This declares that items will hold an array of ChecklistItems objects
    // but it does not actually create that array.
    // At this point, items does not have a value yet.
    //var items: [ChecklistItem]
    var checklist: Checklist!
    
//    required init(coder aDecoder: NSCoder) {
//        // This instantiates the array. Now items contains a valid array object,
//        // but the array has no ChecklistItems objects inside it yet.
//        items = [ChecklistItem]()
//        super.init(coder: aDecoder)
//        loadChecklistItems()
//        
//    }
   
//    func loadChecklistItems() {
//        let path = dataFilePath()
//        if NSFileManager.defaultManager().fileExistsAtPath(path) {
//            if let data = NSData(contentsOfFile: path) {
//                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
//                items = unarchiver.decodeObjectForKey("ChecklistItems") as! [ChecklistItem]
//                unarchiver.finishDecoding()
//            }
//        }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.rowHeight = 44
        title = checklist.name
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* Methods for UITableView's data source - link betwn data and the table view */
    // this method simply tells table view about the number(return statement value) of row of in the screen
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return checklist.items.count // number of rows to be displayed
    }
    // this method is called to obtain the cell for the row
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //dequeue.....ifier makes new copy of cell as needed or recycles an existing cell no longer in use
        let cell = tableView.dequeueReusableCellWithIdentifier("ChecklistItem") as! UITableViewCell
        //        print(indexPath.row)
        //        print(indexPath.section)
        
        let item = checklist.items[indexPath.row]
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
        
        configureCheckmarkForCell(cell, withChecklistItem: item)
        configureTextForCell(cell, withChecklistItem: item)
        return cell
    }//end of data source method
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        //1
        checklist.items.removeAtIndex(indexPath.row) // removing the item from data model
        
        //2
        let indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)// removing from tabel view
        //saveChecklistItems()
    }
    
    /*method to toggle the chekmark */
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath){// gives the cell at the indexPath
            let item = checklist.items[indexPath.row]
            item.toggleChecked()
            
            configureCheckmarkForCell(cell, withChecklistItem: item)
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
       // saveChecklistItems()
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
    func itemDetailViewControllerDidCancel(controller: ItemDetailViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func itemDetailViewController(controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem) {
        let newRowIndex = checklist.items.count
        checklist.items.append(item)
        let indexPath = NSIndexPath(forRow: newRowIndex, inSection: 0)// creating NSIndexPath object to point to new row
        let indexPaths = [indexPath]//temporary array to hold just one inded path item
        tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic) //telling table view about this new row
        dismissViewControllerAnimated(true, completion: nil)
        //saveChecklistItems()
    }//end of implementing delegate methods
    
    
    func itemDetailViewController(controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem){
        if let index = find(checklist.items, item) {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            if let cell = tableView.cellForRowAtIndexPath(indexPath){
                configureTextForCell(cell, withChecklistItem:item)
            }
        }
        dismissViewControllerAnimated(true, completion: nil)
        //saveChecklistItems()
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //1
        if segue.identifier == "AddItem" {
            //2
            let navigationController = segue.destinationViewController as! UINavigationController
            //3
            let controller = navigationController.topViewController as! ItemDetailViewController
            //4
            controller.delegate = self
            
        } else if segue.identifier == "EditItem" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! ItemDetailViewController
            controller.delegate = self
            
            if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                controller.itemToEdit = checklist.items[indexPath.row]
            }
        }
    }
    
//    //Using Document directory to store user's data files
//    func documentsDirectory() -> String {
//        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true) as! [String]
//        return paths[0]
//    }
    
//    func dataFilePath() -> String {
//        return documentsDirectory().stringByAppendingPathComponent("Checklists.plist")
//    }// end of storing user's data files
//    
    // Takes the contents of items[] and in two steps converts this to a block of binary data
    // then writes this data to a file
    
//    func saveChecklistItems() {
//        //NSMutable meaning it will write itself to file specified by dataFilePath
//        let data = NSMutableData()
//        //NSKeyedArchiver is a form of NSCoder that creates plist files
//        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
//        archiver.encodeObject(items, forKey: "ChecklistItems")
//        
//        archiver.finishEncoding()
//        data.writeToFile(dataFilePath(), atomically: true)
//    }
}//end of class ChecklistViewController

