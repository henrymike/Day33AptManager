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
    
    var baseURLString = "itunes.apple.com"
    var aptArray = [Apt]()

    
    //MARK: - Get Data Methods

    func parseTuneData(data: NSData) {
        do {
            let jsonResult = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
            let tempDictArray = jsonResult.objectForKey("results") as! [NSDictionary]
            self.aptArray.removeAll()
            for aptDict in tempDictArray {
                let newTicket = Apt()
                newTicket.artistName = aptDict.objectForKey("artistName") as! String
                newTicket.trackName = aptDict.objectForKey("trackName") as! String
                newTicket.artworkUrl100 = aptDict.objectForKey("artworkUrl100") as! String
                newTicket.previewURL = aptDict.objectForKey("previewUrl") as! String
                if let uCollectionName = aptDict.objectForKey("collectionName") as? String {
                    newTicket.collectionName = uCollectionName
                }
                self.aptArray.append(newTicket)
//                print("Track Name:\(newTicket.trackName)")
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
        let url = NSURL(string: "http://\(baseURLString)/search?term=madonna")
        let urlRequest = NSURLRequest(URL: url!, cachePolicy: .ReloadIgnoringLocalCacheData, timeoutInterval: 30.0)
        let urlSession = NSURLSession.sharedSession()
        let task = urlSession.dataTaskWithRequest(urlRequest) { (data, response, error) -> Void in
            if data != nil {
                print("Got Data")
                self.parseTuneData(data!)
            } else {
                print("No Data")
            }
        }
        task.resume()
    }
    
    
}
