//
//  RestServiceBase.swift
//  tableview-demo
//
//  Created by Wendy Sanarwanto on 2/21/16.
//  Copyright © 2016 saintc0d3r. All rights reserved.
//

import Foundation

class RestServiceBase : NSObject {
    private(set) var api_url: String = ""
    
    convenience init(api_url: String){
        self.init()
        
        self.api_url = api_url
    }
    
    /**
     * A helper for invoking REST endpoint
     **/
    func call_rest_api(resource_url :String, http_method: String, var params: Dictionary<String, String>?,
        auth_token: String?, on_completion: (JSON, NSError?) -> Void){
            
            let full_api_url = api_url + resource_url
            
            // 1. prepare request object ( through using NSMutableURLRequest class)
            let url = NSURLComponents(string: full_api_url)
            // 1.0. push several parameter type as request's query parameter when the HTTP Method is GET
            if (http_method == "GET"){
                // Push auth token
                if ( (auth_token != nil) && (!auth_token!.isEmpty) ) {
                    let access_token_query = NSURLQueryItem(name: "access_token", value: auth_token)
                    url?.queryItems?.append(access_token_query)
                }
                
                // Push skip param
                if (params != nil){
                    if (params?["skip"] != nil && params?["skip"] != ""){
                        let skip_query = NSURLQueryItem(name: "skip", value: params?["skip"])
                        url?.queryItems?.append(skip_query)
                    }
                
                    // Push limit param
                    if (params?["limit"] != nil && params?["limit"] != ""){
                        let limit_query = NSURLQueryItem(name: "limit", value: params?["limit"])
                        url?.queryItems?.append(limit_query)
                    }
                }
            }
            
            let request = NSMutableURLRequest(URL: (url?.URL)!)
            
            // 1.1. Define the Request's HTTP Method: POST, GET, PUT, or DELETE
            request.HTTPMethod = http_method
            
            // 1.2. Serialise the params dictionary as JSON data and assign the JSON into Request's body payload
            if ( (params != nil) && (params!.count > 0)){
                request.HTTPBody = try! NSJSONSerialization.dataWithJSONObject(params!, options: .PrettyPrinted)
            }
            
            // 1.3. Set the request's header content-type as application/json
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            // 1.4. Set authorization header with auth token, if it is available
            if ( (auth_token != nil) && (!auth_token!.isEmpty) ) {
                // If the method does not equal to 'GET', then the access token is pushed as request header
                //            if (http_method != "GET") {
                request.addValue(auth_token!, forHTTPHeaderField: "authorization")
                //            }
            }
            
            // 2. Get NSURLSession's instance and call its dataTaskWithRequest method to call the REST API
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(request, completionHandler: { data, response, error -> Void in
                // 3.  convert the data result as JSON through swifty json
                let json :JSON = data != nil ? JSON(data: data!) : nil
                
                // 4. Pass the json into the callback and invoke it
                on_completion(json, error)
            })
            task.resume()
    }    
    
}
