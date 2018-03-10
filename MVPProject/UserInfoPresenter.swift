//
//  UserInfoPresenter.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 14/01/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
struct UserInfoViewData :ViewData {
    let name : String
    let surName : String
    let phone: String
    let city: String
    let sub_num: String
    let birth_date: String
}

class UserInfoPresenter {
    private let service : GeneralDataService
    weak private var userInfoView : ViewBuild?
    init(service :GeneralDataService) {
        self.service = service
    }
    func atachView (userInfoView : ViewBuild){
        self.userInfoView = userInfoView
    }
    func detachView() -> Void {
        userInfoView = nil
    }
    func getUserInfo (_ parameters : [String: AnyObject]) {
        self.userInfoView?.startLoading()
        service.callAPIGetDataRequest(
            api: APISelected.User_info.rawValue,
            key: nil,
            model: UserInfoModel(),
            parameters : parameters,
            onSuccess: {(info) in
            self.userInfoView?.finishLoading()
              if info.count == 0 {
            self.userInfoView?.setEmptyData()
            }else {
                  let mapInfo = (info as! [UserInfoModel]).map{
                infoMap -> UserInfoViewData in
                  return  UserInfoViewData(
                        name: "\(infoMap.name)",
                        surName: "\(infoMap.surName)",
                        phone: "\(infoMap.phone)",
                        city: "\(infoMap.city)",
                        sub_num: "\(infoMap.sub_num)",
                        birth_date: "\(infoMap.birth_date)")
                }
                self.userInfoView?.setData(data: mapInfo)
            }
        }, onFailure:{ (errorMessage) in
            print("errorMessage",errorMessage)
            self.userInfoView?.finishLoading()})
    }
    
    
}
