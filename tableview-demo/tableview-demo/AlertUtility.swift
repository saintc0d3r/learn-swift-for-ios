//
//  AlertUtility.swift
//  tableview-demo
//
//  Created by Wendy Sanarwanto on 2/21/16.
//  Copyright © 2016 saintc0d3r. All rights reserved.
//

import UIKit

class AlertUtility {
    static func showError(errorMessage: String, title: String, viewController: UIViewController){
        let alert_ctl = UIAlertController(title: title, message: errorMessage, preferredStyle: .Alert)
        alert_ctl.addAction(UIAlertAction(title: "Close", style: .Default, handler: nil))
        viewController.presentViewController(alert_ctl, animated: true, completion: nil)
    }
    
}