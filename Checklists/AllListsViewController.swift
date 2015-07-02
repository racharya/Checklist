//
//  AllListsViewController.swift
//  Checklists
//
//  Created by Rachana Acharya on 7/1/15.
//  Copyright (c) 2015 Rachana Acharya. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController {
    var lists: [Checklist] // array to hold checklist objects
    
    required init(coder aDecoder: NSCoder) {
    //1: Give lists variable a value
    lists = [Checklist]()
    //2: Call super version of init(coder)
    super.init(coder: aDecoder)
    //3: Create a new Checklist object, give name , add to array
    var list = Checklist()
    list.name = "Birthdays"
    lists.append(list)
    
    //4
    list = Checklist()
    list.name = "Groceries"
    lists.append(list)
    
    list = Checklist()
    list.name = "Cool Apps"
    lists.append(list)
    
    list = Checklist()
    list.name = "To Do"
    lists.append(list)
    
}
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 3
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        var cell: UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style:.Default, reuseIdentifier: cellIdentifier)
        }
        cell.textLabel!.text = "List \(indexPath.row)"
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("ShowChecklist", sender: nil)
    }

 

}
