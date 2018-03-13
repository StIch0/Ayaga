//
//  CurrentMessageExt.swift
//  MVPProject
//
//  Created by Dugar Badagarov on 10/03/2018.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation

extension CurrentMessagesViewController
{
    func setCollectionView()
    {
        view.addSubview(collectionView)
        view.addConstraintsWithForamt(format: "H:|[v0]|", views: collectionView)
        view.addConstraintsWithForamt(format: "V:|[v0]-45-|", views: collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        collectionView.register(CurrentMessagesCell.self, forCellWithReuseIdentifier: "CurrentMessagesCell")
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        collectionView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        collectionView.keyboardDismissMode = .interactive
    }    
    
    func setUpInputView () {
        view.addSubview(customInputView)
        view.addConstraintsWithForamt(format: "H:|[v0]|", views: customInputView)
        customInputView.heightAnchor.constraint(equalToConstant: 45).isActive = true
        inputViewBottomAnchor = customInputView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        inputViewBottomAnchor?.isActive = true
        
        let dividerLine = UIView()
        let attachmentButton = UIButton()
        let sendButton = UIButton()                
        
        customInputView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 45)        
        
        customInputView.backgroundColor = .white
        customInputView.clipsToBounds = false        
        
        customInputView.addSubview(attachmentButton)
        customInputView.addSubview(sendButton)
        customInputView.addSubview(self.textField)
        customInputView.addSubview(dividerLine)
        
        dividerLine.backgroundColor = UIColor.rgb(225, 225, 225)
        sendButton.setImage(#imageLiteral(resourceName: "send"), for: .normal)
        sendButton.addTarget(self, action: #selector(handleSendMsg), for: .touchDown)
        self.textField.font = UIFont.systemFont(ofSize: 13)
        self.textField.placeholder = "Написать сообщение..."
        attachmentButton.setImage(#imageLiteral(resourceName: "attachment"), for: .normal)
        
        customInputView.addConstraintsWithForamt(format: "H:|[v0]|", views: dividerLine)
        customInputView.addConstraintsWithForamt(format: "V:|-(-1)-[v0(1)]", views: dividerLine)        
        customInputView.addConstraintsWithForamt(format: "H:|-(7.5)-[v0(30)]-8-[v1]-2-[v2(35)]-4-|", views: attachmentButton, self.textField, sendButton)
        customInputView.addConstraintsWithForamt(format: "V:|-(7.5)-[v0]-(7.5)-|", views: attachmentButton)
        customInputView.addConstraintsWithForamt(format: "V:|[v0]|", views: self.textField)
        customInputView.addConstraintsWithForamt(format: "V:|-5-[v0]-5-|", views: sendButton)                
    }
}

// SET UP BEHAVIOUR FOR KEYBOARD !!! O_o 	
extension CurrentMessagesViewController
{
    func setUpKeyBoardObservers ()
    {        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }            
    
    func handleKeyboardWillShow (notification : NSNotification)
    {
        let keyboardFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect
        inputViewBottomAnchor?.constant = -(keyboardFrame?.height)!
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
