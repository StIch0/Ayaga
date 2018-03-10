//
//  SignInViewController.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 05/02/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    var login : String = ""
    var pass : String = ""
    let presenter = ResultPresenter(service: ResultServise())
    var viewData  = [ResulViewData]()
    var lginTF = UITextField()
    var pswdTF = UITextField()    
    var signInBtn = UIButton()
    var signUpBtn = UIButton()
    
    var activityIndicator : UIActivityIndicatorView = UIActivityIndicatorView() 

    override func viewDidLoad() {
        super.viewDidLoad()
        let reveal : SWRevealViewController? = revealViewController()        
        if reveal != nil {                        
            navigationItem.setLeftBarButtonItems([UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: reveal, action: #selector(reveal?.revealToggle(_:)))], animated: true)            
            self.view.addGestureRecognizer((reveal?.panGestureRecognizer())!)
        }
        activityIndicator.hidesWhenStopped = true
        presenter.atachView(resultView: self)
        presenter.getData(APISelected.Sign_in.rawValue, parameters: ["login": login as AnyObject,
                                                                     "pass": pass as AnyObject],
                          withName: "", imagesArr: [], videoArr: [], audioArr: [], docsArr: [])
        signUpBtn.addTarget(self, action: #selector(showSignUpController), for: .touchDown)
        signInBtn.addTarget(self, action: #selector(showMyProfileController), for: .touchDown)
        setView()
    }    
    
    func showSignUpController ()
    {
        let controller = SignUpViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func showMyProfileController ()
    {
        let presenter = ResultPresenter(service: ResultServise())
        let statusView = [ResulViewData]()
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UsrInfoViewController")
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension SignInViewController : ViewBuild {
    internal func setEmptyData() {
        self.view.isHidden = true
    }
    
    internal func setData(data: [ViewData]) {
        viewData = data as! [ResulViewData]
        print(viewData.first ?? "Error")
        self.view.isHidden = false
        
    }
    
    internal func finishLoading() {
        activityIndicator.stopAnimating()
    }
    
    internal func startLoading() {
        activityIndicator.startAnimating()
    }
}
