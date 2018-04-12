//
//  CommentCellExt.swift
//  MVPProject
//
//  Created by Dugar Badagarov on 13/03/2018.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation

extension CommentsTableViewCell
{
    func setView ()
    {
        contentView.addSubview(user_login   )
        contentView.addSubview(textComments )
        
        user_login.removeConstraints(user_login.constraints)        
        user_login.addConstraintsWithForamt(format: "H:|[v0]|", views: user_login.titleLabel!)
        user_login.addConstraintsWithForamt(format: "V:|[v0]|", views: user_login.titleLabel!)
        
        textComments.isEditable = false
        textComments.font = UIFont.systemFont(ofSize: 13)
        textComments.isScrollEnabled = false
        setConstraints()
    }
    
    func setLoginAndDate (_ login: String, _ date: String)
    {
        let attrStr = NSMutableAttributedString (string: login, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14), NSForegroundColorAttributeName: UIColor.blue])
        
        attrStr.append(NSAttributedString(string: "\n\(date)", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12), NSForegroundColorAttributeName: UIColor.gray]))
        
        
        user_login.titleLabel?.numberOfLines = 2        
        
        let paragraphSt = NSMutableParagraphStyle()
        paragraphSt.lineSpacing = 4
        
        attrStr.addAttribute(NSParagraphStyleAttributeName, value: paragraphSt, range: NSMakeRange(0, attrStr.string.count))
        
        user_login.setAttributedTitle(attrStr, for: .normal)        
    }
    
    func setConstraints()
    {        
        user_login.backgroundColor   = .clear
        textComments.backgroundColor = .clear
        
        user_login.translatesAutoresizingMaskIntoConstraints = false
        textComments.translatesAutoresizingMaskIntoConstraints = false                
        
        user_login.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        user_login.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        user_login.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
        user_login.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        textComments.topAnchor.constraint(equalTo: user_login.bottomAnchor, constant: 8).isActive = true
        textComments.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        textComments.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
        textComments.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        textComments.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    
}
