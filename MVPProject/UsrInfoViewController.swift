//
//  UsrInfoViewController.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 14/01/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import UIKit

class UsrInfoViewController: UIViewController {

    var nameText       = ""
    var surNameText    = ""
    var phoneText      = ""
    var cityText       = ""
    var birthDateText  = ""
    var subNumText     = ""
    var userImg        = ""
    var subscribeBtn   = ""
    var sendMessageBtn = ""
    var quitBtn        = ""    
    
    var indicator = UIActivityIndicatorView()
    var presenter : UserInfoPresenter = UserInfoPresenter(service: GeneralDataService())
    var userInfoDispaly = [UserInfoViewData]()
    var id : Int = 0
    var collectionView : UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (id == Profile.shared.id) {
            let reveal : SWRevealViewController? = revealViewController()        
            if reveal != nil {                        
                navigationItem.setLeftBarButtonItems([UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: reveal, action: #selector(reveal?.revealToggle(_:)))], animated: true)            
                self.view.addGestureRecognizer((reveal?.panGestureRecognizer())!)
            }
        }
        indicator.hidesWhenStopped = true
        presenter.atachView(userInfoView: self as ViewBuild)
        presenter.getUserInfo(["id":id as AnyObject])       
        
        setCollectionView()        
    }
    
    func setCollectionView()
    {
        view.addSubview(collectionView)
        view.addConstraintsWithForamt(format: "V:|[v0]|", views: collectionView)
        view.addConstraintsWithForamt(format: "H:|[v0]|", views: collectionView)
        collectionView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UserInfoCollectionViewCell.self, forCellWithReuseIdentifier: "UserInfoCollectionViewCell")
        
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10;
        collectionView.collectionViewLayout = layout
    }
    
    func loadData () {
        print("userInfoDispaly",userInfoDispaly)
        let userData  = userInfoDispaly.first
        nameText      = userData?.name       ?? "ERROR"
        surNameText   = userData?.surName    ?? "ERROR"
        phoneText     = userData?.phone      ?? "ERROR"
        cityText      = userData?.city       ?? "ERROR"
        birthDateText = userData?.birth_date ?? "ERROR"
        subNumText    = userData?.sub_num    ?? "ERROR"
        collectionView.reloadData()
    }
}

extension UsrInfoViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserInfoCollectionViewCell", for: indexPath) as? UserInfoCollectionViewCell ?? UserInfoCollectionViewCell(frame: CGRect.zero)
        
        cell.nameText.text      = nameText + " " + surNameText
        cell.phoneText.text     = phoneText
        cell.cityText.text      = cityText
        cell.birthDateText.text = birthDateText
        cell.subNumText.text    = subNumText
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                                        // "V:|[v0(350)]-8-[v1(30)]-8-[v2(25)]-8-[v3(25)]-8-[v4(25)]-8-[v5(25)]-8-[v6(25)]-8-|"
        return CGSize(width: collectionView.frame.width, height: 350 + 8 + 30 + 8 + 25 + 8 + 25 + 8 + 25 + 8 + 25 + 8 + 25 + 8 + 20)
    }
}

extension UsrInfoViewController : ViewBuild {
    internal func setEmptyData() {
        view.isHidden = true
    }

    internal func setData(data: [ViewData]) {
        view.isHidden = false
        userInfoDispaly = data as! [UserInfoViewData]
        loadData()
    }

    internal func finishLoading() {
        indicator.stopAnimating()
    }

    internal func startLoading() {
        indicator.startAnimating()
    }
}
