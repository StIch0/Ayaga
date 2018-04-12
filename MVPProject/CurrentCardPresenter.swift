//
//  CurrenrCardPresenter.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 29/01/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
struct CurrentCardViewData : ViewData{
    let id : Int
    let title : String
    let textCard : String
    let images : [String]
}

class CurrentCardPresenter {
    let service  : GeneralDataService
    weak private var cardsView : ViewBuild?
    init(service : GeneralDataService) {
        self.service = service
    }
    
    func atachView (cardsView : ViewBuild){
        self.cardsView = cardsView
    }
    func detachView() -> Void {
        cardsView = nil
    }
    func getCards (_ parameters : [String: AnyObject]) {
        self.cardsView?.startLoading()
        service.callAPIGetDataRequest(
            api: APISelected.Get_card.rawValue,
            key: "cards",
            model: CurrentCardModel(),
            parameters: parameters, 
            onSuccess: {(card) in
                 self.cardsView?.finishLoading()
                if card.count == 0 {
                     self.cardsView?.setEmptyData()
                }else {
                    
                    let mapInfo = (card as! [CurrentCardModel]).map{
                        infoMap -> CurrentCardViewData in
                         print("infoMap.textCard",infoMap.textCard)
                        return CurrentCardViewData(id: infoMap.id,
                                                   title: infoMap.title,
                                                   textCard: infoMap.textCard,
                                                   images: infoMap.images)
                    }
                    self.cardsView?.setData(data: mapInfo)
                }
        }, onFailure:{ (errorMessage) in
            print("errorMessage",errorMessage)
            self.cardsView?.finishLoading()})
    }
    

}
