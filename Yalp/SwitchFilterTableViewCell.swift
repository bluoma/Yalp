//
//  SwitchFilterTableViewCell.swift
//  Yalp
//
//  Created by Bill Luoma on 10/20/16.
//  Copyright © 2016 BillLuoma. All rights reserved.
//

import UIKit

@objc protocol SwitchCellChangedDelegate {
    func switchCell(switchCell: SwitchFilterTableViewCell, didChangeValue value: Bool) -> Void
}

class SwitchFilterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sortSwitchLabel: UILabel!
    @IBOutlet weak var sortSwitch: UISwitch!
    
    weak var changedDelegate: SwitchCellChangedDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func switchValueChanged(_ sender: AnyObject) {
        changedDelegate?.switchCell(switchCell: self , didChangeValue: sortSwitch.isOn)
    }
}
