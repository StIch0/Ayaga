//
//  CardsTableViewCell.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 29/01/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import UIKit
//now it isn't important, and can be removed from project !!!
// >_>
class CardsTableViewCell: UITableViewCell {

    var title = UILabel()
    override func awakeFromNib() {
        super.awakeFromNib()
        title.topAnchor.constraint(equalTo: self.topAnchor) 
        title.leftAnchor.constraint(equalTo: self.leftAnchor)
        title.rightAnchor.constraint(equalTo: self.rightAnchor)
        title.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        //doesn't anchors work (?_?)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
