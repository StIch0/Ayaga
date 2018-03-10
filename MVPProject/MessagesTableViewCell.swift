//
//  MessagesTableViewCell.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 25/01/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import UIKit

class MessagesTableViewCell: UITableViewCell {

    var count       : UILabel = UILabel()
    var user_login  : UILabel = UILabel()
    var user_photo  : UIImageView = UIImageView()
    var date        : UILabel = UILabel()
    var lastMessage : UILabel = UILabel()
    var lastMsg     : UserMessagesModel = UserMessagesModel() 
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
