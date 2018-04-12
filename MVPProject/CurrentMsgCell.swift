//
//  CurrentMsgCell.swift
//  MVPProject
//
//  Created by Dugar Badagarov on 06/03/2018.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation

extension CurrentMessagesCell
{
    func setView()
    {        
        contentView.addSubview(bubbleView)
        bubbleView.addSubview(msg)
        bubbleView.addSubview(date)            
        
        msg.isEditable = false
        msg.backgroundColor = UIColor.clear
        msg.textColor = .white
        
        bubbleView.layer.cornerRadius = 10;        
        
        msg.font = UIFont.systemFont(ofSize: 13)
        date.font = UIFont.systemFont(ofSize: 11)
        date.textColor = UIColor(white: 1, alpha: 0.6)    
        
        setConstraints();
    }
    
    func setConstraints()
    {
        bubbleView.removeConstraints(bubbleView.constraints)
        contentView.removeConstraints(contentView.constraints)
        self.removeConstraints(self.constraints)                
        
        let textH = NSString(string: msg.text).boundingRect(with: CGSize(width: (UIScreen.main.bounds.width * 0.7), height: 4000), options: NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin), attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 13)], context: nil)        
        
        bubbleRightAnchor = bubbleView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -15)
        bubbleLeftAnchor = bubbleView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 15)
        contentView.addConstraintsWithForamt(format: "H:[v0(\(max(textH.width, 100) + 31))]", views: bubbleView)
        contentView.addConstraintsWithForamt(format: "V:|-15-[v0]-15-|", views: bubbleView)
        
        bubbleView.addConstraintsWithForamt(format: "H:|-8-[v0]-8-|", views: msg)
        bubbleView.addConstraintsWithForamt(format: "H:|-8-[v0]-8-|", views: date)
        bubbleView.addConstraintsWithForamt(format: "V:|-4-[v0]-8-[v1(10)]-4-|", views: msg, date)        
    }
}
