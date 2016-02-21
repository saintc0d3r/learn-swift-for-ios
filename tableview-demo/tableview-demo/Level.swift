//
//  Level.swift
//  tableview-demo
//
//  Created by Wendy Sanarwanto on 2/20/16.
//  Copyright © 2016 saintc0d3r. All rights reserved.
//

import Foundation

class Level{
    var project: Project
    var name: String
    var id: Int
    
    init(project: Project, id: Int, name: String){
        self.project = project
        self.name = name
        self.id = id
    }
}
