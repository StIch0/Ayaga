//
//  UserInfoCollectionViewCell.swift
//  MVPProject
//
//  Created by Dugar Badagarov on 05/03/2018.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import UIKit

class UserInfoCollectionViewCell: UICollectionViewCell {
    var nameText       = UILabel()
    var phoneText      = UILabel()
    var cityText       = UILabel()
    var birthDateText  = UILabel()
    var subNumText     = UILabel()
    var userImg        = UIImageView()
    var subscribeBtn   = UIButton()
    var sendMessageBtn = UIButton()
    var quitBtn        = UIButton()  
    
    var name        = UILabel()
    var phone       = UILabel()
    var city        = UILabel()
    var birthDate   = UILabel()
    var subNum      = UILabel()
    var user_id  : Int = 0
    
    var subscrViewData = [ResulViewData]()
    
    var controller : UIViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setView()
        setConstraints()
        
        quitBtn.addTarget(self, action: #selector(handleQuit), for: .touchDown)
        subscribeBtn.addTarget(self, action: #selector(handleSubsribe), for: .touchDown)
        sendMessageBtn.addTarget(self, action: #selector(handleWriteMessage), for: .touchDown)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func handleQuit()
    {
        //reset Profile.shared
        
        let newController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SignInViewController")
        controller?.navigationController?.pushViewController(newController, animated: true)
    }
    
    func handleWriteMessage()
    {
        let newController = CurrentMessagesViewController()
        newController.id = Profile.shared.id
        newController.to_id = user_id
        
        controller?.navigationController?.pushViewController(newController, animated: true)
    }
    
    func handleSubsribe()
    {
        if (subscribeBtn.backgroundColor == .orange) {
            let subcrPresenter = ResultPresenter(service: ResultServise())
            subcrPresenter.atachView(resultView: self as ViewBuild)
            subcrPresenter.getData(APISelected.Add_subscribe.rawValue, parameters: ["user_id" : Profile.shared.id as AnyObject, "author_id" : user_id as AnyObject], withName: "", imagesArr: [], videoArr: [], audioArr: [], docsArr: [])
        }
        else {
            let subcrPresenter = ResultPresenter(service: ResultServise())
            subcrPresenter.atachView(resultView: self as ViewBuild)
            subcrPresenter.getData(APISelected.Del_subscribe.rawValue, parameters: ["user_id" : Profile.shared.id as AnyObject, "author_id" : user_id as AnyObject], withName: "", imagesArr: [], videoArr: [], audioArr: [], docsArr: [])
        }
    }
    
    func toggleSubscrColor ()
    {
        if subscribeBtn.backgroundColor == .orange {
            UIView.animate(withDuration: 0.2, animations: {
                self.subscribeBtn.backgroundColor = UIColor.rgb(190, 190, 190)
                self.subscribeBtn.setTitle("Вы подписаны", for: .normal)
            })
           
        }
        else {
            UIView.animate(withDuration: 0.2, animations: {
                self.subscribeBtn.backgroundColor = .orange
                self.subscribeBtn.setTitle("Подписаться", for: .normal)
            })
        }
    }
}

extension UserInfoCollectionViewCell : ViewBuild
{
    internal func setData(data: [ViewData]) {
        subscrViewData.append(contentsOf: data as! [ResulViewData])
        if subscrViewData.last?.result == "OK" {
            toggleSubscrColor()
        }
    
    }
    
    internal func setEmptyData() {
        
    }
    internal func startLoading() {
        // Show your loader
        print("Show your loader")
        
    }
    
    internal func finishLoading() {
        // Dismiss your loader
        
    }
}
