//
//  BusinessTableViewCell.swift
//  Yalp
//
//  Created by Bill on 10/13/16.
//  Copyright © 2016 BillLuoma. All rights reserved.
//

import UIKit

class BusinessTableViewCell: UITableViewCell {
    
    @IBOutlet weak var businessImageView: UIImageView!
    @IBOutlet weak var businessNameLabel: UILabel!
    @IBOutlet weak var reivewsLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var dollarLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}