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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setView()
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
