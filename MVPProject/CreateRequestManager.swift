//
//  CreateRequestManager.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 14/01/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
class CreateRequestManager {
     static let shared = CreateRequestManager()
    func createRequest(
        _ url : String,
        method: HTTPMethod,
        headers : [String: String]?,
        parameters:  [String: AnyObject]?,
        onSuccess successCallback: ((JSON) -> Void)?,
        onFailure failureCallback: ((String) -> Void)?){
         request(url, method: method, parameters: parameters).validate().responseJSON{
            responseJSON in
            switch responseJSON.result {
            case .success(let value):
                let json = JSON(value)
                successCallback?(json)
            case .failure(let error):
                if let callback = failureCallback {
                    // Return
                    callback(error.localizedDescription)
                }
            }
        }
     }
    func createUploadRequest(_ url :String,
                             method: HTTPMethod,
                             headers: [String: String],
                             parameters: [String: AnyObject],
                             withName: String,
                             imagesArr : [UIImage],
                             videoArr : [String],
                             audioArr : [String],
                             docsArr : [String],
                             onSucces successCallback :((JSON)->Void)?,
                             onFailure failureCallback: ((String) -> Void)?){
        Alamofire.upload(multipartFormData: {(multipartFormData) in
            
            for i in 0..<imagesArr.count{
                if  let dat = UIImageJPEGRepresentation((imagesArr[i]), 0.6){
                    multipartFormData.append(dat, withName: withName,  fileName:  "image"+String(format:"%d",i)+".jpg", mimeType: "image/jpeg")
                }
            }
            for i in 0..<videoArr.count{
                if let url = URL(string: videoArr[i]) {
                    multipartFormData.append(url, withName: "video[]", fileName: "video"+String(format: "%d",i) + "TODO" , mimeType: "TODO")
                }
            }
            for i in 0..<audioArr.count{
                if let url = URL(string: audioArr[i]) {
                    multipartFormData.append(url, withName: "audio[]", fileName: "audio"+String(format: "%d",i) + "TODO" , mimeType: "TODO")
                }
            }

            for i in 0..<docsArr.count{
                if let url = URL(string: docsArr[i]) {
                    multipartFormData.append(url, withName: "docs[]", fileName: "docs"+String(format: "%d",i) + "TODO" , mimeType: "TODO")
                }
            }

            for key in parameters.keys{
                let name = String(key)
                var val = ""
                    if name! == "id" {
                            val = String(parameters[name!] as! Int)
                    }
                    else{
                            val = parameters[name!] as! String
                    }
                multipartFormData.append(val.data(using: .utf8)!, withName: name!)
            }

        },
                         to: url,
                         method: method,
                         headers : headers,
                         encodingCompletion:{ encodingResult in
                        switch encodingResult{
                            case .success(let upload, _, _):
                                upload.validate().responseJSON{ (responseJSON) in
                                    switch responseJSON.result {
                                    case .success(let value):
                                        let json = JSON(value)
                                        successCallback?(json)
                                    case .failure(let error):
                                        if let callback = failureCallback {
                                            // Return
                                            callback(error.localizedDescription)
                                        }
                                    }
                                    
                            }
                        case .failure(let error):
                            if let callback = failureCallback {
                                // Return
                                callback(error.localizedDescription)
                            }
                            }
        }
            
        )
    }
}
