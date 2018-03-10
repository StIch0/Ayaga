//
//  CardsPresenter.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 29/01/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
struct CardsViewData : ViewData {
    let id: Int
    let title : String
    let childrens : Int
}
class CardsPresenter {
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
            api: APISelected.Get_card_categories.rawValue,
            key: "categories",
            model: CardsModel(),
            parameters: parameters,
            onSuccess: {(card) in
                self.cardsView?.finishLoading()
                if card.count == 0 {
                    self.cardsView?.setEmptyData()
                }else {
                    
                    let mapInfo = (card as! [CardsModel]).map{
                        infoMap -> CardsViewData in
                        // print(infoMap.user_messages.first?.text)
                        return CardsViewData(id: infoMap.id,
                                             title: infoMap.title,
                                             childrens: infoMap.childrens)
                    }
                    self.cardsView?.setData(data: mapInfo)
                }
        }, onFailure:{ (errorMessage) in
            print("errorMessage",errorMessage)
            self.cardsView?.finishLoading()})
    }

}
