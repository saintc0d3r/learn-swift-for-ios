//
//  ProjectsService.swift
//  tableview-demo
//
//  Created by Wendy Sanarwanto on 2/21/16.
//  Copyright © 2016 saintc0d3r. All rights reserved.
//

import Foundation

protocol ProjectService {
    func GetProjects(callback: (JSON, NSError?)->Void);
}

class ProjectsResource : RestServiceBase, ProjectService {
    let GET_PROJECTS_ENDPOINT_PATH = "/projects"
    
    func GetProjects(callback: (JSON, NSError?)->Void){
        super.call_rest_api( GET_PROJECTS_ENDPOINT_PATH, http_method: "GET", params: nil, auth_token: nil, on_completion: {json, error -> Void in
            
            callback(json, error);
        })
    }
}