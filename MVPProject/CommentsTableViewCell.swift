//
//  CommentsTableViewCell.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 30/01/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {
    var user_id : Int = 0
    @IBOutlet weak var user_login : UITextView?
    @IBOutlet weak var date : UITextView?
    @IBOutlet weak var textComments : UITextView?
    var images : [String] = Array()
    var audio : [String] = Array()
    var video : [String] = Array()
    var docs : [String] = Array()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
