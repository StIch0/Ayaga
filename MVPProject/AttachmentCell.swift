//
//  AttachmentCell.swift
//  MVPProject
//
//  Created by Dugar Badagarov on 02/04/2018.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import UIKit

class AttachmentCell: UICollectionViewCell {

    var img = UIImageView()
    var typeIcon = UIImageView()
    var title = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
