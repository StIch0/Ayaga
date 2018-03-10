//
//  CommetsDataModel.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 30/01/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
class CommentsDataModel : GeneralModel {
    var user_id : Int = 0
    var user_login : String = ""
    var date : String = ""
    var textComments : String = ""
    var images : [String] = Array()
    var audio : [String] = Array()
    var video : [String] = Array()
    var docs : [String] = Array()

 internal func loadData (_ dict: [String: AnyObject]) {
    if let data = dict["user_id"]{
        self.user_id = data as! Int
    }
    if let data = dict["user_login"]{
        self.user_login = data as! String
    }
    if let data = dict["date"]{
        self.date = data as! String
    }
    if let data = dict["text"]{
        self.textComments = data as! String
    }
    if let data = dict["images"]{
        self.images = data as! [String]
    }
    if let data = dict["audio"]{
        self.audio = data as! [String]
    }
    if let data = dict["video"]{
        self.video = data as! [String]
    }
    if let data = dict["docs"]{
        self.docs = data as! [String]
    }
}
    internal func build (_ dict : [String: AnyObject])->GeneralModel{
        let model = CommentsDataModel()
        model.loadData(dict)
        return model
    }
}
