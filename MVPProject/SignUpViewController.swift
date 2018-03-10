//
//  SignInViewController.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 05/02/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    let	login : String = "Agronom"
    let	pass :  String = "Agronom"
    let	name :  String = "Agronom"
    let	family :  String = "Agronom"
    let	city :  String = "Agronom"
    let	tel :  String = "12345678"
    let	birth_date :  String = "2000-12-12"
    let presenter = ResultPresenter(service: ResultServise())
    var activityIndicator = UIActivityIndicatorView() 
    var viewData = [ResulViewData]()
    
    var lginTF = UITextField()
    var pswdTF = UITextField()
    var cityTF = UITextField()
    var teleTF = UITextField()
    var dateTF = UITextField()
    var nameTF = UITextField()
    var surnTF = UITextField()
    var signUpBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true

//        presenter.atachView(resultView: self as ViewBuild)
//        presenter.getData(APISelected.Sign_up.rawValue, parameters: ["login":login as AnyObject,
//                                                                     "pass": pass as AnyObject,
//                                                                     "name": name as AnyObject,
//                                                                     "family": family as AnyObject,
//                                                                     "city": city as AnyObject,
//                                                                     "tel": tel as AnyObject,
//                                                                     "birth_date": birth_date as AnyObject
//                                                                     ], withName: "", imagesArr: [], videoArr: [], audioArr: [], docsArr: [])
        signUpBtn.addTarget(self, action: #selector(signUp), for: .touchDown)
        
        setView()
    }
    
    func signUp()
    {
        print ("SIGN UP")
    }
    
}
extension SignUpViewController : ViewBuild {
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
