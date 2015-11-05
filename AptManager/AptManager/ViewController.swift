//
//  ViewController.swift
//  AptManager
//
//  Created by Mike Henry on 11/5/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    //MARK: - Properties
    
    var networkManager = NetworkManager.sharedInstance // this points back to our NetworkManager file and it can be instantiated here; no need to put in viewDidLoad
    var dataManager = DataManager.sharedInstance

    
    
    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

