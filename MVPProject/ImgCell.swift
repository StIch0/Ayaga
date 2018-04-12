//
//  ImgCell.swift
//  MVPProject
//
//  Created by Dugar Badagarov on 21/03/2018.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation

class imgCell: UICollectionViewCell
{
    var img: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)  
        self.contentView.addSubview(img)
        img.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraintsWithForamt(format: "H:|-2-[v0(\(UIScreen.main.bounds.width-4))]-2-|", views: img)
        contentView.addConstraintsWithForamt(format: "V:|[v0]|", views: img)
        img.backgroundColor = .clear
        img.contentMode = .scaleAspectFit
        img.clipsToBounds = true        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

