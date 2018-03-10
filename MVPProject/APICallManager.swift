//
//  APICallManager.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 10/01/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
import Alamofire
import  SwiftyJSON
class APICallManager {
    static let instanse = APICallManager()
    let API_BASE_URL = "http://9834436605.myjino.ru"
    enum RequestMethod {
        case get
        case post
    }
    func callAPIGetDataRequest(
        api: String,
        key: String?,
        model : GeneralModel,
        parameters: [String: AnyObject]?,
        onSucces successCallback: ((_ generalModel: [GeneralModel])->Void)?,
        onFailure failureCallback: ((_ errorMessage : String)->Void)?) {
        let url = API_BASE_URL + api
        CreateRequestManager.shared.createRequest(url, method: .post, headers: nil, parameters: parameters , onSuccess: {
            (responseJSON : JSON)->Void in
            print(responseJSON)
            if let keyDict = key {
                if let responseDict = responseJSON[keyDict].arrayObject {
                    let dataDict = responseDict as! [[String : AnyObject]]
                    var dataModel = Array<GeneralModel>()
                    for item in dataDict {
                        let data = model.build(item)
                        dataModel.append(data)
                    }
                    successCallback?(dataModel)
                } else {
                    let error = NSError()
                    failureCallback?("An error has occured/n.\(error.localizedDescription)")
                }
            } else {
                if let responseDict = responseJSON.dictionaryObject {
                    let dataDict = responseDict as [String : AnyObject]
                    var dataModel = Array<GeneralModel>()
                    let data = model.build(dataDict)
                    dataModel.append(data)
 
                    successCallback?(dataModel)
                } else {
                    failureCallback?("An error has occured.")
                }
            }
        }, onFailure: {(errorMessage: String)->Void in
            failureCallback?(errorMessage)
        })
     }
    func postAnyData(_ url :String,
                     parameters: [String: AnyObject],
                     withName: String,
                     imagesArr : [UIImage],
                     videoArr : [String],
                     audioArr : [String],
                     docsArr : [String],
                     onSucces successCallback :((_ result: [ResultModel])->Void)?,
                     onFailure failureCallback: ((_ errorMessage: String) -> Void)?){
                    let url = API_BASE_URL + url
        let headers = [
        "Authorization": "YWNjXzJhOGNjYzgzYTc3NTRjMTo2NmQyMTIxOTdmZjNhYzVlYTc1NmEwYzEwNjljNjQ1NQ=="
        ]
        CreateRequestManager.shared.createUploadRequest(url, method: .post,
                                                        headers: headers,
                                                        parameters: parameters,
                                                        withName: withName,
                                                        imagesArr: imagesArr,
                                                        videoArr: videoArr,
                                                        audioArr: audioArr,
                                                        docsArr: docsArr,
                                                        onSucces: {
                   (responseJSON : JSON)->Void in
                   print("responseJSON",responseJSON.dictionary!)
                   
                   if let responseDict = responseJSON.dictionaryObject {
                       let resultDict = responseDict as [String : AnyObject]
                       var resultModel = [ResultModel]()
                       
                       let res = ResultModel.build(resultDict)
                       resultModel.append(res)
                       successCallback?(resultModel)
                   }
                   else {
                       failureCallback?("An error has occured.")
                   }
        }, onFailure: {(errorMessage: String)->Void in
            failureCallback?(errorMessage)
        })
    }
}
