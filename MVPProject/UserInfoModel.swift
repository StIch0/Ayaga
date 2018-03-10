//
//  Sign_in_Model.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 14/01/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
class UserInfoModel : GeneralModel{
   


    var name : String = ""
    var surName : String = ""
    var city : String = ""
    var phone : String = ""
    var sub_num : String = ""
    var birth_date : String = ""
    
    internal func loadData (_ dict : [String: AnyObject]) {
        if let data = dict["name"]  {
            self.name = data as! String
        }
        if let data = dict["family"]  {
            self.surName = data as! String
        }
        if let data = dict["city"]  {
            self.city = data as! String
        }
        if let data = dict["tel"]  {
            self.phone = data as! String
        }
        if let data = dict["sub_num"]  {
            self.sub_num = data as! String
        }
        if let data = dict["birth_date"]  {
            self.birth_date = data as! String
        }
    }
   internal func build (_ dict :[String : AnyObject]) -> GeneralModel{
        let userInfo = UserInfoModel()
        userInfo.loadData(dict)
        return userInfo
    }
}
 
