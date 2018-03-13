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
        
    let textField = UITextField()    
    let customInputView = UIView()                
    var inputViewBottomAnchor : NSLayoutConstraint?
    
    var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setCollectionView()
        setUpKeyBoardObservers()        
        setUpInputView()
        
        collectionView.keyboardDismissMode = .onDrag
    }   
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)                
        
        NotificationCenter.default.removeObserver(self)
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



extension CurrentMessagesViewController
{
    func handleSendMsg ()
    {        
        var stringForSend = ""
        //textField.text?.lengthOfBytes(using: .ascii)
        if let strArray = textField.text?.split(separator: " ") {
            for str in strArray {
                stringForSend += str + " "
            }
            if stringForSend.isEmpty == false {stringForSend.removeLast()}             
        }
        
        if stringForSend.isEmpty {
            return
        }
        
        print ("Message for send =", stringForSend)
    }
}
