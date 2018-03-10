//
//  UsrInfoExt.swift
//  MVPProject
//
//  Created by Dugar Badagarov on 05/03/2018.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation

extension UserInfoCollectionViewCell
{
    func setView()
    {
        contentView.addSubview(phone    )
        contentView.addSubview(city     )
        contentView.addSubview(birthDate)
        contentView.addSubview(subNum   )
        
        var attachment = NSTextAttachment()
        attachment.image = #imageLiteral(resourceName: "phone")
        attachment.bounds = CGRect(x: 0, y: -5, width: 23, height: 22)
        
        var attr = NSMutableAttributedString(attributedString: NSAttributedString(attachment: attachment)) 
        attr.append(NSAttributedString(string: " Моб. телефон: ", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 15), NSForegroundColorAttributeName : UIColor.gray]))
        phone.attributedText = attr
        
        attachment = NSTextAttachment()
        attachment.image = #imageLiteral(resourceName: "city")
        attachment.bounds = CGRect(x: 0, y: -4, width: 23, height: 23)
        attr = NSMutableAttributedString(attributedString: NSAttributedString(attachment: attachment))
        attr.append(NSAttributedString(string: " Город: ", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 15), NSForegroundColorAttributeName : UIColor.gray]))
        city.attributedText = attr
        
        attachment = NSTextAttachment()
        attachment.image = #imageLiteral(resourceName: "dr")
        attachment.bounds = CGRect(x: 0, y: -4, width: 23, height: 21)
        attr = NSMutableAttributedString(attributedString: NSAttributedString(attachment: attachment))
        attr.append(NSAttributedString(string: " Дата рождения: ", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 15), NSForegroundColorAttributeName : UIColor.gray]))
        birthDate.attributedText = attr
        
        attachment = NSTextAttachment()
        attachment.image = #imageLiteral(resourceName: "subsNum")
        attachment.bounds = CGRect(x: 0, y: -4, width: 23, height: 23)
        attr = NSMutableAttributedString(attributedString: NSAttributedString(attachment: attachment))
        attr.append(NSAttributedString(string: " Подписчиков: ", attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 15), NSForegroundColorAttributeName : UIColor.gray]))
        subNum.attributedText = attr
        
        contentView.addSubview(userImg       )
        contentView.addSubview(nameText      )
        contentView.addSubview(phoneText     )
        contentView.addSubview(cityText      )
        contentView.addSubview(birthDateText )
        contentView.addSubview(subNumText    )
        contentView.addSubview( subscribeBtn   )
        contentView.addSubview( sendMessageBtn )
        contentView.addSubview( quitBtn        )
        
        nameText.font = UIFont.systemFont(ofSize: 20)
        nameText.textAlignment = .center
        
        userImg.image = #imageLiteral(resourceName: "no_photo")
        userImg.contentMode = .scaleAspectFill
        userImg.clipsToBounds = true
        
        quitBtn.setTitle("Выход", for: .normal)
        quitBtn.setTitleColor(.white, for: .normal)
        quitBtn.backgroundColor = .orange
        quitBtn.isHidden = true
        quitBtn.layer.cornerRadius = 10
        
        subscribeBtn.setTitle("Подписаться", for: .normal)
        subscribeBtn.setTitleColor(.white, for: .normal)
        subscribeBtn.backgroundColor = .orange
        subscribeBtn.isHidden = true
        subscribeBtn.layer.cornerRadius = 10
        
        sendMessageBtn.setTitle("Написать сообщение", for: .normal)
        sendMessageBtn.setTitleColor(.white, for: .normal)
        sendMessageBtn.backgroundColor = .orange
        sendMessageBtn.isHidden = true
        sendMessageBtn.layer.cornerRadius = 10
        
        contentView.addConstraintsWithForamt(format: "H:|[v0]|", views: userImg       )
        contentView.addConstraintsWithForamt(format: "H:|-8-[v0]-8-|", views: nameText      )
        contentView.addConstraintsWithForamt(format: "H:|-8-[v0][v1]-4-|", views: phone    , phoneText     )
        contentView.addConstraintsWithForamt(format: "H:|-8-[v0][v1]-4-|", views: city     , cityText      )
        contentView.addConstraintsWithForamt(format: "H:|-8-[v0][v1]-4-|", views: birthDate, birthDateText )
        contentView.addConstraintsWithForamt(format: "H:|-8-[v0][v1]-4-|", views: subNum   , subNumText    )
        contentView.addConstraintsWithForamt(format: "H:|-10-[v0]-5-[v1(v0)]-10-|", views: subscribeBtn, sendMessageBtn)        
        contentView.addConstraintsWithForamt(format: "H:|-15-[v0]-15-|", views: quitBtn       )        
        
        contentView.addConstraintsWithForamt(format: "V:|[v0(350)]-8-[v1(30)]-8-[v2(25)]-8-[v3(25)]-8-[v4(25)]-8-[v5(25)]-8-[v6(25)]-8-|",
                                             views: userImg, nameText, phone, city, birthDate, subNum, quitBtn)
        contentView.addConstraintsWithForamt(format: "V:|[v0(350)]-8-[v1(30)]-8-[v2(25)]-8-[v3(25)]-8-[v4(25)]-8-[v5(25)]-8-[v6(25)]-8-|",
                                      views: userImg, nameText, phoneText, cityText, birthDateText, subNumText, quitBtn)
        
        contentView.addConstraintsWithForamt(format: "V:[v0]-8-|", views: subscribeBtn)
        contentView.addConstraintsWithForamt(format: "V:[v0]-8-|", views: sendMessageBtn)                
        
        if (Profile.shared.sign) {
            quitBtn.isEnabled = true
            
        } else {
            sendMessageBtn.isEnabled = true
            subscribeBtn.isEnabled   = true
        }
    }
}

