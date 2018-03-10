//
//  ComentsViewController.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 30/01/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController {
    @IBOutlet weak var tableView : UITableView?
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView?
    let presenter  = CommentsPresenter(service: GeneralDataService())
    var commentsViewData = [CommentsViewData]()
    var commensData : [[String :AnyObject]] = Array()
    var commentsDataModel = [CommentsDataModel]()
    var cmd = CommentsDataModel()
    let post_id : Int = 181
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator?.hidesWhenStopped = true

        presenter.atachView(commentsView: self as ViewBuild)
        presenter.getComments(["post_id":post_id as AnyObject])
        tableView?.dataSource = self
         // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}//79244514835
extension CommentsViewController : ViewBuild {
    internal func setEmptyData() {
        tableView?.isHidden = true
    }
    
    internal func setData (data: [ViewData]) {
        commentsViewData = data as! [CommentsViewData]
        commensData = (commentsViewData.last?.comments)!
      print("commentsViewData.first?.comments",commentsViewData.count)
        for item in commensData {
            let dataq = cmd.build(item)
            commentsDataModel.append(dataq as! CommentsDataModel)
        }
        tableView?.isHidden = false
        tableView?.reloadData()
        
    }
    
    internal func finishLoading() {
        activityIndicator?.stopAnimating()
    }
    
    internal func startLoading() {
        activityIndicator?.startAnimating()
    }
}
extension CommentsViewController : UITableViewDataSource {
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : CommentsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CommentsTableViewCell", for: indexPath) as! CommentsTableViewCell
        print("adsadasddasadsadsadasdsa")
        let commentsData = commentsDataModel[indexPath.row]
        print("commentsData",commentsData)
        cell.user_id = commentsData.user_id
        cell.user_login?.text = commentsData.user_login
        cell.date?.text = commentsData.date
        cell.textComments?.text = commentsData.textComments
        cell.images = commentsData.images
        cell.video = commentsData.video
        cell.audio = commentsData.audio
        cell.docs = commentsData.docs
        return cell
    }

    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return commentsDataModel.count
    }

    
}
