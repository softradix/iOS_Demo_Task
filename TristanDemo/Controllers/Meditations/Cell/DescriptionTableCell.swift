//
//  DescriptionTableCell.swift
//  TristanDemo
//
//  Created by anand singh on 07/03/21.
//

import UIKit

class DescriptionTableCell: UITableViewCell {
    @IBOutlet weak var lblDescrptn: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
