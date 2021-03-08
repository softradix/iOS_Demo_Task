//
//  MeditationTableCell.swift
//  TristanDemo
//
//  Created by anand singh on 07/03/21.
//

import UIKit

class MeditationTableCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblTeacherName: UILabel!
    @IBOutlet weak var imgVw: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(itemDetail : Meditations?) {
        let model = itemDetail
        lblTitle.text = model?.title ?? ""
        lblTeacherName.text = model?.teacher_name ?? ""
        imgVw.loadImageFromUrl(strUrl: model?.image_url ?? "", imgPlaceHolder: "imgPlaceholder")
        imgVw.setRadius(radius: 8)
    }
}
