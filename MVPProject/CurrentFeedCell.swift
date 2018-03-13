//
//  CurrentFeedCell.swift
//  MVPProject
//
//  Created by Dugar Badagarov on 20/02/2018.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import UIKit

class CurrentFeedCell: UITableViewCell {

    var profileImageView : UIImageView = UIImageView()
    var user_login : UIButton = UIButton()
    var titleV : UITextView = UITextView()
    var textV : UITextView = UITextView()
    var collectionView : UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    var views : UILabel = UILabel()
    var like : UIButton = UIButton()
    var dislike : UIButton = UIButton()
    var mark : UILabel = UILabel()
    var dividerLineView : UIView = UIView()
    var images : [String] = Array()
    var docs : [String] = Array()
    var audio : [String] = Array()
    var video : [String] = Array()        
    
    var imageHeightAnchor : NSLayoutConstraint?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(imgCell.self, forCellWithReuseIdentifier: "imgCell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.reloadData()
    }   

}

extension CurrentFeedCell
{
    func animateMe(_ sender: UIButton)
    {
        UIView.animate(withDuration: 0.2, animations: {
            if (sender.alpha < 0.5) {
                sender.alpha = 0.6
            }
            else {
                sender.alpha = 0.35
            }
        })        
    }
    
    func handleLike (_ sender: UIButton)
    {
        var cntV : Int = (mark.text! as NSString).integerValue
        
        if (dislike.alpha > 0.5) {
            animateMe(dislike)
            cntV = cntV + 2
        }
        else if (like.alpha > 0.5) {
            cntV = cntV + 1
        }        
        else {
            cntV = cntV - 1
        }
        mark.text = "\(cntV)"
    }
    
    func handleDislike (_ sender: UIButton)
    {
        var cntV = (mark.text! as NSString).integerValue
        
        if (like.alpha > 0.5) {
            animateMe(like)
            cntV = cntV - 2
        }
        else if (dislike.alpha > 0.5) {
            cntV = cntV - 1
        }
        else {
            cntV = cntV + 1
        }
        mark.text = "\(cntV)"
    }
}
