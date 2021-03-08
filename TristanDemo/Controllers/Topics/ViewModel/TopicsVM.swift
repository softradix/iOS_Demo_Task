//
//  MeditationVM.swift
//  TristanDemo
//
//  Created by anand singh on 06/03/21.
//

import Foundation
import ObjectMapper

class TopicsVM {
    
    //MARK:- Variables
    var aryTopicsList : [Topics] = []
    var aryFilterdTopicsList : [Topics] = []
    
    //MARK:- Webservice
     func getTopicsList(callBack:((_ topicList:[Topics],_ errMsg:String, _ errCode : Int)->Void)!) {
        APIManager.sendRequest(urlPath: Constant.APIConstantNames.urlPathGetTopics, type: .get, parms: [:], success: { (response, success) in
            let model = Mapper<Topics>().mapArray(JSONArray: response["topics"] as! [[String : Any]])
            callBack(model,"",Constant.APIResponseCodes.statusCodeSuccessful.rawValue)
        }) { (errMsg, errCode) in
            callBack([],errMsg,errCode)
        }
    }
}

// ----------------------------------
//  MARK: - Table View Delegate DataSource(S)
//
extension TopicsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewObj.aryFilterdTopicsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : TopicsTableCell = tableView.deque(TopicsTableCell.self, at: indexPath)
        cell.vwBg.addRoundedViewCorners(width: 8, colorBorder: UIColor.lightGray)
        cell.vwTopicColor.roundCorners(corners: [.topLeft,.bottomLeft], radius: 8)

        let model = viewObj.aryFilterdTopicsList[indexPath.row]
        cell.lblTitle.text = model.title ?? ""
        cell.lblTopicName.text = "\("Meditations")\(" ")\(model.meditations?.count ?? 0)"
        cell.vwTopicColor.backgroundColor = UIColor.withHex(hex: model.color ?? "#000000", alpha: 1.0)
        cell.vwBg.backgroundColor = UIColor.white
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedTopic = viewObj.aryFilterdTopicsList[indexPath.row]
        let arySubTopics = self.viewObj.aryTopicsList.filter { (topic) -> Bool in
            return (topic.parent_uuid == selectedTopic.uuid)
        }
        
        let objMeditations: MeditationsVC = self.storyboard!.instantiateViewController()
        objMeditations.arySubTopics = arySubTopics
        objMeditations.topicDetail = viewObj.aryFilterdTopicsList[indexPath.row]
        self.navigationController?.pushViewController(objMeditations, animated: true)
    }
}
