//
//  CurrentFeedExt.swift
//  MVPProject
//
//  Created by Dugar Badagarov on 13/03/2018.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation

extension CurrentNewsViewController
{
    func setUpInputView () {        
        view.addSubview(customInputView)
        view.bringSubview(toFront: customInputView)
        view.addConstraintsWithForamt(format: "H:|[v0]|", views: customInputView)
//        customInputView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        customInputView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        customInputView.heightAnchor.constraint(equalToConstant: 45).isActive = true
//        customInputView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        inputViewBottomAnchor = customInputView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        inputViewBottomAnchor?.isActive = true
        
        let dividerLine = UIView()        
        let attachmentButton = UIButton()
        let sendButton = UIButton()                
        
        customInputView.frame = CGRect(x: 0, y: 100, width: self.view.frame.width, height: 45)        
        
        customInputView.backgroundColor = .white
        customInputView.clipsToBounds = false        
        
        customInputView.addSubview(attachmentButton)
        customInputView.addSubview(sendButton)
        customInputView.addSubview(self.textField)
        customInputView.addSubview(dividerLine)        
        
        dividerLine.backgroundColor = UIColor.rgb(190, 190, 190)
        sendButton.setImage(#imageLiteral(resourceName: "send"), for: .normal)
        sendButton.addTarget(self, action: #selector(handleSendMsg), for: .touchDown)
        self.textField.font = UIFont.systemFont(ofSize: 13)
        self.textField.placeholder = "Написать комментарий..."
        attachmentButton.setImage(#imageLiteral(resourceName: "attachment"), for: .normal)
        
        customInputView.addConstraintsWithForamt(format: "H:|[v0]|", views: dividerLine)
        customInputView.addConstraintsWithForamt(format: "V:|-(-1)-[v0(1)]", views: dividerLine)        
        customInputView.addConstraintsWithForamt(format: "H:|-(7.5)-[v0(30)]-8-[v1]-2-[v2(35)]-4-|", views: attachmentButton, self.textField, sendButton)
        customInputView.addConstraintsWithForamt(format: "V:|-(7.5)-[v0]-(7.5)-|", views: attachmentButton)
        customInputView.addConstraintsWithForamt(format: "V:|[v0]|", views: self.textField)
        customInputView.addConstraintsWithForamt(format: "V:|-5-[v0]-5-|", views: sendButton)                
    }
    
    // SET UP BEHAVIOUR FOR KEYBOARD !!! O_o     
    func setUpKeyBoardObservers ()
    {        
        print ("QWERTYUIOP")
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }            
    
    func handleKeyboardWillShow (notification : NSNotification)
    {
        let keyboardFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect
        inputViewBottomAnchor?.constant = -(keyboardFrame?.height)!
        inputViewBottomAnchor?.isActive = true
        let keyboardDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue         
                
        UIView.animate(withDuration: keyboardDuration!, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    func handleKeyboardWillHide (notification : NSNotification) {
        inputViewBottomAnchor?.constant = 0
        
        let keyboardDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue   
        UIView.animate(withDuration: keyboardDuration!, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
}
