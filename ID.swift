//
//  ID.swift
//  IntraV2
//
//  Created by Franck PETRIZ on 17/01/2015.
//  Copyright (c) 2015 Keuha. All rights reserved.
//

import Foundation
import CoreData

class ID: NSManagedObject {
    
    @NSManaged var log: String
    @NSManaged var pass: String
    
}
