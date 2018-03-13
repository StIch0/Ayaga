//
//  MessagesViewController.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 25/01/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController {

    var tableView = UITableView()
    var activityIndicator = UIActivityIndicatorView()
    var presenter = MessagesPresenter(service: GeneralDataService())
    var messagesViewData = [MessagesViewData]()
    var usmessModel : [UserMessagesModel] = Array()
    var umm = UserMessagesModel()
    var usMessData : [[String: AnyObject]] = Array()
    var id : Int = 4
    var needReveal : Bool = true
 
    override func viewDidLoad() {
        super.viewDidLoad()
        if (needReveal) {
            let reveal : SWRevealViewController? = revealViewController()        
            if reveal != nil {                        
                navigationItem.setLeftBarButtonItems([UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: reveal, action: #selector(reveal?.revealToggle(_:)))], animated: true)            
                self.view.addGestureRecognizer((reveal?.panGestureRecognizer())!)
            }
        }
        
        activityIndicator.hidesWhenStopped = true
        presenter.atachView(messagesView: self as ViewBuild)
        presenter.getMessages(["id": id as AnyObject])
        setTableView()        
    }
    
    func setTableView()
    {
        view.addSubview(tableView)
        view.addConstraintsWithForamt(format: "H:|[v0]|", views: tableView)
        view.addConstraintsWithForamt(format: "V:|[v0]|", views: tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MessagesTableViewCell.self, forCellReuseIdentifier: "MessagesTableViewCell")
        tableView.rowHeight = CGFloat(86)
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 86, bottom: 0, right: 0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! CurrentMessagesViewController
        let index = sender as! Int
        usMessData = messagesViewData[index].user_messages
        for item in usMessData {
            let data = umm.build(item)
            usmessModel.append(data as! UserMessagesModel)
        }
        controller.id = id
        controller.usmessModel = usmessModel
    }
}

extension MessagesViewController: ViewBuild {
    internal func setEmptyData() {
        tableView.isHidden = true
    }

    internal func setData(data: [ViewData]) {
        messagesViewData = data as! [MessagesViewData]
        tableView.isHidden = false
        tableView.reloadData()
    }

    internal func finishLoading() {
        activityIndicator.stopAnimating()
    }

    internal func startLoading() {
        activityIndicator.startAnimating()
    }
}
extension MessagesViewController: UITableViewDataSource {
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : MessagesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "MessagesTableViewCell", for: indexPath) as! MessagesTableViewCell
        let messagesData = messagesViewData[indexPath.row]
        cell.count.text = String(messagesData.count)
        cell.user_login.text = messagesData.user_login
        cell.user_photo.loadImageUsingCacheWithUrlString(APICallManager.instanse.API_BASE_URL + messagesData.user_photo, nil, UIActivityIndicatorView())
        cell.lastMsg = UserMessagesModel().build(messagesData.user_messages.last!) as? UserMessagesModel ?? UserMessagesModel() 
        cell.lastMessage.text = "  " + cell.lastMsg.text
        cell.date.text = cell.lastMsg.date
        cell.setConstraints();
        if (cell.lastMsg.to_id == id) {
            cell.lastMessage.backgroundColor = UIColor.rgb(220, 220, 220)
        } else {
            cell.lastMessage.backgroundColor = .clear            
        }
        
        return cell
    }

    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  messagesViewData.count
    }
}
extension MessagesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "messages", sender: indexPath.row)
    }
}
