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
    
    
    //MARK: - Interactivity Methods
    
    @IBAction func completedSwitchChanged(sender: UISwitch) {
        let point = sender.convertPoint(CGPointZero, toView: ticketTableView)
        let indexPath = ticketTableView.indexPathForRowAtPoint(point)
        
        let currentTicket = dataManager.ticketsArray[indexPath!.row]
        let repairID = String(currentTicket.id)
        let repairCompleted = "completed=\(sender.on)"
        print("RepairID: \(repairID) & Completed:\(repairCompleted)")
        dataManager.sendDataToServer(repairID, repairCompleted: repairCompleted)
        //TODO: Disable the Completed switch so that it can never be reset to False
    }
    
    
    //MARK: - Table View Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.ticketsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! TicketTableViewCell
        let currentTicket = dataManager.ticketsArray[indexPath.row]
        cell.repairLabel.text = currentTicket.name
        cell.aptNumLabel.text = "Apt#: \(currentTicket.aptnum)"
        cell.userNameLabel.text = "\(currentTicket.first_name) \(currentTicket.last_name)"
        cell.completedSwitch.on = currentTicket.completed
        cell.descriptionTextView.text = currentTicket.repair_description
        
        let dateFormatter = NSDateFormatter()
//        print("Sent:\(currentTicket.created_at)")
//        dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT-5")
        dateFormatter.timeZone = NSTimeZone.systemTimeZone()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:s.SZZZZ"
        cell.dateLabel.text = String(dateFormatter.dateFromString(currentTicket.created_at)!)
//        print("Conv:\(cell.dateLabel.text!)")

        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if currentRow == indexPath.row {
            currentRow = -1
        } else {
            currentRow = indexPath.row
        }
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == currentRow {
            return 150
        } else {
            return 55
        }
    }
    
    func newDataReceived() {
        print("New Data Received")
        ticketTableView.reloadData()
    }
    
    @IBAction func getNewData(sender: UIBarButtonItem) {
        dataManager.getDataFromServer()
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

