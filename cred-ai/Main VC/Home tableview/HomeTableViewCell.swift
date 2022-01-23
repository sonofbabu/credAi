//
//  HomeTableViewCell.swift
//  cred-ai
//
//  Created by leyo babu on 23/01/22.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    
    @IBOutlet weak var depositDetails: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
