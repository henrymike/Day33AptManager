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
    
    @IBOutlet weak var repairLabel          :UILabel!
    @IBOutlet weak var dateLabel            :UILabel!
    @IBOutlet weak var aptNumLabel          :UILabel!
    @IBOutlet weak var completedSwitch      :UISwitch!
    @IBOutlet weak var descriptionTextView  :UITextView!

    
    //MARK: - Life Cycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
}

}
