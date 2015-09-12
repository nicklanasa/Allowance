//
//  CalendarViewController.swift
//  Allowance
//
//  Created by Nickolas Lanasa on 9/11/15.
//  Copyright (c) 2015 Nytek Productions. All rights reserved.
//

import UIKit
import CVCalendar

class CalendarViewController: UIViewController, CVCalendarViewDelegate, CVCalendarMenuViewDelegate {

    @IBOutlet weak var calendarView: CVCalendarView!
    @IBOutlet weak var menuView: CVCalendarMenuView!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        calendarView.commitCalendarViewUpdate()
        menuView.commitMenuViewUpdate()
    }
    
    // MARK: CVCalendarViewDelegate
    
    func presentationMode() -> CalendarMode {
        return .MonthView
    }
    
    func firstWeekday() -> Weekday {
        return .Sunday
    }
    
    // MARK: CVCalendarMenuViewDelegate
    
    func dayOfWeekTextColor() -> UIColor {
        return UIColor.lightGrayColor()
    }
    
    func dayOfWeekTextUppercase() -> Bool {
        return true
    }
    
    func dayOfWeekFont() -> UIFont {
        return UIFont(name: "Avenir-Medium", size: 13)!
    }
}
