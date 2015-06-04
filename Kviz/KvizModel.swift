//
//  KvizModel.swift
//  Kviz
//
//  Created by Antonio Delivuk on 17/05/15.
//  Copyright (c) 2015 Kristijan Delivuk. All rights reserved.
//

import UIKit

class KvizModel: NSObject {
    
    var brojPitanja : Int = 0
    var naziv : String = String()
    var opis : String = String()
    var url : String = String()
    var svaPitanja : [PitanjeModel] = [PitanjeModel]()
    var odabranaPitanja : [PitanjeModel] = [PitanjeModel]()
   
}
