//
//  News.swift
//  MVPProject
//
//  Created by Dugar Badagarov on 26/02/2018.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import UIKit

extension NewsCell
{
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
    
    func setViewsText (_ viewsTxt: String)
    {
        let attachment = NSTextAttachment()
        attachment.image = #imageLiteral(resourceName: "eye")        
        attachment.bounds = CGRect(x: 0, y: -6, width: 23, height: 23)
        let asd = NSAttributedString(attachment: attachment)
        let attrStr = NSMutableAttributedString (attributedString: asd)        
        attrStr.append(NSAttributedString(string: " \(viewsTxt)", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15), NSForegroundColorAttributeName: UIColor.gray]))
        
        views.attributedText = attrStr
    }
    
    func setView ()
    {           
        if (constraints.count > 0) {return}
        self.backgroundColor = .white
        contentView.addSubview(profileImageView)
        contentView.addSubview(user_login)
        contentView.addSubview(title)
        contentView.addSubview(short)
        contentView.addSubview(dividerLineView)
        contentView.addSubview(views)
        contentView.addSubview(like)
        contentView.addSubview(mark)
        contentView.addSubview(dislike)
        contentView.addSubview(img)
        
        dislike.setImage(#imageLiteral(resourceName: "dislike"), for: .normal)
        dislike.alpha = 0.35        
        like.setImage(#imageLiteral(resourceName: "like"), for: .normal)
        like.alpha = 0.35
        
        
        mark.textColor = .black
        mark.alpha = 0.35
        mark.textAlignment = .center
        
        title.font = UIFont.systemFont(ofSize: 15)
        short.font = UIFont.systemFont(ofSize: 14)
        title.numberOfLines = 0
        short.numberOfLines = 0
        
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        
        dividerLineView.backgroundColor = UIColor.rgb(226, 228, 232)        
        profileImageView.image = #imageLiteral(resourceName: "no_photo")
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true        
        setLoginAndDate("qwe", "01.02.2018 12:11")
        setViewsText("123")        
        user_login.removeConstraints(user_login.constraints)
        user_login.addConstraintsWithForamt(format: "H:|[v0]|", views: user_login.titleLabel!)
        user_login.addConstraintsWithForamt(format: "V:|[v0]|", views: user_login.titleLabel!)
    }
    
    func setConstraints()
    {
        self.contentView.removeConstraints(self.contentView.constraints)                
        
        contentView.addConstraintsWithForamt(format: "H:|-8-[v0(44)]-8-[v1]|", views: profileImageView, user_login)        
        contentView.addConstraintsWithForamt(format: "V:|-8-[v0(44)]", views: user_login)
        contentView.addConstraintsWithForamt(format: "H:|-8-[v0]-8-|", views: title)
        contentView.addConstraintsWithForamt(format: "H:|-8-[v0]-8-|", views: short)        
        contentView.addConstraintsWithForamt(format: "H:|-20-[v0]-20-|", views: dividerLineView)
        contentView.addConstraintsWithForamt(format: "H:|-10-[v0]", views: views)
        contentView.addConstraintsWithForamt(format: "V:[v0(24)]-7-|", views: like)
        contentView.addConstraintsWithForamt(format: "V:[v0(24)]-7-|", views: mark)
        contentView.addConstraintsWithForamt(format: "V:[v0(24)]-7-|", views: dislike)
        contentView.addConstraintsWithForamt(format: "H:[v0(24)][v1(40)][v2(24)]-15-|", views: dislike, mark, like)
        contentView.addConstraintsWithForamt(format: "H:|[v0]|", views: img)
        
        if (images.count > 0) {                        
            contentView.addConstraintsWithForamt(format: "V:|-8-[v0(44)]-4-[v1]-4-[v2]-4-[v3(300)]-8-[v4(1)]-(-2)-[v5(40)]|", views: profileImageView, title, short, img, dividerLineView, views)         
        }
        else {
            contentView.addConstraintsWithForamt(format: "V:|-8-[v0(44)]-4-[v1]-4-[v2]-8-[v3(0)][v4(1)]-(-2)-[v5(40)]|", views: profileImageView, title, short, img, dividerLineView, views)
        }
    }       
}
