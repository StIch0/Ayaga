//
//  SignOutExt.swift
//  MVPProject
//
//  Created by Dugar Badagarov on 05/03/2018.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation

extension SignUpViewController
{
    func setView()
    {
        let backImg = UIImageView(image: #imageLiteral(resourceName: "background"))
        
        view.addSubview(backImg)
        view.addSubview(lginTF)
        view.addSubview(pswdTF)
        view.addSubview(nameTF)
        view.addSubview(surnTF)
        view.addSubview(cityTF)
        view.addSubview(dateTF)
        view.addSubview(teleTF)        
        view.addSubview(signUpBtn)
        
        signUpBtn.setTitleColor(UIColor.rgb(127, 150, 244), for: .normal)
        signUpBtn.setTitle("Регистрация", for: .normal)
        signUpBtn.backgroundColor = .white
        signUpBtn.layer.cornerRadius = 10
        
        lginTF.placeholder = "  Логин"
        pswdTF.placeholder = "  Пароль"
        nameTF.placeholder = "  Имя"
        surnTF.placeholder = "  Фамилия"
        cityTF.placeholder = "  Город"
        dateTF.placeholder = "  Дата рождения"
        teleTF.placeholder = "  Норме телефона"    
        
        lginTF.layer.cornerRadius = 17
        pswdTF.layer.cornerRadius = 17
        nameTF.layer.cornerRadius = 17
        surnTF.layer.cornerRadius = 17
        cityTF.layer.cornerRadius = 17
        dateTF.layer.cornerRadius = 17
        teleTF.layer.cornerRadius = 17
        
        lginTF.backgroundColor = UIColor.rgb(127, 150, 244)
        pswdTF.backgroundColor = UIColor.rgb(127, 150, 244)
        nameTF.backgroundColor = UIColor.rgb(127, 150, 244)
        surnTF.backgroundColor = UIColor.rgb(127, 150, 244)
        cityTF.backgroundColor = UIColor.rgb(127, 150, 244)
        dateTF.backgroundColor = UIColor.rgb(127, 150, 244)
        teleTF.backgroundColor = UIColor.rgb(127, 150, 244)
        
        lginTF.textColor = .white
        pswdTF.textColor = .white
        nameTF.textColor = .white
        surnTF.textColor = .white
        cityTF.textColor = .white
        dateTF.textColor = .white
        teleTF.textColor = .white                                            
        
        view.addConstraintsWithForamt(format: "H:|[v0]|", views: backImg)
        view.addConstraintsWithForamt(format: "V:|[v0]|", views: backImg)
        view.addConstraintsWithForamt(format: "H:|-10-[v0]-10-|", views: lginTF)
        view.addConstraintsWithForamt(format: "H:|-10-[v0]-10-|", views: pswdTF)
        view.addConstraintsWithForamt(format: "H:|-10-[v0]-10-|", views: nameTF)
        view.addConstraintsWithForamt(format: "H:|-10-[v0]-10-|", views: surnTF)
        view.addConstraintsWithForamt(format: "H:|-10-[v0]-10-|", views: cityTF)
        view.addConstraintsWithForamt(format: "H:|-10-[v0]-10-|", views: dateTF)
        view.addConstraintsWithForamt(format: "H:|-10-[v0]-10-|", views: teleTF)
        view.addConstraintsWithForamt(format: "H:|-10-[v0]-10-|", views: signUpBtn)
        view.addConstraintsWithForamt(format: "V:|-160-[v0(35)]-10-[v1(35)]-10-[v2(35)]-10-[v3(35)]-10-[v4(35)]-10-[v5(35)]-10-[v6(35)]-10-[v7(35)]", views: nameTF, surnTF, lginTF, pswdTF, cityTF, dateTF, teleTF, signUpBtn)
    }
}
