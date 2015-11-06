//
//  DataManager.swift
//  SwiftTune
//
//  Created by Mike Henry on 11/3/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

import UIKit

class DataManager: NSObject {
    
    //MARK: - Properties

    static let sharedInstance = DataManager()
    
//    var baseURLString = "6f55349a.ngrok.io"
    var baseURLString = "boiling-ocean-2286.herokuapp.com"
    var aptArray = [Apt]()

    
    //MARK: - Get Data Methods
    
    func parseAptData(data: NSData) {
        do {
            let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
            let tempDictArray = jsonResult.objectForKey("repairs") as! [NSDictionary]
            self.aptArray.removeAll()
            for aptDict in tempDictArray {
                let newTicket = Apt()
//                newTicket.name = aptDict.objectForKey("name") as! String
                newTicket.created_at = aptDict.objectForKey("created_at") as! String
                newTicket.completed = aptDict.objectForKey("completed") as! Bool
                newTicket.first_name = aptDict.objectForKey("first_name") as! String
                newTicket.last_name = aptDict.objectForKey("last_name") as! String
                newTicket.aptnum = aptDict.objectForKey("aptnum") as! String
                
                self.aptArray.append(newTicket)
//                print("Repair:\(newTicket.name)")
            }
            dispatch_async(dispatch_get_main_queue()) { // set listener
                NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "receivedDataFromServer", object: nil))
            }
        } catch {
            print("JSON Parsing Error")
        }
    }
    
    func getDataFromServer() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        defer {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
        let url = NSURL(string: "http://\(baseURLString)/api/repairs/")
        let urlRequest = NSMutableURLRequest(URL: url!, cachePolicy: .ReloadIgnoringLocalCacheData, timeoutInterval: 30.0)
        
        urlRequest.HTTPMethod = "GET"
        let token = "TIY"
        urlRequest.addValue("bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let urlSession = NSURLSession.sharedSession()
        let task = urlSession.dataTaskWithRequest(urlRequest) { (data, response, error) -> Void in
            if data != nil {
                print("Got Data")
                self.parseAptData(data!)
//                print("Data\(data)")
            } else {
                print("No Data")
            }
        }
        task.resume()
    }
    
    func sendDataToServer() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        defer {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
        let url = NSURL(string: "http://\(baseURLString)/api/repairs/")
        let urlRequest = NSMutableURLRequest(URL: url!, cachePolicy: .ReloadIgnoringLocalCacheData, timeoutInterval: 30.0)
        
        urlRequest.HTTPMethod = "PUT"
        let token = "TIY"
        urlRequest.addValue("bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                let postString = "email=sample@email.com & phrase=blah blah blah"
                let postData = postString.dataUsingEncoding(NSUTF8StringEncoding)
                urlRequest.HTTPBody = postData
        
        let urlSession = NSURLSession.sharedSession()
        let task = urlSession.dataTaskWithRequest(urlRequest) { (data, response, error) -> Void in
            if data != nil {
                print("Got Data")
                self.parseAptData(data!)
//                print("Data\(data)")
            } else {
                print("No Data")
            }
        }
        task.resume()
    }
    
}
