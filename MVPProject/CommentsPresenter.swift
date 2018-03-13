//
//  CommentsPresenter.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 30/01/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
struct CommentsViewData : ViewData {
    let post_id : String
    let comments : [[String: AnyObject]]
}

class CommentsPresenter  {
    let service  : GeneralDataService
    var commentsView : ViewBuild?
    init(service : GeneralDataService) {
        self.service = service
    }
    
    func atachView (commentsView : ViewBuild){
        self.commentsView = commentsView
    }
    func detachView() -> Void {
        commentsView = nil
    }
    func getComments (_ parameters : [String: AnyObject]) {
        self.commentsView?.startLoading()
        service.callAPIGetDataRequest(
            api : APISelected.Get_comments.rawValue,
            key: nil,
            model: CommentsModel(),
            parameters: parameters, onSuccess: {(card) in
                self.commentsView?.finishLoading()
                if card.count == 0 {
                    self.commentsView?.setEmptyData()
                }else {
                    print("cards",card as! [CommentsModel])
                    let mapInfo = (card as! [CommentsModel]).map{
                        infoMap -> CommentsViewData in
                         print("infoMap",infoMap.post_id)
                        return CommentsViewData(post_id: infoMap.post_id,
                                                comments: infoMap.comments)
                    }
                    print("MAP INFO",mapInfo.count)
                    self.commentsView?.setData(data: mapInfo)
                }
        }, onFailure:{ (errorMessage) in
            print("errorMessage",errorMessage)
            self.commentsView?.finishLoading()
        })
    }
}
