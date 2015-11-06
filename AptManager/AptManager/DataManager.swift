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
    var ticketsArray = [Tickets]()

    
    //MARK: - Get Data Methods
    
    func parseTicketsData(data: NSData) {
        do {
            let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
            let tempDictArray = jsonResult.objectForKey("repairs") as! [NSDictionary]
            self.ticketsArray.removeAll()
            for ticketsDict in tempDictArray {
                let newTicket = Tickets()
                newTicket.name = ticketsDict.objectForKey("name") as! String
                newTicket.id = ticketsDict.objectForKey("id") as! Int
                newTicket.repair_description = ticketsDict.objectForKey("repair_description") as! String
                newTicket.created_at = ticketsDict.objectForKey("created_at") as! String
                newTicket.completed = ticketsDict.objectForKey("completed") as! Bool
                newTicket.first_name = ticketsDict.objectForKey("first_name") as! String
                newTicket.last_name = ticketsDict.objectForKey("last_name") as! String
                newTicket.aptnum = ticketsDict.objectForKey("aptnum") as! String
                
                self.ticketsArray.append(newTicket)
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
                self.parseTicketsData(data!)
//                print("Data\(data)")
            } else {
                print("No Data")
            }
        }
        task.resume()
    }
    
    func sendDataToServer(repairID: Int, repairCompleted: String) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        defer {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        }
        let url = NSURL(string: "http://\(baseURLString)/api/repairs/\(repairID)")
        let urlRequest = NSMutableURLRequest(URL: url!, cachePolicy: .ReloadIgnoringLocalCacheData, timeoutInterval: 30.0)
        
        urlRequest.HTTPMethod = "PATCH"
        let token = "TIY"
        urlRequest.addValue("bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
//                let postString = "email=sample@email.com & phrase=blah blah blah"
        let postString = repairCompleted
        let postData = postString.dataUsingEncoding(NSUTF8StringEncoding)
        urlRequest.HTTPBody = postData
        
        let urlSession = NSURLSession.sharedSession()
        let task = urlSession.dataTaskWithRequest(urlRequest) { (data, response, error) -> Void in
            if data != nil {
                print("Data Sent Success")
            } else {
                print("Data Sent Failed")
            }
        }
        task.resume()
    }
    //api/repairs/
}
