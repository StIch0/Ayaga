//
//  NewsService.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 10/01/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
class GeneralDataService {
    func callAPIGetDataRequest(
        api: String,
        key: String?,
        model: GeneralModel,
        parameters : [String : AnyObject]?,
        onSuccess successCallback: ((_ datas: [GeneralModel]) -> Void)?,
        onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APICallManager.instanse.callAPIGetDataRequest(api: api,
                                                      key: key,
                                                      model: model,
                                               parameters: parameters,
                                               onSucces: {(data) in
            successCallback?(data)},
                                               onFailure: {(errorMessage) in
            failureCallback?(errorMessage)
        })
    }
}
