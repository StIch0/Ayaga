//
//  CurrentCardTableViewCell.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 29/01/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import UIKit

class CurrentCardTableViewCell: UITableViewCell {
    var id : Int = 0
    var title  : String = ""
    var textCard :  String = ""
    var images : [String] = Array()
    
    var img = UIImageView()
    var titleView = UILabel()
    var textView = UILabel()
    
    var imgHeightConstraint : NSLayoutConstraint
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        imgHeightConstraint = img.heightAnchor.constraint(equalToConstant: 0)
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
