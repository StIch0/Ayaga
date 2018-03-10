//
//  CurrentCardModel.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 29/01/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
class CurrentCardModel : GeneralModel{
    var id : Int = 0
    var title : String = ""
    var textCard  :String = ""
    var images : [String] = Array ()
   internal func loadData(_ dict : [String: AnyObject]){
        if let data = dict["id"] {
            self.id = data as! Int
        }
        if let data = dict["title"] {
            self.title = data as! String
        }
        if let data = dict["text"] {
            self.textCard = data as! String
        }
        if let data = dict["images"] {
            self.images = data as! [String]
        }
    }
    internal func build (_ dict : [String : AnyObject])->GeneralModel{
        let model = CurrentCardModel()
        model.loadData(dict)
        return model
    }
}
