//
//  FlattenProject.swift
//  tableview-demo
//
//  Created by Wendy Sanarwanto on 2/20/16.
//  Copyright © 2016 saintc0d3r. All rights reserved.
//

import Foundation

class FlattenProject {
    var project: Project
    var level: Level?
    var zone: Zone?
    
    init(project: Project, level: Level?, zone: Zone?){
        self.project = project
        self.level = level
        self.zone = zone
    }
}
