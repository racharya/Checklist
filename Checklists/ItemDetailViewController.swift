//
//  ItemDetailViewController.swift
//  Checklists
//
//  Created by Rachana Acharya on 6/22/15.
//  Copyright (c) 2015 Rachana Acharya. All rights reserved.
//

import UIKit

protocol ItemDetailViewControllerDelegate: class {
    func itemDetailViewControllerDidCancel(controller: ItemDetailViewController)
    func itemDetailViewController(controller: ItemDetailViewController, didFinishAddingItem item: ChecklistItem)
    func itemDetailViewController(controller: ItemDetailViewController, didFinishEditingItem item: ChecklistItem)
    
}

class ItemDetailViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    weak var delegate: ItemDetailViewControllerDelegate?
    var itemToEdit: ChecklistItem?
    
    @IBAction func cancel(){
        delegate?.itemDetailViewControllerDidCancel(self) // does not send message if delegate is nil
        //dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let oldText: NSString = textField.text // new string in the text field
        let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
        
        doneBarButton.enabled = (newText.length > 0)
        return true
    }
    
    @IBAction func done(){
        //        println("Contents of the text field: \(textField.text)")
        //        dismissViewControllerAnimated(true, completion: nil)
        if let item = itemToEdit {// unwrapping an optional
            item.text = textField.text
            delegate?.itemDetailViewController(self, didFinishEditingItem: item)
            
        } else {
            let item = ChecklistItem()
            item.text = textField.text
            item.checked = false
            delegate?.itemDetailViewController(self, didFinishAddingItem: item)//doesnot send message if delegate is nil
        }
    }
    
    // ? says tells swift that you can return nil from this method. Only allowed if ? behind that return type
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil // nil means no value | nothing found | don't do anything etc
    }
    
    //automatically allows keyboard to appear once the Add Item screen opens
    override func viewWillAppear(animated: Bool){
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 44
        
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            doneBarButton.enabled = true
        }
    }
}
