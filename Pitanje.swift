//
//  Pitanje.swift
//  Kviz
//
//  Created by Antonio Delivuk on 19/05/15.
//  Copyright (c) 2015 Kristijan Delivuk. All rights reserved.
//

import Foundation
import CoreData

class Pitanje: NSManagedObject {

    @NSManaged var odgDva: String
    @NSManaged var odgJedan: String
    @NSManaged var odgTocan: String
    @NSManaged var odgTri: String
    @NSManaged var pitanje: String
    @NSManaged var kvizPitanja: Kviz

}
