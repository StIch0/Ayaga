//
//  MapViewController.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 05/02/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {
    
    let presenter = MapPresenter (service: GeneralDataService())
    var mapViewData = [MapViewData]()
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let reveal : SWRevealViewController? = revealViewController()        
        if reveal != nil {                        
            navigationItem.setLeftBarButtonItems([UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: reveal, action: #selector(reveal?.revealToggle(_:)))], animated: true)            
            self.view.addGestureRecognizer((reveal?.panGestureRecognizer())!)
        }
        activityIndicator.hidesWhenStopped = true
        presenter.atachView(viewBuild: self)
        presenter.getComments([:])
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
extension MapViewController : ViewBuild {
    internal func finishLoading() {
        activityIndicator.stopAnimating()
    }

    internal func startLoading() {
        activityIndicator.startAnimating()
    }

    internal func setEmptyData() {
        self.view.isHidden = true
    }

    internal func setData(data: [ViewData]) {
        mapViewData = data as! [MapViewData]
        print("mapViewData.first",mapViewData.first)
        self.view.isHidden = false
    }


}
