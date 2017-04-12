//
//  CustomeTableViewCell.swift
//  PiggyAPI
//
//  Created by Arturo Esquivel on 3/29/17.
//  Copyright © 2017 Agustin Malo. All rights reserved.
//

import UIKit

class CustomeTableViewCell: UITableViewCell {

    
    @IBOutlet weak var profilePicCell: UIImageView!
    @IBOutlet weak var origin: UILabel!
    @IBOutlet weak var destination: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var spotAvailable: UILabel!
    @IBOutlet weak var user: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
