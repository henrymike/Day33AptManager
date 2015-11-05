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
    
    @IBOutlet weak var ticketTableView  :UITableView!
    
    var currentRow = -1
    
    
    //MARK: - Table View Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(dataManager.aptArray.count)
        return dataManager.aptArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TicketTableViewCell
        let currentTicket = dataManager.aptArray[indexPath.row]
        cell.testLabel.text = "Now You See Me"
        cell.test2Label.text = "Now You Don't"
        
//        cell.textLabel!.text = "Test"
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if currentRow == indexPath.row {
            currentRow = -1
        } else {
            currentRow = indexPath.row
        }
        print(currentRow)
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == currentRow {
            return 150
        } else {
            return 70
        }
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

