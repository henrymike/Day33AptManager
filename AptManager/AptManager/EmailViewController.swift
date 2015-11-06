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
    
    
    //MARK: - Interactivity Methods
    
    @IBAction func sendButtonPressed(sender: UIButton) {
        print("subject=\(subjectTextField.text!) & body=\(messageTextView.text)")
    }
    //controllers/mailers/user_mailer <-sender
    
    //MARK: - Life Cycle Methods
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

}
