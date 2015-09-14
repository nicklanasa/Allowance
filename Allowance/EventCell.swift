//
//  EventCell.swift
//  Allowance
//
//  Created by Nickolas Lanasa on 9/13/15.
//  Copyright (c) 2015 Nytek Productions. All rights reserved.
//

import UIKit
import EventKit

class EventCell: UITableViewCell {
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var event: EKEvent! {
        didSet {
            self.titleLabel.text = self.event.title
            if let calendar = self.event.calendar {
                self.colorView.backgroundColor = UIColor(CGColor: calendar.CGColor)
            } else {
                self.colorView.backgroundColor = UIColor.clearColor()
            }
        }
    }
    
}
