//
//  TopicsVC.swift
//  TristanDemo
//
//  Created by anand singh on 06/03/21.
//

import UIKit

class TopicsVC: UIViewController {
    // ----------------------------------
    // MARK: - IB-OUTLET(S)
    //
    @IBOutlet fileprivate weak var tblVwForTopics: UITableView!
    
    var viewObj = TopicsVM()
    
    // ----------------------------------
    // MARK: - VIEW LOADING
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerTableCells()
        self.getTopicsList()
        self.navigationItem.title = "Topics"
    }
    
    // ----------------------------------
    // MARK: - PRIVATE METHOD(S)
    //
    private func registerTableCells() {
        self.tblVwForTopics.register(TopicsTableCell.self)
    }
    
    private func getTopicsList() {
        self.view.showLoadingIndicator()
        viewObj.getTopicsList { [weak self](response, errMsg, errCode) in
            guard let strongSelf = self else { return }
            strongSelf.view.hideLoadingIndicator()
            if errCode == Constant.APIResponseCodes.statusCodeSuccessful.rawValue {
                strongSelf.viewObj.aryTopicsList = response
                let aryParentLevel = strongSelf.viewObj.aryTopicsList.filter { (topic) -> Bool in
                    return (topic.parent_uuid == nil && topic.featured == true)
                }
                if aryParentLevel.count > 0 {
                    strongSelf.viewObj.aryFilterdTopicsList = aryParentLevel
                    strongSelf.viewObj.aryFilterdTopicsList = strongSelf.viewObj.aryFilterdTopicsList.sorted(by: { $0.position! > $1.position! })
                }
                strongSelf.tblVwForTopics.reloadData()
            } else {
                strongSelf.showAlert(title: Constant.ValidationMessages.oopsTitle, msg: errMsg) {
                }
            }
        }
    }
}
