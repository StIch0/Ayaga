//
//  ResultPresentr.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 24/01/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
import UIKit
struct ResulViewData:  ViewData{
    let id : AnyObject    
    let result : String
}

class ResultPresenter {
    private let service : ResultServise
    weak private var resultView: ViewBuild?
    init(service : ResultServise) {
        self.service = service
    }
    func atachView (resultView : ViewBuild){
        self.resultView = resultView
    }
    func detachView() -> Void {
        resultView = nil
    }
    func getData (_ url :String,
                  parameters: [String: AnyObject],
                  withName: String,
                  imagesArr : [UIImage],
                  videoArr : [String],
                  audioArr : [String],
                  docsArr : [String]){
        self.resultView?.startLoading()
        service.postAnyData(url, parameters: parameters, withName: withName, imagesArr: imagesArr, videoArr: videoArr, audioArr: audioArr, docsArr: docsArr, onSucces: {result in
            self.resultView?.finishLoading()
            if result.count == 0 {
                self.resultView?.setEmptyData()
            }
            else {
                let resMap = result.map {
                    rmap in
                    return ResulViewData(id : rmap.id ?? -1 as AnyObject, result : "\(rmap.status)")
                }
                self.resultView?.setData(data: resMap)
            }
        }, onFailure: {
            (errorMessage) in
            self.resultView?.finishLoading()
        })
        
    }
}
