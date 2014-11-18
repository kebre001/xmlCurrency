//
//  Forex.swift
//  xmlParser
//
//  Created by Kevin Brejcha on 2014-11-18.
//  Copyright (c) 2014 Kevin Brejcha. All rights reserved.
//

import Foundation
import CoreData

class Forex: NSManagedObject {

    @NSManaged var country: String
    @NSManaged var rate: NSNumber

}
