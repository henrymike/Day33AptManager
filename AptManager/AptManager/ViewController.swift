//
//  ViewController.swift
//  AptManager
//
//  Created by Mike Henry on 11/5/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    //MARK: - Properties
    
    var networkManager = NetworkManager.sharedInstance
    var dataManager = DataManager.sharedInstance
    
    @IBOutlet weak var ticketTableView :UITableView!
    
    
    //MARK: - Table View Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(dataManager.aptArray.count)
        return dataManager.aptArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("collapsedCell", forIndexPath: indexPath)
        cell.textLabel!.text = "Test"
        
        return cell
    }

    func newDataReceived() {
        print("New Data Received")
        ticketTableView.reloadData()
    }
    
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataManager.getDataFromServer()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "newDataReceived", name: "receivedDataFromServer", object: nil) // listens for fetch

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

