//
//  Currency.swift
//  xmlParser
//
//  Created by Kevin Brejcha on 2014-11-16.
//  Copyright (c) 2014 Kevin Brejcha. All rights reserved.
//

import Foundation
import CoreData

class Currency: NSManagedObject {

    @NSManaged var country: String
    @NSManaged var rate: NSNumber

}
