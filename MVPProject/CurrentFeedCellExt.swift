//
//  CurrentFeedCellExt.swift
//  MVPProject
//
//  Created by Dugar Badagarov on 26/02/2018.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation

extension CurrentFeedCell
{
    func setLoginAndDate (_ login: String, _ date: String)
    {
        let attrStr = NSMutableAttributedString (string: login, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14), NSForegroundColorAttributeName: UIColor.blue])
        
        attrStr.append(NSAttributedString(string: "\n\(date)", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12), NSForegroundColorAttributeName: UIColor.gray]))
                
        user_login.titleLabel?.numberOfLines = 2        
        
        let paragraphSt = NSMutableParagraphStyle()
        paragraphSt.lineSpacing = 4
        
        attrStr.addAttribute(NSParagraphStyleAttributeName, value: paragraphSt, range: NSMakeRange(0, attrStr.string.characters.count))
        
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
    
    func setView()
    {
        imageHeightAnchor = collectionView.heightAnchor.constraint(equalToConstant: 0)
        imageHeightAnchor?.isActive = true
        
        contentView.addSubview(user_login)
        contentView.addSubview(profileImageView)
        contentView.addSubview(textV)
        contentView.addSubview(dividerLineView)
        contentView.addSubview(views)
        contentView.addSubview(like)
        contentView.addSubview(mark)
        contentView.addSubview(dislike)
        contentView.addSubview(collectionView)
        
        titleV.isEditable = false
        textV.isEditable = false
        
        dislike.setImage(#imageLiteral(resourceName: "dislike"), for: .normal)
        dislike.alpha = 0.35
        dislike.target(forAction: #selector(animateMe(_:)), withSender: dislike)
        dislike.addTarget(self, action: #selector(animateMe(_:)), for: .touchDown)
        dislike.addTarget(self, action: #selector(handleDislike(_:)), for: .touchDown)
        like.addTarget(self, action: #selector(animateMe(_:)), for: .touchDown)
        like.addTarget(self, action: #selector(handleLike(_:)), for: .touchDown)
        like.setImage(#imageLiteral(resourceName: "like"), for: .normal)
        like.alpha = 0.35
        
        mark.textColor = .gray
        mark.textAlignment = .center
    
        textV.font = UIFont.systemFont(ofSize: 14)
        
        dividerLineView.backgroundColor = UIColor.rgb(226, 228, 232)        
        profileImageView.image = #imageLiteral(resourceName: "no_photo")
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true        
        setLoginAndDate("qwe", "01.02.2018 12:11")
        setViewsText("123")                
        
        
        
        collectionView.backgroundColor = UIColor(white: 0.95, alpha: 1) 
        collectionView.alwaysBounceHorizontal = true
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 400)
        layout.minimumLineSpacing = 0
        collectionView.isPagingEnabled = true
        collectionView.collectionViewLayout = layout
        
        user_login.removeConstraints(user_login.constraints)
        user_login.addConstraintsWithForamt(format: "H:|[v0]|", views: user_login.titleLabel!)
        user_login.addConstraintsWithForamt(format: "V:|[v0]|", views: user_login.titleLabel!)  
        
        setConstraints()
    }
    
    func setConstraints()
    {
        self.contentView.removeConstraints(self.contentView.constraints)   
        contentView.addConstraintsWithForamt(format: "H:|[v0]|", views: textV)           
        contentView.addConstraintsWithForamt(format: "H:|-15-[v0]-15-|", views: dividerLineView)
        contentView.addConstraintsWithForamt(format: "H:|-8-[v0(44)]-8-[v1]|", views: profileImageView, user_login)
        contentView.addConstraintsWithForamt(format: "H:|-10-[v0]", views: views)
        contentView.addConstraintsWithForamt(format: "H:[v0(24)][v1(40)][v2(24)]-15-|", views: dislike, mark, like)
        contentView.addConstraintsWithForamt(format: "V:[v0(24)]-7-|", views: like)
        contentView.addConstraintsWithForamt(format: "V:[v0(24)]-7-|", views: mark)
        contentView.addConstraintsWithForamt(format: "V:[v0(24)]-7-|", views: dislike)        
        contentView.addConstraintsWithForamt(format: "V:|-8-[v0(44)]", views: user_login)
        contentView.addConstraintsWithForamt(format: "H:|[v0]|", views: collectionView)        
        contentView.addConstraintsWithForamt(format: "V:|-8-[v0(44)]-4-[v1]-8-[v2]-8-[v3(1)]-4-[v4(40)]|", views: profileImageView, textV, collectionView, dividerLineView, views)        
    }
}



extension CurrentFeedCell: UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imgCell", for: indexPath) as! imgCell
        print (cell.img)
        cell.img.loadImageUsingCacheWithUrlString(APICallManager.instanse.API_BASE_URL + images[indexPath.row], nil, UIActivityIndicatorView())
        print (cell.bounds)
        return cell
    }
}



