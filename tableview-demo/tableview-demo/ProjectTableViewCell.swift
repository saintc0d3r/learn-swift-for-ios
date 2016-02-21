//
//  ProjectTableViewCell.swift
//  tableview-demo
//
//  Created by Wendy Sanarwanto on 2/20/16.
//  Copyright © 2016 saintc0d3r. All rights reserved.
//

import UIKit

class ProjectTableViewCell : UITableViewCell{
    
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var projectLabel: UILabel!
    @IBOutlet weak var zoneLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
