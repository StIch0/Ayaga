//
//  CurrentMessagesViewController.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 25/01/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import UIKit

class CurrentMessagesViewController: UIViewController {
    
    var usmessModel : [UserMessagesModel] = [UserMessagesModel]()
    var id : Int = 0;
    
    var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setCollectionView()        
        setUpKeyBoardObservers()
        setInputView()
    }    
    
    func setCollectionView()
    {
        view.addSubview(collectionView)
        view.addConstraintsWithForamt(format: "H:|[v0]|", views: collectionView)
        view.addConstraintsWithForamt(format: "V:|[v0]|", views: collectionView)
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
    }
    
    func setInputView()
    {
        let inputView = UIView()
        let attachmentButton = UIButton()
        let sendButton = UIButton()
        let textField = UITextField()
        
        collectionView.addSubview(inputView)
        collectionView.addConstraintsWithForamt(format: "V:[v0(20)]|", views: inputView)
        collectionView.addConstraintsWithForamt(format: "H:|[v0]|", views: inputView)
        
        inputView.addSubview(attachmentButton)
        inputView.addSubview(sendButton)
        inputView.addSubview(textField)
        
        inputView.addConstraintsWithForamt(format: "H:|[v0(20)]-4-[v1]-2-[v2(20)]|", views: attachmentButton, textField, sendButton)
        inputView.addConstraintsWithForamt(format: "V:|[v0(20)]|", views: attachmentButton)
        inputView.addConstraintsWithForamt(format: "V:|[v0(20)]|", views: textField)
        inputView.addConstraintsWithForamt(format: "V:|[v0(20)]|", views: sendButton)
    }
}

extension CurrentMessagesViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return usmessModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrentMessagesCell", for: indexPath) as? CurrentMessagesCell ?? CurrentMessagesCell(frame: CGRect.zero)
        
        let dataMsg = usmessModel[indexPath.row]
        
        cell.audios = dataMsg.audio
        cell.date.text = dataMsg.date
        cell.docs = dataMsg.docs
        cell.from_id = dataMsg.from_id
        cell.images = dataMsg.images
        cell.is_readed = dataMsg.is_readed
        cell.msg.text = dataMsg.text
        cell.to_id = dataMsg.to_id
        cell.videos = dataMsg.video
        cell.setConstraints()     
        
        if (dataMsg.from_id == id) {
            cell.bubbleView.backgroundColor = UIColor.rgb(255, 155, 10)            
            cell.date.textAlignment = .right
            cell.date.textColor = .white
            cell.msg.textColor = UIColor.white
            cell.bubbleRightAnchor?.isActive = true
            cell.bubbleLeftAnchor?.isActive = false
        }
        else {
            cell.bubbleView.backgroundColor = UIColor.white
            cell.date.textAlignment = .left
            cell.date.textColor = .gray
            cell.msg.textColor = UIColor.black
            cell.bubbleLeftAnchor?.isActive = true
            cell.bubbleRightAnchor?.isActive = false
        }
        
        return cell
    }        
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let dataMsg = usmessModel[indexPath.row]
        
        let textH = NSString(string: dataMsg.text).boundingRect(with: CGSize(width: (UIScreen.main.bounds.width * 0.7), height: 4000), options: NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin), attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 13)], context: nil)
        
        // "V:|-4-[v0]-8-[v1(10)]-4-|"                 
        
//        return CGSize(width: min((UIScreen.main.bounds.width * 0.7), max(titleH.width, 150)), height: 4 + titleH.height + 10 + 4 + 20)
        return CGSize(width: collectionView.frame.width, height: 4 + textH.height + 8 + 10 + 4 + 20 + 30)
    }
}





// SET UP BEHAVIOUR FOR KEYBOARD !!! O_o
extension CurrentMessagesViewController
{
    func setUpKeyBoardObservers ()
    {        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    func handleKeyboardWillShow (notification : NSNotification)
    {
        let keyboardFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey]
        print (keyboardFrame.debugDescription)
    }
}
