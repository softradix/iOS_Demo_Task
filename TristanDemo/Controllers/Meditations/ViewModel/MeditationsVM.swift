import Foundation
import ObjectMapper

class MeditationsVM {
    
    //MARK:- Variables
    var aryMeditationList : [Meditations] = []
    
    //MARK:- Webservice
    func getMeditationList(callBack:((_ topicList:[Meditations],_ errMsg:String, _ errCode : Int)->Void)!) {
        APIManager.sendRequest(urlPath: Constant.APIConstantNames.urlPathGetMeditations, type: .get, parms: [:], success: { (response, success) in
            let model = Mapper<Meditations>().mapArray(JSONArray: response["meditations"] as! [[String : Any]])
            callBack(model,"",Constant.APIResponseCodes.statusCodeSuccessful.rawValue)
        }) { (errMsg, errCode) in
            callBack([],errMsg,errCode)
        }
    }
}

// ----------------------------------
//  MARK: - Table View Delegate DataSource(S)
//
extension MeditationsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return (arySubTopics?.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionTableCell") as! DescriptionTableCell
            cell.lblDescrptn.text = topicDetail?.description ?? ""
            return cell.contentView
        } else {
            var sectionHeaderVw: UIView?
            sectionHeaderVw = UIView(frame: CGRect(x: 20, y: 0, width: tableView.frame.size.width - 40, height: 60.0))
            let lblHeader = UILabel(frame: CGRect(x: sectionHeaderVw?.frame.origin.x ?? 0.0, y: (sectionHeaderVw?.frame.origin.y ?? 0.0), width: sectionHeaderVw?.frame.size.width ?? 0.0, height: sectionHeaderVw?.frame.size.height ?? 0.0))
            
            lblHeader.backgroundColor = UIColor.clear
            lblHeader.textColor = UIColor.black
            lblHeader.textAlignment = .left
            lblHeader.numberOfLines = 0
            lblHeader.contentMode = .bottom
            
            lblHeader.font = Constant.AppFontHelper.defaultSemiboldFontWithSize(size: 25)
            lblHeader.text = arySubTopics?[section - 1].title ?? ""
            sectionHeaderVw?.addSubview(lblHeader)
            sectionHeaderVw?.backgroundColor = UIColor.white
            return sectionHeaderVw
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        } else {
            return arySubTopics?[section - 1].detailedMeditations?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : MeditationTableCell = tableView.deque(MeditationTableCell.self, at: indexPath)
        cell.selectionStyle = .none
        cell.configureCell(itemDetail: arySubTopics?[indexPath.section - 1].detailedMeditations?[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return UITableView.automaticDimension
        } else {
            if arySubTopics?[section - 1].detailedMeditations?.count ?? 0 == 0 {
                return 0
            }
            return 60
        }
    }
}
