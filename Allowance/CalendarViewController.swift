//
//  CalendarViewController.swift
//  Allowance
//
//  Created by Nickolas Lanasa on 9/11/15.
//  Copyright (c) 2015 Nytek Productions. All rights reserved.
//

import UIKit
import CVCalendar

class CalendarViewController: UIViewController,
CVCalendarViewDelegate,
CVCalendarViewAppearanceDelegate,
CVCalendarMenuViewDelegate {

    @IBOutlet weak var calendarView: CVCalendarView!
    @IBOutlet weak var menuView: CVCalendarMenuView!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        calendarView.commitCalendarViewUpdate()
        menuView.commitMenuViewUpdate()
        
        self.navigationItem.title = calendarView.presentedDate.globalDescription
    }
    
    // MARK: CVCalendarViewDelegate
    
    func presentedDateUpdated(date: Date) {
        self.navigationItem.title = date.globalDescription
    }
    
    func presentationMode() -> CalendarMode {
        return .MonthView
    }
    
    func firstWeekday() -> Weekday {
        return .Sunday
    }
    
    // MARK: CVCalendarViewAppearanceDelegate
    
    func dayLabelWeekdayFont() -> UIFont {
        return UIFont(name: "Avenir-Medium", size: 13)!
    }
    
    func dayLabelPresentWeekdayFont() -> UIFont {
        return UIFont(name: "Avenir-Heavy", size: 13)!
    }
    
    // MARK: CVCalendarMenuViewDelegate
    
    func dayOfWeekTextColor() -> UIColor {
        return UIColor.lightGrayColor()
    }
    
    func dayOfWeekTextUppercase() -> Bool {
        return true
    }
    
    func dayOfWeekFont() -> UIFont {
        return UIFont(name: "Avenir-Heavy", size: 13)!
    }
}
