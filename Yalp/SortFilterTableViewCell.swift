//
//  SortFilterTableViewCell.swift
//  Yalp
//
//  Created by Bill Luoma on 10/20/16.
//  Copyright © 2016 BillLuoma. All rights reserved.
//

import UIKit

class SortFilterTableViewCell: UITableViewCell {

    @IBOutlet weak var sortLabel: UILabel!
    @IBOutlet weak var sortIconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
