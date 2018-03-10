//
//  CurrentCardViewController.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 29/01/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import UIKit

class CurrentCardViewController: UIViewController {
    @IBOutlet weak var tableView : UITableView?
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView?
    let limit : Int = 20
    var offset : Int = 0
    var categories : Int = 0
    let presenter  = CurrentCardPresenter(service: GeneralDataService())
    var currentCardViewData = [CurrentCardViewData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator?.hidesWhenStopped = true

        presenter.atachView(cardsView: self as ViewBuild)
        presenter.getCards(["categories":categories as AnyObject,
                            "limit":limit as AnyObject,
                            "offset":offset as AnyObject])
        tableView?.dataSource = self
        tableView?.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! CurrentCardDataViewController
        let index = sender as! Int
        controller.currentDataCardViewData = [currentCardViewData[index]]
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
extension CurrentCardViewController : ViewBuild {
    internal func setEmptyData() {
        tableView?.isHidden = true
    }
    
    internal func setData(data: [ViewData]) {
        currentCardViewData = data as! [CurrentCardViewData]
        // print(cardsViewData.first)
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
        return cell
    }
    
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentCardViewData.count
    }
}
