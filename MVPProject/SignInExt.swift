//
//  SignInExt.swift
//  MVPProject
//
//  Created by Dugar Badagarov on 04/03/2018.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation

extension SignInViewController
{
    func setView()
    {
        let backImg = UIImageView(image: #imageLiteral(resourceName: "background"))
        self.view.addSubview(backImg)
        self.view.addSubview(lginTF)
        self.view.addSubview(pswdTF)
        self.view.addSubview(signInBtn)
        self.view.addSubview(signUpBtn)
        
        lginTF.backgroundColor = UIColor.rgb(127, 150, 244)
        lginTF.layer.cornerRadius = 17        
        lginTF.textAlignment = .center
        lginTF.placeholder = "Логин"
        lginTF.textColor = .white
        lginTF.spellCheckingType = .no
        lginTF.autocorrectionType = .no
        
        pswdTF.backgroundColor = UIColor.rgb(127, 150, 244)
        pswdTF.layer.cornerRadius = 17
        pswdTF.textAlignment = .center
        pswdTF.textColor = .white
        pswdTF.placeholder = "Пароль"        
        pswdTF.spellCheckingType = .no
        pswdTF.autocorrectionType = .no
        pswdTF.isSecureTextEntry = true
        
        signInBtn.layer.cornerRadius = 17;
        signInBtn.backgroundColor = .white
        signInBtn.setTitle("Войти", for: .normal)        
        signInBtn.setTitleColor(UIColor.rgb(127,150,244), for: .normal)
        
        signUpBtn.backgroundColor = UIColor(white: 1, alpha: 0)
        signUpBtn.setTitle("Регистрация", for: .normal)
        signUpBtn.setTitleColor(.white, for: .normal)
        
        
//        let loginIcon = UIImageView(image: #imageLiteral(resourceName: "user"))
//        let passwIcon = UIImageView(image: #imageLiteral(resourceName: "password"))
        
//        lginTF.addSubview(loginIcon)
//        pswdTF.addSubview(passwIcon)                
//        
//        lginTF.addConstraintsWithForamt(format: "H:|-6-[v0(23)]-4-[v1]-4-|", views: loginIcon, lginTF.textInputView)
//        lginTF.addConstraintsWithForamt(format: "V:|-5-[v0(25)]-5-|", views: loginIcon)
//        lginTF.addConstraintsWithForamt(format: "V:|[v0]|", views: lginTF.textInputView)
//        
//        pswdTF.addConstraintsWithForamt(format: "H:|-6-[v0(25)]-2-[v1]-4-|", views: passwIcon, pswdTF.textInputView)
//        pswdTF.addConstraintsWithForamt(format: "V:|-5-[v0(25)]-5-|", views: passwIcon)
//        pswdTF.addConstraintsWithForamt(format: "V:|[v0]|", views: pswdTF.textInputView)
//        
//        lginTF.drawText(in: lginTF.textInputView.frame)
//        pswdTF.drawText(in: pswdTF.textInputView.frame)
        
        self.view.addConstraintsWithForamt(format: "H:|[v0]|", views: backImg)
        self.view.addConstraintsWithForamt(format: "V:|[v0]|", views: backImg)
        self.view.addConstraintsWithForamt(format: "H:|-10-[v0]-10-|", views: lginTF)
        self.view.addConstraintsWithForamt(format: "H:|-10-[v0]-10-|", views: pswdTF)
        self.view.addConstraintsWithForamt(format: "H:|-10-[v0]-10-|", views: signInBtn)
        self.view.addConstraintsWithForamt(format: "H:|-10-[v0]-10-|", views: signUpBtn)
        self.view.addConstraintsWithForamt(format: "V:|-250-[v0(35)]-10-[v1(35)]-10-[v2(35)]-10-[v3(35)]", views: lginTF, pswdTF, signInBtn, signUpBtn)
    }
}
