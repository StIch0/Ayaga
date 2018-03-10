//
//  Servise.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 15/01/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
import UIKit
//Result service on status data
class ResultServise {
    
    func postAnyData(_ url :String,
                     parameters: [String: AnyObject],
                     withName: String,
                     imagesArr : [UIImage],
                     videoArr : [String],
                     audioArr : [String],
                     docsArr : [String],
                     onSucces successCallback :((_ result: [ResultModel])->Void)?,
                     onFailure failureCallback: ((_ errorMessage: String) -> Void)?){
        APICallManager.instanse.postAnyData(url, parameters: parameters, withName: withName, imagesArr: imagesArr, videoArr: videoArr, audioArr: audioArr, docsArr: docsArr, onSucces:{
            res in
            successCallback?(res)
        }, onFailure:{
        error in
            failureCallback?(error)
        })
    }

}
