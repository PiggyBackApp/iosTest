//
//  RequestsTableViewCell.swift
//  PiggyAPI
//
//  Created by Agustin Malo on 4/17/17.
//  Copyright © 2017 Agustin Malo. All rights reserved.
//

import UIKit

class RequestsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var tripLocations: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
