//
//  CommentsModel.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 30/01/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
class CommentsModel :  GeneralModel{
    var post_id : String = ""
    var comments: [[String :AnyObject]] = Array()
    internal func loadData (_ dict : [String: AnyObject]){
        if let data = dict["post_id"] {
            self.post_id = data as! String
        }
        if let data = dict["comments"]{
            self.comments = data as! [[String : AnyObject]]
        }
    }
    internal func build(_ dict: [String:AnyObject])->GeneralModel {
        let model = CommentsModel()
        model.loadData(dict)
        return model
    }
}
