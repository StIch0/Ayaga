//
//  menuViewController.swift
//  memuDemo
//
//  Created by Parth Changela on 09/10/16.
//  Copyright © 2016 Parth Changela. All rights reserved.
//

import UIKit

class menuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    @IBOutlet weak var RandomTextUnderPict: UILabel!    
    @IBOutlet weak var tblTableView: UITableView!
    @IBOutlet weak var imgProfile: UIImageView!            
    
    public static var shared = menuViewController()
    
    var blackView = UIView()
    var location = 0;
    
    var viewControllersDict: [String:String] =
        ["Новости":"ViewController",
         "Мой профиль":"UserInfoViewController",
         "Сообщения":"MessagesViewController",
         "Лента подписок":"ViewController",
         "Историческая справка":"CardsViewController",
         "Карта":"MapViewController",
         "Создать новость":"PostNewsViewController",
         "Настройки":"SettingsViewController"]
    
    var simpleNameArr:[String] = [
        "Новости",
        "Мой профиль",
        "Историческая справка",
        "Карта"
    ]
    
    var NameArr:[String] = [
        "Новости",
        "Мой профиль",
        "Сообщения",
        "Лента подписок",
        "Историческая справка",
        "Карта",
        "Создать новость",
        "Настройки"
    ]
    
    var ManuNameArray = [String]()
    
    var simpleIconArr = [UIImage(named:"1")!,
                         UIImage(named:"2")!,
                         UIImage(named:"5")!,
                         UIImage(named:"6")!
    ]   
    
    var conArr = [UIImage(named:"1")!,
                  UIImage(named:"2")!,
                  UIImage(named:"3")!,
                  UIImage(named:"4")!,
                  UIImage(named:"5")!,
                  UIImage(named:"6")!,
                  UIImage(named:"7")!,
                  UIImage(named:"8")!
    ]   
    
    var iconArray = [UIImage]()
    
    var didLoadCalled = true
    
    func handleDissmis (bugged: Bool=false)
    {
        if let window = UIApplication.shared.keyWindow {
            //magic numbers ALERT !!!
            UIView.animate(withDuration: 0.68, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.88, options: .curveEaseOut, animations: { 
                //blackView.frame = CGRect(x: 0, y: 0, width: window.frame.width, height: window.frame.height)
                self.blackView.alpha = 0
            }, completion: nil)
        
            if (!bugged) {revealViewController().revealToggle(animated: true)}
        }                
    }
    
    func makeDark ()
    {   
        revealViewController().frontViewController.view.addSubview(blackView)
        self.blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        self.blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDissmis)))                
        self.blackView.frame = revealViewController().frontViewController.view.frame 
        self.blackView.alpha = 0                   
        
        UIView.animate(withDuration: 0.725, delay: 0, usingSpringWithDamping: 1.1, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
            self.blackView.alpha = 1                
        }, completion: nil)
            
        
    }           
    
//    func setStatusBarColorOrange ()
//    {
//        let orangeStatusBar = UIView()
////        orangeStatusBar.backgroundColor = UIColor(colorLiteralRed: 1,
////                                                  green: 0.62745098,
////                                                  blue: 0,
////                                                  alpha: 1)
//        orangeStatusBar.backgroundColor = UIColor(white: 0, alpha: 0.1)
//        orangeStatusBar.frame = CGRect(x: 0, y: 0, width: 1000, height: 20)        
//        
//        if let window = UIApplication.shared.keyWindow {
//            window.addSubview(orangeStatusBar)
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print ("MENUUUUU DID LOAD !!!!")
//        setStatusBarColorOrange()
        self.view.layer.shadowRadius = 0;
        
        revealViewController().toggleAnimationType = SWRevealToggleAnimationType.spring
        revealViewController().toggleAnimationDuration = 0.725 //magic numbers ALERT !!!                                                
        
        if let window = UIApplication.shared.keyWindow {
            revealViewController().rearViewRevealWidth = window.frame.width * 0.65
            revealViewController().draggableBorderWidth = window.frame.width * 0.05         
        }                                                                         
        
        imgProfile.layer.masksToBounds = false
        imgProfile.clipsToBounds = true                         
    }
        
    
    override func viewDidDisappear(_ animated: Bool) {
        handleDissmis(bugged: true)                
        DispatchQueue.main.async(execute: {
            while (self.blackView.alpha != 0) {
                self.blackView.removeFromSuperview()
            }
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        toggleSideMenu()
    }
    
    public func toggleSideMenu() {      
        print ("Profile.shared.name + + Profile.shared.sub_num =", Profile.shared.name + " " + Profile.shared.serName)
        if (Profile.shared.sign) {            
            ManuNameArray = NameArr
            iconArray = conArr
            RandomTextUnderPict.text = Profile.shared.name + "\n" + Profile.shared.serName
            viewControllersDict["Мой профиль"] = "UserInfoViewController"
        }
        else {
            ManuNameArray = simpleNameArr
            iconArray = simpleIconArr
            RandomTextUnderPict.text = " А Я Г А "
            viewControllersDict["Мой профиль"] = "SignInViewController"
        }
        
        tblTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {                
        makeDark()        
        if (didLoadCalled == true) {
            (self.tblTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MenuCell).setSelected(true, animated: true)            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ManuNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        
        cell.lblMenuname.text! = ManuNameArray[indexPath.row]
        cell.imgIcon.image = iconArray[indexPath.row]
        cell.frame.size = CGSize(width: cell.frame.size.width, height: 200)                                  
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        handleDissmis()        
        
        let cell:MenuCell = tableView.cellForRow(at: indexPath) as! MenuCell
        print(cell.lblMenuname.text!)        
        
        if (didLoadCalled == true) {
            if (indexPath.row != 0) {
                (self.tblTableView.cellForRow(at: IndexPath(row: 0, section: 0)))?.setSelected(false, animated: true)
            }
            didLoadCalled = false
        }

        callViewController(controllerName: cell.lblMenuname.text!)
    }

    public func callViewController (controllerName: String) {
        for i in 0...ManuNameArray.count-1 {
            if ManuNameArray[i] == controllerName {
                self.location = i
            }
        }
        let mainstoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        print("Profile.shared.sign = " , Profile.shared.sign )
        var newViewcontroller : UIViewController = UIViewController()
        newViewcontroller = mainstoryboard.instantiateViewController(withIdentifier: viewControllersDict[controllerName]!)
                        
        let newFrontController = UINavigationController.init(rootViewController: newViewcontroller)
        revealViewController().pushFrontViewController(newFrontController, animated: true)        
    }    
}
