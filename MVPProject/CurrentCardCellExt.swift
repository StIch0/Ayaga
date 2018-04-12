//
//  CurrentCardCellExt.swift
//  MVPProject
//
//  Created by Dugar Badagarov on 19/03/2018.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation

extension CurrentCardTableViewCell
{
    func setView()
    {
        contentView.addSubview(img)
        contentView.addSubview(titleView)
        contentView.addSubview(textView)
        
        titleView.font = UIFont.boldSystemFont(ofSize: 15)
        titleView.numberOfLines = 0
        titleView.textAlignment = .center
        
        textView.font = UIFont.systemFont(ofSize: 13)
        textView.numberOfLines = 0
        
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        
        setContstraints()
    }
    
    func setContstraints()
    {
        contentView.addConstraintsWithForamt(format: "H:|-8-[v0]-8-|", views: titleView)
        contentView.addConstraintsWithForamt(format: "H:|-8-[v0]-8-|", views: textView)
        contentView.addConstraintsWithForamt(format: "H:|[v0]|", views: img)        
        contentView.addConstraintsWithForamt(format: "V:|-8-[v0]-4-[v1]-8-[v2]-8-|", views: titleView, textView, img)
    }
}
