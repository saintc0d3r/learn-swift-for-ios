//
//  Project.swift
//  tableview-demo
//
//  Created by Wendy Sanarwanto on 2/20/16.
//  Copyright © 2016 saintc0d3r. All rights reserved.
//

import Foundation

class Project {
    var name: String
    var id: Int
    var levels = [Level]()
    
    init(id: Int, name: String){
        self.name = name
        self.id = id
    }
}