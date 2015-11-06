//
//  EmailViewController.swift
//  AptManager
//
//  Created by Mike Henry on 11/6/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

import UIKit

class EmailViewController: UIViewController {

    //MARK: - Properties
    @IBOutlet weak var subjectTextField :UITextField!
    @IBOutlet weak var messageTextView  :UITextView!
    @IBOutlet weak var sendButton       :UIButton!
    
    var dataManager = DataManager.sharedInstance
    
    
    //MARK: - Interactivity Methods
    
    @IBAction func sendButtonPressed(sender: UIButton) {
        print("subject=\(subjectTextField.text!) & body=\(messageTextView.text)")
        let messageString = "subject=\(subjectTextField.text!) & body=\(messageTextView.text)"
        dataManager.sendEmaiToServer(messageString)
    }

    
    //MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

}
