//
//  MessagesModel.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 25/01/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
class MessagesModel : GeneralModel{
    var user_id : String = ""
    var count: Int = 0
    var user_login : String = ""
    var user_photo : String = ""
    var user_messages : [[String:AnyObject]] = Array()
    var usmess : [UserMessagesModel] = [UserMessagesModel]()
    internal func loadData (_ dict : [String : AnyObject]) {
        if let data = dict["user_id"]  {
            self.user_id = data as! String
        }
        if let data = dict["count"]  {
            self.count = data as! Int
        }
        if let data = dict["user_login"]  {
            self.user_login = data as! String
        }
        if let data = dict["user_photo"]  {
            self.user_photo = data as! String
        }
        if let data = dict["user_messages"]  {
             self.user_messages = data as! [[String : AnyObject]]
            
         }
    }
    internal func build (_ dict : [String: AnyObject])->GeneralModel {
        let mess = MessagesModel()
        mess.loadData(dict)
        return mess
    }
}
