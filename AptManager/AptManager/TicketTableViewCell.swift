//
//  TicketTableViewCell.swift
//  AptManager
//
//  Created by Mike Henry on 11/5/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//

import UIKit

class TicketTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    
    @IBOutlet weak var testLabel        :UILabel!
    @IBOutlet weak var test2Label       :UILabel!

    

    //MARK: - Life Cycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
}

}
