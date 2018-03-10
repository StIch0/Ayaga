//
//  MessagesPresenter.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 25/01/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
struct MessagesViewData : ViewData{
    let user_id : String
    let count : Int
    let user_login : String
    let user_photo : String
    let user_messages : [[String:AnyObject]]
 }
class MessagesPresenter {
    private let service : GeneralDataService
    weak private var messagesView : ViewBuild?
    init(service :GeneralDataService) {
        self.service = service
    }
    func atachView (messagesView : ViewBuild){
        self.messagesView = messagesView
    }
    func detachView() -> Void {
        messagesView = nil
    }
 
    
    func getMessages (_ parameters : [String: AnyObject]) {
        self.messagesView?.startLoading()
        service.callAPIGetDataRequest(
            api: APISelected.Messages.rawValue,
            key: "messages",
            model: MessagesModel(),
            parameters: parameters,
            onSuccess: {(mess) in
                self.messagesView?.finishLoading()
                if mess.count == 0 {
                    self.messagesView?.setEmptyData()
                }else {
                    
                    let mapInfo = (mess as! [MessagesModel]).map{
                        infoMap -> MessagesViewData in
                        // print(infoMap.user_messages.first?.text)
                        return  MessagesViewData(user_id: infoMap.user_id,
                                                 count: infoMap.count,
                                                 user_login: infoMap.user_login,
                                                 user_photo: infoMap.user_photo,
                                                 user_messages: infoMap.user_messages)
                    }
                    self.messagesView?.setData(data: mapInfo)
                }
        }, onFailure:{ (errorMessage) in
            print("errorMessage",errorMessage)
            self.messagesView?.finishLoading()})
    }

}
