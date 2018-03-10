//
//  CurrentNewsViewController.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 21/01/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import UIKit

class CurrentNewsViewController: UIViewController {

    var newsViewDisplay = [NewsViewData]()
    var user_login: String = ""
    var titles:     String = ""
    var short:      String = ""
    var fultext:    String = ""
    var date:       String = ""
    var images : [String] = Array()
    var docs : [String] = Array()
    var audio : [String] = Array()
    var video : [String] = Array()
    var mark :      Int = 0
    var views :      String = ""
    var user_mark : Int = 0
    var tableView = UITableView()    
    
    let presenter  = CommentsPresenter(service: GeneralDataService())
    var commentsViewData = [CommentsViewData]()
    var commensData : [[String :AnyObject]] = Array()
    var commentsDataModel = [CommentsDataModel]()
    var cmd = CommentsDataModel()
    var post_id : Int = 181
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        user_login = (newsViewDisplay.first?.login)!
        titles = (newsViewDisplay.first?.title)!
        short = (newsViewDisplay.first?.short)!
        fultext = (newsViewDisplay.first?.text)!
        date = (newsViewDisplay.first?.date)!
        images = (newsViewDisplay.first?.images)!
        docs = (newsViewDisplay.first?.docs)!
        audio = (newsViewDisplay.first?.audio)!
        video = (newsViewDisplay.first?.video)!
        mark = (newsViewDisplay.first?.mark)!
        views = (newsViewDisplay.first?.views)!
        user_mark = (newsViewDisplay.first?.user_mark)!
        print("CurrentNewsViewController",
              user_login,
              titles,
              short,
              fultext,
              date,
              images,
              docs,
              audio,
              video,
              mark,
              views,
              user_mark)
        
        self.view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addConstraintsWithForamt(format: "H:|[v0]|", views: tableView)
        self.view.addConstraintsWithForamt(format: "V:|[v0]|", views: tableView)
        tableView.register(CurrentFeedCell.self, forCellReuseIdentifier: "CurrentFeedCell")
        tableView.allowsSelection = false
    }
}

extension CurrentNewsViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = CurrentFeedCell()
        if (indexPath.row == 0) {
            cell = tableView.dequeueReusableCell(withIdentifier: "CurrentFeedCell", for: indexPath) as! CurrentFeedCell
            cell.setLoginAndDate(user_login, date)
            cell.setViewsText(views)
            cell.mark.text = "\(mark)"
            cell.textV.text = "\(titles)\n\(fultext)"
            cell.setViewsText(views)
            cell.mark.text = "\(mark)"
            cell.images = images
            cell.video = video
            cell.audio = audio
            cell.docs = docs
            cell.setConstraints()
        }
        else {
            
        }
        
        return cell
    }   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0) {

            let textH = NSString(string: fultext).boundingRect(with: CGSize(width: tableView.frame.width, height: 4000), options: NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin), attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
                    
            print (textH.height)
            // 44=profileImg, 350=imgCollectionView, 40=MarksViews, 30=extraSpace
            //|-8-[v0(44)]-4-[v1]-8-[v2(350)]-8-[v3(1)]-4-[v4(40)]|
            print (images)
            if (images.count > 0) {
                return 8 + 44 + 4 + textH.height + 8 + 400 + 8 + 1 + 4 + 40 + 35
            }
            
            return 8 + 44 + 4 + textH.height + 8 + 1 + 4 + 40 + 35
        }
        
        return 40
    }
}
