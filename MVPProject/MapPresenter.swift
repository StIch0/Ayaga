//
//  MapPresenter.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 05/02/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
struct MapViewData : ViewData{
    let map : [String]
}
class MapPresenter {
    private var service = GeneralDataService()
    weak private var viewBuild : ViewBuild?
    init(service : GeneralDataService) {
        self.service = service
    }
    func atachView (viewBuild : ViewBuild){
        self.viewBuild = viewBuild
    }
    func detachView() -> Void {
        viewBuild = nil
    }
    func getComments (_ parameters : [String: AnyObject]) {
        self.viewBuild?.startLoading()
        service.callAPIGetDataRequest(
            api : APISelected.Get_map.rawValue,
            key: nil,
            model: MapModel(),
            parameters: parameters, onSuccess: {(card) in
                self.viewBuild?.finishLoading()
                if card.count == 0 {
                    self.viewBuild?.setEmptyData()
                }else {
                     let mapInfo = (card as! [MapModel]).map{
                        infoMap -> MapViewData in
                        return MapViewData(map: infoMap.map)
                    }
                     self.viewBuild?.setData(data: mapInfo)
                }
        }, onFailure:{ (errorMessage) in
            print("errorMessage",errorMessage)
            self.viewBuild?.finishLoading()
        })
    }

}
