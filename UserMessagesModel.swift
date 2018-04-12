//
//  UserMessagesModel.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 27/01/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
class UserMessagesModel : GeneralModel{
    var from_id : Int = 0
    var to_id : Int = 0
    var date: String = ""
    var text : String = ""
    var is_readed : Int  = 0
    var images : [String] = Array()
    var audio : [String] = Array()
    var video : [String] = Array()
    var docs : [String] = Array()

    internal func loadData (_ dict : [String :AnyObject]) {
        if let data = dict["from_id"]  {
            self.from_id = data as! Int
        }
        if let data = dict["to_id"]  {
            self.to_id = data as! Int
        }
        if let data = dict["date"]  {
            self.date = data as! String
        }
        if let data = dict["text"]  {
            self.text = data as! String
        }
        if let data = dict["is_readed"]  {
            self.is_readed = data as! Int
        }
        if let data = dict["images"]  {
            self.images = data as! [String]
        }
        if let data = dict["audio"]  {
            self.audio = data as! [String]
        }
        if let data = dict["video"]  {
            self.video = data as! [String]
        }
        if let data = dict["docs"]  {
            self.docs = data as! [String]
        }
    }
    internal func build (_ dict : [String: AnyObject]) ->GeneralModel{
        let model = UserMessagesModel()
        model.loadData(dict)
        return model
    }
}
