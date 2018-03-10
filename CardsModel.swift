//
//  CardsModel.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 29/01/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
class CardsModel : GeneralModel {
    var id : Int = 0
    var title : String = ""
    var childrens : Int  = 0
    
    internal func loadData(_ dict : [String: AnyObject]){
        if let data = dict["id"] {
            self.id = data as! Int
        }
        if let data = dict["title"] {
            self.title = data as! String
        }
        if let data = dict["childrens"]{
            self.childrens = data as! Int
        }
    }
    
    internal func build (_ dict : [String :AnyObject])->GeneralModel{
        let model = CardsModel()
        model.loadData(dict)
        return model
    }
}
