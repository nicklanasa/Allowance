//
//  CalendarViewController.swift
//  Allowance
//
//  Created by Nickolas Lanasa on 9/11/15.
//  Copyright (c) 2015 Nytek Productions. All rights reserved.
//

import UIKit
import CVCalendar
import EventKit

class CalendarViewController: UIViewController,
CVCalendarViewDelegate,
CVCalendarViewAppearanceDelegate,
CVCalendarMenuViewDelegate,
UITableViewDelegate,
UITableViewDataSource {

    @IBOutlet weak var calendarView: CVCalendarView!
    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var tableView: UITableView!
    
    var currentDate: Date!
    var calendarEvents: [AnyObject]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.tableView.tableFooterView = UIView()
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44.0
        
        self.calendarView.commitCalendarViewUpdate()
        self.menuView.commitMenuViewUpdate()
        
        self.navigationItem.title = calendarView.presentedDate.globalDescription
        
        self.currentDate = self.calendarView.presentedDate
        
        self.fetchCalendarEvents()
    }
    
    func fetchCalendarEvents() {
        var calendarManager = CalendarManager()
        calendarManager.checkEventStoreAccessForCalendar { (success) -> Void in
            if success {
                calendarManager.fetchEventsForDay(self.currentDate.convertedDate(), completion: { (results) -> Void in
                    self.calendarEvents = results
                })
            }
        }
    }
    
    // MARK: CVCalendarViewDelegate
    
    func didSelectDayView(dayView: DayView) {
        self.currentDate = dayView.date
        self.fetchCalendarEvents()
    }
    
    func presentedDateUpdated(date: Date) {
        self.navigationItem.title = date.globalDescription
        self.currentDate = date
        self.fetchCalendarEvents()
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
    
    // MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("EventCell") as! EventCell
        cell.event = self.calendarEvents?[indexPath.row] as! EKEvent
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.calendarEvents?.count ?? 0
    }
}
