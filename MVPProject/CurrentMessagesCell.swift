//
//  CurrentMessagesTableViewCell.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 25/01/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import UIKit

class CurrentMessagesCell: UICollectionViewCell{
    var from_id : Int = 0
    var to_id : Int = 0
    var is_readed : Int = 0
    var images : [String] = Array()
    var videos : [String] = Array()
    var audios : [String] = Array()
    var docs : [String] = Array()
    
    var msg = UITextView()
    var date = UILabel()
    var bubbleView = UIView()
    
    var bubbleRightAnchor : NSLayoutConstraint?
    var bubbleLeftAnchor : NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
