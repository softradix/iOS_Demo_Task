//
//  TopicsTableCell.swift
//  TristanDemo
//
//  Created by anand singh on 06/03/21.
//

import UIKit

class TopicsTableCell: UITableViewCell {
    // ----------------------------------
    //  MARK: - IB-OUTLET(S)
    //
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var vwTopicColor: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTopicName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
