//
//  Kviz.swift
//  Kviz
//
//  Created by Antonio Delivuk on 19/05/15.
//  Copyright (c) 2015 Kristijan Delivuk. All rights reserved.
//

import Foundation
import CoreData

class Kviz: NSManagedObject {

    @NSManaged var naziv: String
    @NSManaged var opis: String
    @NSManaged var svaPitanja: NSSet

}
