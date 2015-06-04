//
//  PitanjaModel.swift
//  Kviz
//
//  Created by Antonio Delivuk on 17/05/15.
//  Copyright (c) 2015 Kristijan Delivuk. All rights reserved.
//

import UIKit

class PitanjeModel: NSObject {
   
    var pitanje : String = String()
    var odgJedan : String = String()
    var odgDva : String = String()
    var odgTri : String = String()
    var tocanOdgovor : String = String()
    
    override init() {
        self.pitanje = ""
        self.tocanOdgovor = ""
        self.odgJedan = ""
        self.odgDva = ""
        self.odgTri = ""
    }
    
    init (pitanje : String , odgJedan : String , odgDva : String , odgTri : String , tocanOdgovor : String) {
    
        self.pitanje = pitanje
        self.tocanOdgovor = tocanOdgovor
        self.odgJedan = odgJedan
        self.odgDva = odgDva
        self.odgTri = odgTri
    }
    
}
