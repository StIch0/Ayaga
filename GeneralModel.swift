//
//  GeneralModel.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 31/01/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
protocol GeneralModel  {
    func loadData(_ dict : [String: AnyObject]) -> Void
    func build (_ dict : [String :AnyObject])->GeneralModel
}
