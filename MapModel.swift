//
//  MapModel.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 05/02/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
class MapModel : GeneralModel {
    var map : [String] = Array()
    internal func loadData(_ dict: [String : AnyObject]) {
        if let data = dict["map"] {
            self.map = data as! [String]
        }
    }
    
    internal func build(_ dict: [String : AnyObject]) -> GeneralModel {
        let model = MapModel()
        model.loadData(dict)
        return model
    }
}
