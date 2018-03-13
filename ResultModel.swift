//
//  Model.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 15/01/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
class ResultModel  {
    
    var status : String = ""
    var id : AnyObject? = 0 as AnyObject
    
    func loadData(_ dict : [String : AnyObject]) -> Void {
        self.status = dict["status"] as? String ?? "Default"
        self.id = dict["id"] as? AnyObject ?? -1 as AnyObject        
    }
    
    class func build(_ dict : [String: AnyObject])->ResultModel {
        let model = ResultModel()
        model.loadData(dict)
        return model
    }
}
