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
    
    func setView()
    {
        
        addSubview(user_login)
        addSubview(profileImageView)
        addSubview(textV)
        addSubview(dividerLineView)
        addSubview(views)
        addSubview(like)
        addSubview(mark)
        addSubview(dislike)
        addSubview(collectionView)
        
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
        
        setConstraints()
        
        collectionView.backgroundColor = UIColor(white: 0.95, alpha: 1) 
        collectionView.alwaysBounceHorizontal = true
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 400)
        layout.minimumLineSpacing = 0
        collectionView.isPagingEnabled = true
        collectionView.collectionViewLayout = layout
    }
    
    func setConstraints()
    {
        self.removeConstraints(self.constraints)
        user_login.addConstraintsWithForamt(format: "H:|[v0]|", views: user_login.titleLabel!)
        user_login.addConstraintsWithForamt(format: "V:|[v0]|", views: user_login.titleLabel!)
        addConstraintsWithForamt(format: "H:|[v0]|", views: textV)           
        addConstraintsWithForamt(format: "H:|-15-[v0]-15-|", views: dividerLineView)
        addConstraintsWithForamt(format: "H:|-8-[v0(44)]-8-[v1]|", views: profileImageView, user_login)
        addConstraintsWithForamt(format: "H:|-10-[v0]", views: views)
        addConstraintsWithForamt(format: "H:[v0(24)][v1(40)][v2(24)]-15-|", views: dislike, mark, like)
        addConstraintsWithForamt(format: "V:[v0(24)]-7-|", views: like)
        addConstraintsWithForamt(format: "V:[v0(24)]-7-|", views: mark)
        addConstraintsWithForamt(format: "V:[v0(24)]-7-|", views: dislike)        
        addConstraintsWithForamt(format: "V:|-8-[v0(44)]", views: user_login)
        addConstraintsWithForamt(format: "H:|[v0]|", views: collectionView)
        
        if (images.count > 0) {                             
            addConstraintsWithForamt(format: "V:|-8-[v0(44)]-4-[v1]-8-[v2(400)]-8-[v3(1)]-4-[v4(40)]|", views: profileImageView, textV, collectionView, dividerLineView, views)
        }
        else {
            addConstraintsWithForamt(format: "V:|-8-[v0(44)]-4-[v1]-8-[v2(0)][v3(1)]-4-[v4(40)]|", views: profileImageView, textV, collectionView, dividerLineView, views)
            return 
        }
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


class CenterCellCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    var mostRecentOffset : CGPoint = CGPoint()
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        
        if velocity.x == 0 {
            return CGPoint(x: mostRecentOffset.x+20, y: mostRecentOffset.y)
        }
        
        if let cv = self.collectionView {
            
            let cvBounds = cv.bounds
            let halfWidth = (cvBounds.size.width + 10) * 0.5;
            
            
            if let attributesForVisibleCells = self.layoutAttributesForElements(in: cvBounds) {
                
                var candidateAttributes : UICollectionViewLayoutAttributes?
                for attributes in attributesForVisibleCells {
                    
                    // == Skip comparison with non-cell items (headers and footers) == //
                    if attributes.representedElementCategory != UICollectionElementCategory.cell {
                        continue
                    }
                    
                    if (attributes.center.x == 0) || (attributes.center.x > (cv.contentOffset.x + halfWidth) && velocity.x < 0) {
                        continue
                    }
                    candidateAttributes = attributes 
                }
                
                // Beautification step , I don't know why it works!
                if(proposedContentOffset.x == -(cv.contentInset.left)) {
                    return proposedContentOffset
                }
                
                guard let _ = candidateAttributes else {
                    return mostRecentOffset
                }
                mostRecentOffset = CGPoint(x: ceil(candidateAttributes!.center.x - halfWidth + 20), y: proposedContentOffset.y)
                return mostRecentOffset
                
            }
        }
        
        // fallback
        mostRecentOffset = super.targetContentOffset(forProposedContentOffset: CGPoint(x: proposedContentOffset.x, y: proposedContentOffset.y))
        return mostRecentOffset
    }
    
    
}

class imgCell: UICollectionViewCell
{
    var img: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)        
        self.contentView.addSubview(img)
        img.translatesAutoresizingMaskIntoConstraints = false
        addConstraintsWithForamt(format: "H:|[v0(\(UIScreen.main.bounds.width))]|", views: img)
        addConstraintsWithForamt(format: "V:|[v0]|", views: img)
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

