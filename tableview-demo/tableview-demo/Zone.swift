//
//  Zone.swift
//  tableview-demo
//
//  Created by Wendy Sanarwanto on 2/21/16.
//  Copyright © 2016 saintc0d3r. All rights reserved.
//

import Foundation

class Zone{
    var level: Level
    var name: String
    var id: Int
    
    init(level: Level, id: Int, name: String){
        self.level = level
        self.name = name
        self.id = id
    }
}
