//
//  CalendarManager.swift
//  Allowance
//
//  Created by Nickolas Lanasa on 9/11/15.
//  Copyright (c) 2015 Nytek Productions. All rights reserved.
//

import Foundation
import EventKit

/**
* CalendarManagerDelegate is called when the EventStore database is updated.
*/
protocol CalendarManagerDelegate {
    func eventStoreDidUpdate(manager: AnyObject)
}

class CalendarManager {
    
    let eventStore = EKEventStore()
    var calendars = [AnyObject]()
    var delegate: CalendarManagerDelegate?
    
    init() {
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "processUpdatedCalendarEvents:",
            name: EKEventStoreChangedNotification,
            object: nil)
    }
    
    /**
    This will notify the delegate when the EventStore database
    is updated.
    
    :param: notification The notification object from NSNotificationCenter.
    */
    @objc func processUpdatedCalendarEvents(notification: NSNotification) {
        delegate?.eventStoreDidUpdate(self)
    }
    
    /**
    This method will check if the user allowed access to their EventStore database.
    
    :param: completion The closure that is called when method is done executing.
    */
    func checkEventStoreAccessForCalendar(completion:((Bool) -> Void)!) {
        var status = EKEventStore.authorizationStatusForEntityType(EKEntityTypeEvent)
        
        switch status {
        case .Authorized:
            self.accessGrantedForCalendar()
            completion(true)
        case .NotDetermined: self.requestAccess({ (success) -> Void! in
            completion(success)
        })
        case .Denied: completion(false)
        case .Restricted: completion(false)
        default: break
        }
    }
    
    /**
    Called when user grants access to EventStore. It will then request all the
    calendars the user has stored.
    */
    func accessGrantedForCalendar() {
        calendars = self.eventStore.calendarsForEntityType(EKEntityTypeEvent)
    }
    
    /**
    Requests access to EventStore.
    
    :param: completion The closure to execute when execution is finished.
    */
    func requestAccess(completion:((Bool) -> Void!)) {
        eventStore.requestAccessToEntityType(EKEntityTypeEvent, completion: { (granted: Bool, error: NSError!) -> Void in
            if granted {
                self.accessGrantedForCalendar()
            }
            
            completion(granted)
        })
    }
    
    /**
    Fetches events between two dates.
    
    :param: startDate  The starting date.
    :param: endDate    The end date.
    :param: completion The closure to execute when execution is finished with found events.
    */
    func fetchEventsBetweenDates(startDate: NSDate!, endDate: NSDate!, completion:([AnyObject]) -> Void) {
        checkEventStoreAccessForCalendar { (granted) -> Void in
            if granted {
                var predicate = self.eventStore.predicateForEventsWithStartDate(startDate, endDate: endDate, calendars: self.calendars)
                var results = self.eventStore.eventsMatchingPredicate(predicate)
                return completion(results)
            } else {
                return completion([])
            }
        }
    }
    
    /**
    Fetches events for a specific day.
    
    :param: day        The day date.
    :param: completion The closure to execute when execution is finished with found events.
    */
    func fetchEventsForDay(day: NSDate!, completion:([AnyObject]?) -> Void) {
        checkEventStoreAccessForCalendar { (granted) -> Void in
            if granted {
                var beginningOfDay = day.beginningOfDayDate!
                var endOfDay = beginningOfDay.endOfDayDate
                var predicate = self.eventStore.predicateForEventsWithStartDate(beginningOfDay, endDate: endOfDay, calendars: self.calendars)
                return completion(self.eventStore.eventsMatchingPredicate(predicate))
            } else {
                return completion([])
            }
        }
    }
    
    // ALARMS
    
    /**
    Fetches alarms between two dates.
    
    :param: startDate  The starting date.
    :param: endDate    The ending date.
    :param: completion The completion closure called at the end of execution with found events.
    */
    func fetchAlarmsBetweenDates(startDate: NSDate!, endDate: NSDate!, completion:([AnyObject]) -> Void) {
        self.eventStore.requestAccessToEntityType(EKEntityTypeEvent, completion: { (granted, error) -> Void in
            if granted {
                var predicate = self.eventStore.predicateForEventsWithStartDate(startDate, endDate: endDate, calendars: nil)
                return completion(self.eventStore.eventsMatchingPredicate(predicate))
            } else {
                return completion([])
            }
        })
    }
    
    /**
    Fetches all reminders for a specific day.
    
    :param: day        The day date.
    :param: completion The completion closure called at the end of execution with found events.
    */
    func fetchAlarmsForDay(day: NSDate!, completion:([AnyObject]) -> Void) {
        checkEventStoreAccessForCalendar { (granted) -> Void in
            if granted {
                var beginningOfDay = day.beginningOfDayDate!
                var endOfDay = beginningOfDay.endOfDayDate
                var predicate = self.eventStore.predicateForEventsWithStartDate(beginningOfDay, endDate: endOfDay, calendars: self.calendars)
                return completion(self.eventStore.eventsMatchingPredicate(predicate))
            } else {
                return completion([])
            }
        }
    }
}
