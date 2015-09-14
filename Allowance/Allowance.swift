//
//  Allowance.swift
//  Allowance
//
//  Created by Nickolas Lanasa on 9/12/15.
//  Copyright (c) 2015 Nytek Productions. All rights reserved.
//

import Foundation
import CoreData

@objc(Allowance)
class Allowance: NSManagedObject {

    @NSManaged var completed: NSNumber
    @NSManaged var createdDate: NSDate
    @NSManaged var details: String
    @NSManaged var quantity: NSNumber
    @NSManaged var repeatType: NSNumber
    @NSManaged var title: String
    @NSManaged var category: Category

}
