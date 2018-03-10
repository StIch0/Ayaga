//
//  NewsModel.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 10/01/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation

class NewsModel : GeneralModel{
    //properties

    var post_id : Int = 0
    var userLogin: String = ""
    var user_id : Int = 0
    var title : String = ""
    var short : String = ""
    var text : String = ""
    var date : String = ""
    var images : [String] = Array()
    var docs : [String] = Array()
    var audio : [String] = Array()
    var video : [String] = Array()
    var img : UIImage = UIImage()
    var views : String = ""
    var mark : Int = 0
    var user_mark  : Int = 0
     //let data : String?
     internal func loadData(_ dict : [String : AnyObject]) -> Void {
        if let data = dict["post_id"]  {
            self.post_id = data as! Int
        }
        if let data = dict["user_id"]  {
            self.user_id = data as! Int
        }
        
        self.userLogin = dict["user_login"] as? String ?? "Admin"
     
        if let data = dict["title"]  {
            self.title = data as! String
        }
        if let data = dict["short"]  {
            self.short = data as! String
        }
        if let data = dict["text"]  {
            self.text = data as! String
        }
        if let data = dict["date"]  {
            self.date = data as! String
        }
        if let data = dict["images"]  {
            self.images = data as! [String]
        }
        if let data = dict["docs"]  {
            self.docs = data as! [String]
        }
        if let data = dict["audio"]  {
            self.audio = data as! [String]
        }
        if let data = dict["video"]  {
            self.video = data as! [String]
        }
        if let data = dict["views"]  {
            self.views = data as! String
        }
        if let data = dict["mark"]  {
            self.mark = data as! Int
        }
        if let data = dict["user_mark"]  {
            self.user_mark = data as! Int
        }
        if let img = dict["img"] {
            self.img = img as! UIImage
        }
    }
   internal func build(_ dict : [String: AnyObject])->GeneralModel{
        let news = NewsModel()
        news.loadData(dict)
        return news
    }
}
