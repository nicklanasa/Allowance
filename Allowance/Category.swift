//
//  Category.swift
//  Allowance
//
//  Created by Nickolas Lanasa on 9/12/15.
//  Copyright (c) 2015 Nytek Productions. All rights reserved.
//

import Foundation
import CoreData

@objc(Category)
class Category: NSManagedObject {

    @NSManaged var color: AnyObject
    @NSManaged var name: String
    @NSManaged var allowances: NSSet

}
