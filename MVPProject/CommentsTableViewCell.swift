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
    var user_login   = UIButton()
    var textComments = UITextView()
    var images : [String] = Array()
    var audio : [String] = Array()
    var video : [String] = Array()
    var docs : [String] = Array()
    
    var controller : UIViewController? = nil
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        user_login.addTarget(self, action: #selector(handleUserLoginButton), for: .touchDown)
        setView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func handleUserLoginButton ()
    {
        print ("qweqweqweqweq")
        let ctrller = UsrInfoViewController()
        ctrller.id = user_id
        if let ctrl = controller {
            ctrl.navigationController?.pushViewController(ctrller, animated: true)
        }
    }
}
