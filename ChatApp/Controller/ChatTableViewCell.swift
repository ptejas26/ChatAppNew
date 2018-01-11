//
//  ChatTableViewCell.swift
//  ChatApp
//
//  Created by Nilesh's MAC on 1/11/18.
//  Copyright © 2018 Nilesh's MAC. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    @IBOutlet var lblsenderMessage : UILabel!
    @IBOutlet var lblreceiverMessage : UILabel!
    @IBOutlet var lblDate : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
