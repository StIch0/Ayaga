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
    var to_id : Int = 0;
    var scrolled = false
        
    let textField = UITextField()    
    let customInputView = UIView()                
    var inputViewBottomAnchor : NSLayoutConstraint?
    var activityIndicator = UIActivityIndicatorView()
    
    var sendResultViewData = [ResulViewData]()
    
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
        
        
        //КРИВОЙ СКРОЛЛ В БОТТОМ
        if !scrolled {        
            collectionView.scrollToItem(at: indexPath, at: .bottom, animated: false)
            
            if (indexPath.row == usmessModel.count-1) {
                scrolled = true
            }
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
        if let strArray = textField.text?._split(separator: " ") {
            for str in strArray {
                stringForSend += str + " "
            }
            if stringForSend.isEmpty == false {stringForSend.characters.removeLast()}
        }
        
        if stringForSend.isEmpty {
            return
        }
                
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let nowDate = dateFormatter.string(from: Date())                 
        
        let sendMsgPresenter = ResultPresenter(service: ResultServise())
        sendMsgPresenter.atachView(resultView: self as ViewBuild)
        sendMsgPresenter.getData(APISelected.Send_message.rawValue, parameters: ["from_id" : id as AnyObject, "to_id" : to_id as AnyObject, "text" : stringForSend as AnyObject, "date" : nowDate as AnyObject], withName: "", imagesArr: [], videoArr: [], audioArr: [], docsArr: [])
        
        
        let msgModel = UserMessagesModel()
        msgModel.audio = []
        msgModel.docs = []
        msgModel.images = []
        msgModel.video = []
        msgModel.date = nowDate
        msgModel.from_id = id
        msgModel.to_id = to_id
        msgModel.is_readed = 1
        msgModel.text = stringForSend
        usmessModel.append(msgModel)
        
        let insertIndexPath = IndexPath(item: usmessModel.count - 1, section: 0)
        collectionView.insertItems(at: [insertIndexPath])
        collectionView.scrollToItem(at: insertIndexPath, at: .bottom, animated: true)
    }
}


extension CurrentMessagesViewController: ViewBuild {
    internal func setEmptyData() {
        collectionView.isHidden = true
    }
    
    internal func setData(data: [ViewData]) {
        sendResultViewData = data as! [ResulViewData]        
        
        let res = sendResultViewData.first?.result ?? "" 
        
        if (res == "OK") {
            collectionView.reloadData()
            textField.text = ""
        }                        
        else {
            usmessModel.removeLast()
            let deleteIndexPath = IndexPath(item: usmessModel.count, section: 0)
            collectionView.deleteItems(at: [deleteIndexPath])
            
            collectionView.scrollToItem(at: IndexPath(item: usmessModel.count-1, section: 0), at: .bottom, animated: true)
            
            let alert = UIAlertController(title: "ERROR", message: "Ошибка при отправке сообщения", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    internal func finishLoading() {
        activityIndicator.stopAnimating()
    }
    
    internal func startLoading() {
        activityIndicator.startAnimating()
    }
}
