//
//  MsgCellExt.swift
//  MVPProject
//
//  Created by Dugar Badagarov on 06/03/2018.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation

extension MessagesTableViewCell
{
    func setView()
    {        
        contentView.addSubview(user_login )
        contentView.addSubview(user_photo )
        contentView.addSubview(date       )
        contentView.addSubview(lastMessage)        
        
        user_photo .layer.cornerRadius = 20
        user_photo .clipsToBounds = true
        lastMessage.layer.cornerRadius = 10
        lastMessage.clipsToBounds = true
        
        user_photo.backgroundColor = .gray
        
        date.textAlignment = .center
        date.font = UIFont.systemFont(ofSize: 12)
        date.textColor = UIColor(white: 0, alpha: 0.7)
        
        user_login.font = UIFont.systemFont(ofSize: 15)
        lastMessage.font = UIFont.systemFont(ofSize: 13)
        lastMessage.textColor = UIColor(white: 0, alpha: 0.7) 
                
        setConstraints()
    }
    
    func setConstraints()
    {
        contentView.removeConstraints(contentView.constraints)
        contentView.addConstraintsWithForamt(format: "V:|-8-[v0(70)]", views: user_photo)
        contentView.addConstraintsWithForamt(format: "V:|-8-[v0(30)]", views: date)
        contentView.addConstraintsWithForamt(format: "V:|-8-[v0(30)]-8-[v1(30)]", views: user_login, lastMessage)
        
        contentView.addConstraintsWithForamt(format: "H:|-8-[v0(70)]-8-[v1]-8-[v2(130)]|", views: user_photo, user_login, date)
        contentView.addConstraintsWithForamt(format: "H:[v0(70)]-8-[v1]-8-|", views: user_photo, lastMessage)
    }
}
