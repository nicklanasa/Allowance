//
//  CreateAllowanceTableViewController.swift
//  Allowance
//
//  Created by Nickolas Lanasa on 9/13/15.
//  Copyright (c) 2015 Nytek Productions. All rights reserved.
//

import UIKit

enum CreateAllowanceSection: Int {
    case Title
    case Date
    case Category
    case Repeat
    case Quantity
}

class CreateAllowanceTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44.0
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let section = CreateAllowanceSection(rawValue: indexPath.section)!
        switch section {
        case .Date:
            var cell = tableView.dequeueReusableCellWithIdentifier("DateCell") as! DateCell
            return cell
        case .Category:
            var cell = tableView.dequeueReusableCellWithIdentifier("CategoryCell") as! CategoryCell
            return cell
        case .Repeat:
            var cell = tableView.dequeueReusableCellWithIdentifier("RepeatCell") as! RepeatCell
            return cell
        case .Quantity:
            var cell = tableView.dequeueReusableCellWithIdentifier("QuantityCell") as! QuantityCell
            return cell
        default:
            var cell = tableView.dequeueReusableCellWithIdentifier("TitleCell") as! TitleCell
            return cell
        }
    }
    
    
}
