//
//  CardsViewController.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 29/01/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {
    var presenter = CardsPresenter(service: GeneralDataService())
    var cardsViewData  = [CardsViewData]()
    var tableView : UITableView = UITableView()
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView?
    var parents : Int = 0
    var children : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        let reveal : SWRevealViewController? = revealViewController()
        if (parents == 0) {
            
            if reveal != nil {                        
                navigationItem.setLeftBarButtonItems([UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: reveal, action: #selector(reveal?.revealToggle(_:)))], animated: true)            
                self.view.addGestureRecognizer((reveal?.panGestureRecognizer())!)
            }
        }
        activityIndicator?.hidesWhenStopped = true
        presenter.atachView(cardsView: self as ViewBuild)
        if parents == 0 { presenter.getCards([:]) } else { presenter.getCards(["parent":parents as AnyObject]) }
        
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        print (tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! CurrentCardViewController
        let index = sender as! Int
        controller.categories = index
    }
}

extension CardsViewController : UITableViewDataSource {
    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        let cardsData = cardsViewData[indexPath.row]        
        cell.textLabel?.text = cardsData.title
        
        return cell
    }

    @available(iOS 2.0, *)
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return cardsViewData.count
    }
}

extension CardsViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cardsData = cardsViewData[indexPath.row]
        parents = cardsData.id
        children = cardsData.childrens
        if children != 1 {
            let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:"CardsViewController") as! CardsViewController 
            controller.parents = parents
            navigationController?.pushViewController(controller, animated: true)            
        }else {
            performSegue(withIdentifier: "currentCardSegue", sender: parents)
        }
    }
}
extension CardsViewController : ViewBuild {
    internal func setEmptyData() {
        tableView.isHidden = true
    }

    internal func setData(data: [ViewData]) {
        cardsViewData = data as! [CardsViewData]
       // print(cardsViewData.first)
        tableView.isHidden = false
        tableView.reloadData()

    }

    internal func finishLoading() {
        activityIndicator?.stopAnimating()
    }

    internal func startLoading() {
        activityIndicator?.startAnimating()
        activityIndicator?.stopAnimating()
    }



}
