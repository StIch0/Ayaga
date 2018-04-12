//
//  CurrentCardViewController.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 29/01/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import UIKit

class CurrentCardViewController: UIViewController {
    var tableView = UITableView()
    var activityIndicator = UIActivityIndicatorView()
    let limit : Int = 20
    var offset : Int = 0
    var categories : Int = 0
    let presenter  = CurrentCardPresenter(service: GeneralDataService())
    var currentCardViewData = [CurrentCardViewData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true

        print ("Cat = ", categories)
        
        presenter.atachView(cardsView: self as ViewBuild)
        presenter.getCards(["category":categories as AnyObject,
                            "limit":limit as AnyObject,
                            "offset":offset as AnyObject])
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        tableView.register(CurrentCardTableViewCell.self, forCellReuseIdentifier: "CurrentCardTableViewCell")
        view.addConstraintsWithForamt(format: "H:|[v0]|", views: tableView)
        view.addConstraintsWithForamt(format: "V:|[v0]|", views: tableView)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! CurrentCardDataViewController
        let index = sender as! Int
        controller.currentDataCardViewData = [currentCardViewData[index]]
    }
}
extension CurrentCardViewController : ViewBuild {
    internal func setEmptyData() {
        tableView.isHidden = true
    }
    
    internal func setData(data: [ViewData]) {
        currentCardViewData = data as! [CurrentCardViewData]
        // print(cardsViewData.first)
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
extension CurrentCardViewController  : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "currentCardDataSegue", sender: indexPath.row)
    }
}
extension CurrentCardViewController : UITableViewDataSource {
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : CurrentCardTableViewCell  = tableView.dequeueReusableCell(withIdentifier: "CurrentCardTableViewCell", for: indexPath) as! CurrentCardTableViewCell
        let cardsData = currentCardViewData[indexPath.row]
        cell.id = cardsData.id
        cell.title = cardsData.title
        cell.textCard = cardsData.textCard
        cell.images = cardsData.images
        
        cell.textView.text = cardsData.textCard
        cell.titleView.text = cardsData.title
        
        if (cardsData.images.count > 0) {
            cell.img.loadImageUsingCacheWithUrlString(APICallManager.instanse.API_BASE_URL + cardsData.images[0], nil, UIActivityIndicatorView())
            cell.imgHeightConstraint.constant = 350;
            cell.imgHeightConstraint.isActive = true
        }
        else {
            cell.imgHeightConstraint.constant = 0;
            cell.imgHeightConstraint.isActive = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let data = currentCardViewData[indexPath.row]
        let titleH = NSString(string: data.title).boundingRect(with: CGSize(width: tableView.frame.width, height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin), attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 15)], context: nil)
        let textH = NSString(string: data.textCard).boundingRect(with: CGSize(width: tableView.frame.width, height: 4000), options: NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin), attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 13)], context: nil)
        
        var imgH = CGFloat(0)
        
        if data.images.count > 0 {
            imgH = 350
        }
    
        // V:|-8-[v0]-4-[v1]-8-[v2]-8-|
        return 8 + titleH.height + 4 + textH.height + 8 + imgH + 8 + 20
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentCardViewData.count
    }
}
