//
//  TopicsVC.swift
//  TristanDemo
//
//  Created by anand singh on 06/03/21.
//

import UIKit

class MeditationsVC: UIViewController {
    // ----------------------------------
    // MARK: - IB-OUTLET(S)
    //
    @IBOutlet fileprivate weak var tblVwForMeditations: UITableView!
    
    var viewObj = MeditationsVM()
    var topicDetail : Topics?
    var arySubTopics : [Topics]?
    // ----------------------------------
    // MARK: - VIEW LOADING
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerTableCells()
        self.getMeditationsList()
        self.navigationItem.title = topicDetail?.title
        tblVwForMeditations.estimatedSectionHeaderHeight = 60
        tblVwForMeditations.sectionHeaderHeight = UITableView.automaticDimension
    }
    
    // ----------------------------------
    // MARK: - PRIVATE METHOD(S)
    //
    private func registerTableCells() {
        self.tblVwForMeditations.register(MeditationTableCell.self)
        self.tblVwForMeditations.register(DescriptionTableCell.self)
    }
    
    private func getMeditationsList() {
        self.view.showLoadingIndicator()
        viewObj.getMeditationList { [weak self](response, errMsg, errCode) in
            guard let strongSelf = self else { return }
            strongSelf.view.hideLoadingIndicator()
            if errCode == Constant.APIResponseCodes.statusCodeSuccessful.rawValue {
                strongSelf.viewObj.aryMeditationList.removeAll()
                for (index, item) in (strongSelf.arySubTopics ?? [Topics]()).enumerated() {
                    var meditations = [Meditations]()
                    for meditationID in item.meditations ?? [String]() {
                        if let meditation = response.filter({$0.uuid == meditationID}).first {
                            meditations.append(meditation)
                        }
                    }
                    
                    meditations = meditations.sorted(by: { $0.play_count ?? 0 > $1.play_count ?? 0 })
                    
                    item.detailedMeditations = meditations
                    strongSelf.arySubTopics?[index] = item
                }

                strongSelf.tblVwForMeditations.reloadData()
            }  else {
                strongSelf.showAlert(title: Constant.ValidationMessages.oopsTitle, msg: errMsg) {
                }
            }
        }
    }
}
