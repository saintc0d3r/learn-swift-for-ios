//
//  ViewController.swift
//  tableview-demo
//
//  Created by Wendy Sanarwanto on 2/20/16.
//  Copyright © 2016 saintc0d3r. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var flatten_projects = [FlattenProject]();
    var project_service: ProjectService?;
    
    @IBOutlet weak var table_view: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadProjects()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadProjects() {
        var block_this = true;
        project_service = ProjectsResource(api_url: backend_api_url)
        
        project_service?.GetProjects({json, error -> Void in
            if (error != nil){
                var error_message = error?.localizedDescription
                if (error_message == nil){
                    error_message = json["error"]["message"].string
                }
                
                AlertUtility.showError(error_message!, title: "Pulling Projects is Failed", viewController: self)
            }
            
            // Loop Projects list
            for (var p=0; p < json.count; p++){
                let projectJson = json[p]
                var flatten_project: FlattenProject?;

                let project_name = projectJson["project"].stringValue
                let project_id = projectJson["id"].intValue
                let project = Project(id: project_id, name: project_name )
                
                if (projectJson["level"].count == 0){
                    flatten_project = FlattenProject(project: project, level: nil, zone: nil)
                    self.flatten_projects.append(flatten_project!)
                    break;
                }
                
                for (var l=0; l < projectJson["level"].count; l++) {
                    let levelJson = projectJson["level"][l]
                    let level = Level(project: project, id: levelJson["level"].intValue, name: "Level "+levelJson["level"].stringValue)
                    
                    if (levelJson["zone"].count == 0){
                        flatten_project = FlattenProject(project: project, level: level, zone: nil)
                        self.flatten_projects.append(flatten_project!)
                        break;
                    }
                    
                    for (var z = 0; z < levelJson["zone"].count; z++){
                        let zoneJson = levelJson["zone"][z]
                        let zone = Zone(level: level, id: zoneJson["id"].intValue, name: zoneJson["zone"].stringValue)
                        
                        
                        flatten_project = FlattenProject(project: project, level: level, zone: zone)
                        self.flatten_projects.append(flatten_project!)
                    }
                }
            }
            
            block_this = false
        })
        
        while(block_this){}
        
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let flatten_project = flatten_projects[indexPath.section]
        
        let projectCell = table_view.dequeueReusableCellWithIdentifier("ProjectCustomCell", forIndexPath: indexPath) as? ProjectTableViewCell
            
        projectCell!.projectLabel.text = flatten_project.project.name
        projectCell!.levelLabel.text = flatten_project.level?.name
        projectCell!.zoneLabel.text = flatten_project.zone?.name
        
        return projectCell! as UITableViewCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return flatten_projects.count
    }
}

