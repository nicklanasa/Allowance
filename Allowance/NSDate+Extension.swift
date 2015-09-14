//
//  NSDate+Extension.swift
//  Allowance
//
//  Created by Nickolas Lanasa on 9/11/15.
//  Copyright (c) 2015 Nytek Productions. All rights reserved.
//

import Foundation

enum WeekDay: NSInteger {
    case WeekDaySunday = 1
    case WeekDayMonday = 2
    case WeekDayTuesday = 3
    case WeekDayWednesday = 4
    case WeekDayThursday = 5
    case WeekDayFriday = 6
    case WeekDaySaturday = 7
}

extension NSDate {
    
    // Creates a date with the previous month starting at the first day.
    var startOfLastMonth: NSDate? {
        var cal = NSCalendar.currentCalendar()
        var comps = NSDateComponents()
        comps.month = -1
        return cal.dateByAddingComponents(comps, toDate: self, options: nil)?.startOfMonth
    }
    
    // Creates a date with the following month starting at the first day.
    var startOfNextMonth: NSDate? {
        var cal = NSCalendar.currentCalendar()
        var comps = NSDateComponents()
        comps.month = +1
        return cal.dateByAddingComponents(comps, toDate: self, options: nil)?.startOfMonth
    }
    
    // Creates a string with the month and year words.
    var monthYearString: NSString {
        var formatter = NSDateFormatter()
        formatter.dateFormat = "MMMM YYYY"
        return formatter.stringFromDate(self)
    }
    
    // Returns the current weekday number based on the self.
    var weekDayIndex: NSInteger {
        var cal = NSCalendar.currentCalendar()
        cal.locale = NSLocale.currentLocale()
        return cal.components(.CalendarUnitYear | .CalendarUnitMonth |  .CalendarUnitDay | .CalendarUnitWeekOfMonth, fromDate: self).weekday
    }
    
    // Returns the day number based on the self.
    var dayOfMonth: NSInteger {
        return NSCalendar.currentCalendar().components(.CalendarUnitDay, fromDate: self).day
    }
    
    // Get number of days from self.
    var dayCount: NSInteger {
        return NSCalendar.currentCalendar().rangeOfUnit(.CalendarUnitDay, inUnit: .CalendarUnitMonth, forDate: self).length
    }
    
    // Returns the day number based on the self as string.
    var dayNumber: NSString {
        return String(dayOfMonth)
    }
    
    // Returns the first day of the self.
    var firstDayOfMonth: NSInteger {
        var comps = NSCalendar.currentCalendar().components(.CalendarUnitDay | .CalendarUnitMonth | .CalendarUnitYear, fromDate: self)
        comps.day = 1
        if let firstDayDate = NSCalendar.currentCalendar().dateFromComponents(comps) {
            return firstDayDate.weekDayIndex - 1
        } else {
            return 0
        }
    }
    
    // Creates a date with the self and sets the day property to the first day in the month
    var startOfMonth: NSDate? {
        var comps = NSCalendar.currentCalendar().components(.CalendarUnitDay | .CalendarUnitMonth | .CalendarUnitYear, fromDate: self)
        comps.day = 1
        return NSCalendar.currentCalendar().dateFromComponents(comps)!
    }
    
    // Creates a date with the self and sets the day property to the first day in the month
    var endOfMonth: NSDate? {
        var comps = NSCalendar.currentCalendar().components(.CalendarUnitDay | .CalendarUnitMonth | .CalendarUnitYear, fromDate: self)
        comps.day = self.dayCount
        return NSCalendar.currentCalendar().dateFromComponents(comps)!
    }
    
    // Checks if self is on the weekend.
    var isOnWeekend: Bool {
        var comps = NSCalendar.currentCalendar().components(.CalendarUnitWeekday, fromDate: self)
        if comps.weekday == WeekDay.WeekDaySunday.rawValue ||
            comps.weekday == WeekDay.WeekDaySaturday.rawValue {
                return true
        }
        return false
    }
    
    // Gets the current week for self.
    var currentWeekInMonth: NSInteger {
        return NSCalendar.currentCalendar().components(.CalendarUnitWeekOfMonth, fromDate: self).weekOfMonth
    }
    
    // Creates a date with the self and sets the day property to the last day in the month
    var lastDayDate: NSDate? {
        var cal = NSCalendar.currentCalendar()
        var daysInMonth = cal.rangeOfUnit(.CalendarUnitDay, inUnit: .CalendarUnitMonth, forDate: self)
        var comps = cal.components(.CalendarUnitDay | .CalendarUnitMonth | .CalendarUnitYear, fromDate: self)
        comps.day = daysInMonth.length
        return cal.dateFromComponents(comps)
    }
    
    // Returns a date set to the beginning of the day.
    var beginningOfDayDate: NSDate? {
        return NSCalendar.currentCalendar().startOfDayForDate(self)
    }
    
    // Returns a date set to the end of the day.
    var endOfDayDate: NSDate? {
        let components = NSDateComponents()
        components.hour = 23
        components.minute = 59
        components.second = 59
        return NSCalendar.currentCalendar().dateByAddingComponents(components,
            toDate: self.beginningOfDayDate!,
            options: NSCalendarOptions(0))
    }
    
    /**
    Creates a date for a specific day in the month of fromDate.
    
    :param: day      The day you want to use for the day.
    :param: fromDate The date you want to create the date from with the passed in day.
    
    :returns: The created date.
    */
    class func dateWithDayInMonth(day: NSInteger, fromDate: NSDate) -> NSDate {
        var comps = NSCalendar.currentCalendar().components(.CalendarUnitYear | .CalendarUnitYear | .CalendarUnitMonth, fromDate: fromDate)
        comps.day = day
        return NSCalendar.currentCalendar().dateFromComponents(comps)!
    }
    
    /**
    Compares self to the current date.
    
    :returns: A boolean value whether it's the current date.
    */
    func compareAgainstCurrentMonthAndYear() -> Bool {
        var cal = NSCalendar.currentCalendar()
        var month = cal.components(.CalendarUnitMonth, fromDate: self).month
        var year = cal.components(.CalendarUnitYear, fromDate: self).year
        if month == cal.components(.CalendarUnitMonth, fromDate: NSDate()).month &&
            year == cal.components(.CalendarUnitYear, fromDate: NSDate()).year {
                return true
        } else {
            return false
        }
    }
    
    /**
    Get week day number
    
    :param: dayIndex The weekday index to create the date from.
    
    :returns: The weekday number as a string.
    */
    func weekDayNumber(dayIndex: NSInteger) -> NSString {
        var cal = NSCalendar.currentCalendar()
        cal.locale = NSLocale.currentLocale()
        var comps = cal.components(.CalendarUnitYear | .CalendarUnitMonth |  .CalendarUnitDay | .CalendarUnitWeekday | NSCalendarUnit.CalendarUnitWeekOfMonth | .CalendarUnitWeekOfYear, fromDate: self)
        comps.weekday = dayIndex
        var date = cal.dateFromComponents(comps)
        return String(cal.components(.CalendarUnitDay, fromDate: date!).day)
    }
    
    /**
    Get week day date
    
    :param: dayIndex The weekday index to create the date from.
    
    :returns: The date created from the weekday index.
    */
    func weekDayDate(dayIndex: NSInteger) -> NSDate {
        var cal = NSCalendar.currentCalendar()
        var comps = cal.components(.CalendarUnitYear | .CalendarUnitMonth | .CalendarUnitWeekOfYear, fromDate: self)
        comps.weekday = dayIndex
        var date = cal.dateFromComponents(comps)!
        return date
    }
}
