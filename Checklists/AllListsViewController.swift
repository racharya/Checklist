//
//  AllListsViewController.swift
//  Checklists
//
//  Created by M.I. Hollemans on 18/09/14.
//  Copyright (c) 2014 Razeware. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController, ListDetailViewControllerDelegate, UINavigationControllerDelegate {
    var dataModel: DataModel!
    
//    required init(coder aDecoder: NSCoder) {
//        
//        lists = [Checklist]()
//        super.init(coder: aDecoder)
//        loadChecklists()
//        
//        lists = [Checklist]()
//        
//        super.init(coder: aDecoder)
//        
//        var list = Checklist(name: "Birthdays")
//        lists.append(list)
//        
//        list = Checklist(name: "Groceries")
//        lists.append(list)
//        
//        list = Checklist(name: "Cool Apps")
//        lists.append(list)
//        
//        list = Checklist(name: "To Do")
//        lists.append(list)
//        
//        for list in lists {
//            let item = ChecklistItem()
//            item.text = "Item for \(list.name)"
//            list.items.append(item)
//        }
      //}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //view controller makes itself the delegate for the navi controller
        navigationController?.delegate = self// accessing view controller's navigation controller property
        let index = dataModel.indexOfSelectedChecklist
        
        if index >= 0 && index < dataModel.lists.count {
            let checklist = dataModel.lists[index]
            performSegueWithIdentifier("ShowChecklist", sender: checklist)
        }
    }
    //happens before viewDidAppear when view is about to become visible
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData() //simple way to fix updating no. of remaining checklist items
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.lists.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "Cell"
        var cell: UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
        if cell == nil {
            //the .subtitle cell sytle adds a second, smaller label underneath the main label
            cell = UITableViewCell(style: .Subtitle, reuseIdentifier: cellIdentifier)
        }
        
        let checklist = dataModel.lists[indexPath.row]
        cell.textLabel!.text = checklist.name
        cell.accessoryType = .DetailDisclosureButton
        let count = checklist.countUncheckedItems()
        if checklist.items.count == 0 {
            cell.detailTextLabel!.text = "(No Items)"
        }
        else if count == 0 {
            cell.detailTextLabel!.text = "All Done!"
          
        } else {
            cell.detailTextLabel!.text = "\(count) Remaining"
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //store the index of the selected row into NSUserDefaults under the key "ChecklistIndex"
        dataModel.indexOfSelectedChecklist = indexPath.row
        let checklist = dataModel.lists[indexPath.row]
        performSegueWithIdentifier("ShowChecklist", sender: checklist)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle,forRowAtIndexPath indexPath: NSIndexPath) {
        dataModel.lists.removeAtIndex(indexPath.row)
        
        let indexPaths = [indexPath]
        tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
    }
    
    // creates the view controller object for Add/Edit Checklist screen and show it on the screen.
    // This is roughly equi to what a segue would do behind the scenes
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        let navigationController = storyboard!.instantiateViewControllerWithIdentifier("ListNavigationController") as! UINavigationController
        
        let controller = navigationController.topViewController as! ListDetailViewController
        controller.delegate = self
        
        let checklist = dataModel.lists[indexPath.row]
        controller.checklistToEdit = checklist
        
        presentViewController(navigationController, animated: true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowChecklist" {
            let controller = segue.destinationViewController as! ChecklistViewController
            controller.checklist = sender as! Checklist
        } else if segue.identifier == "AddChecklist" {
            let navigationController = segue.destinationViewController as! UINavigationController
            let controller = navigationController.topViewController as! ListDetailViewController
            controller.delegate = self
            controller.checklistToEdit = nil
        }
    }
    
    func listDetailViewControllerDidCancel(controller: ListDetailViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func listDetailViewController(controller: ListDetailViewController, didFinishAddingChecklist checklist: Checklist) {
        dataModel.lists.append(checklist)
        dataModel.sortChecklists()
        tableView.reloadData()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func listDetailViewController(controller: ListDetailViewController, didFinishEditingChecklist checklist: Checklist) {
        dataModel.sortChecklists()
        tableView.reloadData()
        dismissViewControllerAnimated(true, completion: nil)
    }
    // This method is called whenever the navigation controller slides to a new screen
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        if viewController === self {// 3 equal signs checks if two variables refer to the exact same object, more correct than 2 equals
            dataModel.indexOfSelectedChecklist = -1
        }
    }
    
    
}
