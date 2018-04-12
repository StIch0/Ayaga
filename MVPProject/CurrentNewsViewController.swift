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
    
    var activityIndicator = UIActivityIndicatorView()
    let presenter  = CommentsPresenter(service: GeneralDataService())
    var commentsViewData = [CommentsViewData]()
    var commensData : [[String :AnyObject]] = Array()
    var commentsDataModel = [CommentsDataModel]()
    var cmd = CommentsDataModel()
    var post_id : Int = 181
    
    let textField = UITextField()
    let customInputView = UIView() 
    var inputViewBottomAnchor : NSLayoutConstraint?
    
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
        view.addConstraintsWithForamt(format: "H:|[v0]|", views: tableView)
        view.addConstraintsWithForamt(format: "V:|[v0]-45-|", views: tableView)
        tableView.register(CurrentFeedCell.self, forCellReuseIdentifier: "CurrentFeedCell")
        tableView.register(CommentsTableViewCell.self, forCellReuseIdentifier: "CommentsTableViewCell")
        tableView.allowsSelection = false
        
        setUpInputView()
        setUpKeyBoardObservers()
        
        getComments()
    }    
    
    func getComments () {
        presenter.atachView(commentsView: self as ViewBuild)
        presenter.getComments(["post_id":post_id as AnyObject])
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)                
        
        NotificationCenter.default.removeObserver(self)
    }
}

extension CurrentNewsViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + commentsDataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {        
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentFeedCell", for: indexPath) as! CurrentFeedCell
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
            
            if (images.count > 0) {
                cell.imageHeightAnchor?.constant = 400
            }
            else {
                cell.imageHeightAnchor?.constant = 0
            }
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsTableViewCell", for: indexPath) as! CommentsTableViewCell
            let commentsData = commentsDataModel[indexPath.row - 1]
            cell.user_id = commentsData.user_id            
            cell.setLoginAndDate(commentsData.user_login, commentsData.date)
            cell.textComments.text = commentsData.textComments
            cell.images = commentsData.images
            cell.video = commentsData.video
            cell.audio = commentsData.audio
            cell.docs = commentsData.docs
            cell.controller = self
            return cell
        }                
    }   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0) {

            let textH = NSString(string: fultext).boundingRect(with: CGSize(width: tableView.frame.width, height: 4000), options: NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin), attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
                    
            // 44=profileImg, 350=imgCollectionView, 40=MarksViews, 35=extraSpace
            //|-8-[v0(44)]-4-[v1]-8-[v2(350)]-8-[v3(1)]-4-[v4(40)]|
            if (images.count > 0) {
                return 8 + 44 + 4 + textH.height + 8 + 400 + 8 + 1 + 4 + 40 + 35
            }
            
            return 8 + 44 + 4 + textH.height + 8 + 1 + 4 + 40 + 30
        }
        
        let commentsData = commentsDataModel[indexPath.row - 1]
        
        let textH = NSString(string: commentsData.textComments).boundingRect(with: CGSize(width: tableView.frame.width, height: 4000), options: NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin), attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 13)], context: nil)
        
        //"V:|-8-[v0(44)]-4-[v1]-8-|"
        
        return 8 + 44 + 4 + textH.height + 8 + 25
    }
}

extension CurrentNewsViewController {
    func handleSendMsg ()
    {
        var stringForSend = ""
        //textField.text?.lengthOfBytes(using: .ascii)
        if let strArray = textField.text?._split(separator: " ") {
            for str in strArray {
                stringForSend += str + " "
            }
            if stringForSend.isEmpty == false {stringForSend.characters.removeLast()}
        }
        
        if stringForSend.isEmpty {
            return
        }
        
        print ("Comment for send =", stringForSend)
    }
}

extension CurrentNewsViewController : ViewBuild {
    internal func setEmptyData() {
        tableView.isHidden = true
    }
    
    func setData (data: [ViewData]) {
        commentsViewData = data as! [CommentsViewData]
        commensData = (commentsViewData.last?.comments)!
        print("commentsViewData.first?.comments",commentsViewData.count)
        for item in commensData {
            let dataq = cmd.build(item)
            commentsDataModel.append(dataq as! CommentsDataModel)
        }        
        tableView.reloadData()
        print (tableView.contentOffset)
    }
    
    internal func finishLoading() {
        activityIndicator.stopAnimating()
    }
    
    internal func startLoading() {
        activityIndicator.startAnimating()
    }
}
