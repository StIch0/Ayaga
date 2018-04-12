//
//  ViewController.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 10/01/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
            
    var collectionView : UICollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    var activityIndicator = UIActivityIndicatorView()
    var presenter : AnyObject? = nil 
    var newsToDisplay = [NewsViewData]()
    var limit : Int = 20
    var offset : Int = 0
    var btnMenu = UIBarButtonItem()    
    var id : Int = 0
    var isNews : Bool = true 
    
    override func viewDidLoad() {
        super.viewDidLoad()                                         

        let reveal : SWRevealViewController? = revealViewController()        
        if reveal != nil {                        
            navigationItem.setLeftBarButtonItems([UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: reveal, action: #selector(reveal?.revealToggle(_:)))], animated: true)            
            self.view.addGestureRecognizer((reveal?.panGestureRecognizer())!)
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        activityIndicator.hidesWhenStopped = true
        
        
        Profile.shared.sign = true
        Profile.shared.id = 4
        if (isNews) {
            navigationItem.title = "Новости"
            presenter = NewsPresenter(newsService: GeneralDataService())
            (presenter as! NewsPresenter).atachView(view: self as ViewBuild)
            (presenter as! NewsPresenter).getNews(parameters: ["limit": limit as AnyObject, "offset" : offset as AnyObject, "post_id" : id as AnyObject ])
        }
        else {
            navigationItem.title = "Лента подписок"
            presenter = SubNewsPresenter(newsService: GeneralDataService())
            (presenter as! SubNewsPresenter).atachView(view: self as ViewBuild)
            (presenter as! SubNewsPresenter).getNews(parameters: ["limit": limit as AnyObject, "offset" : offset as AnyObject, "post_id" : id as AnyObject ])
        }
                        
        self.view.addSubview(collectionView)                
        setCollectionView()
        collectionView.reloadData()                
    }    

    func setCollectionView() {
        collectionView.register(NewsCell.self, forCellWithReuseIdentifier: "NewsCell")
        collectionView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    }    
}


extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsToDisplay.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as! NewsCell
        let newsViewData : NewsViewData = newsToDisplay[indexPath.row]
        
        cell.title.text = newsViewData.title
        cell.short.text = newsViewData.short
        cell.fultext.text = newsViewData.text
        cell.date.text = newsViewData.date
        cell.setLoginAndDate(newsViewData.login, newsViewData.date)
        cell.setViewsText(newsViewData.views)
        cell.images = newsViewData.images
        cell.docs = newsViewData.docs
        cell.audio = newsViewData.audio
        cell.video = newsViewData.video
        cell.user_mark = newsViewData.user_mark
        cell.mark.text = "\(newsViewData.mark)"
        cell.postId = newsViewData.postId
        cell.userId = newsViewData.userId
        cell.controller = self
        cell.setConstraints()        
        
        if newsViewData.images.count == 0 {
            cell.img.image = UIImage()
        } 
        else {                        
            cell.img.loadImageUsingCacheWithUrlString(APICallManager.instanse.API_BASE_URL + newsViewData.images[0], nil, cell.spinner)                        
        }                    
        
        
        if indexPath.row == newsToDisplay.count-1 {
            offset += 20
            print(" \(limit) <limit == offset> \(offset)")
            if (isNews) {
                (presenter as! NewsPresenter).getNews(parameters: ["limit": limit as AnyObject, "offset" : offset as AnyObject, "post_id" : Profile.shared.id as AnyObject ])
            }
            else {
                (presenter as! SubNewsPresenter).getNews(parameters: ["limit": limit as AnyObject, "offset" : offset as AnyObject, "post_id" : Profile.shared.id as AnyObject ])
            }
        }
            return cell
    }
        
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let newsViewData : NewsViewData = newsToDisplay[indexPath.row]
        
        let titleH = NSString(string: newsViewData.title).boundingRect(with: CGSize(width: collectionView.frame.width, height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin), attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15)], context: nil)
        let shortH = NSString(string: newsViewData.short).boundingRect(with: CGSize(width: collectionView.frame.width, height: 4000), options: NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin), attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
        
        // 44=profileImg, 300=img, 40=MarksViews, 40=extraSpace
        // V:|-8-[v0(44)]-4-[v1]-4-[v2]-4-[v3(300)]-8-[v4(1)]-(-2)-[v5(40)]|
        if (newsViewData.images.count > 0) {
            return CGSize(width: collectionView.frame.width, height: 8 + 44 + 4 + titleH.height + 4 + shortH.height + 4 + 300 + 8 + 1 + 40)
        }
        
        // V:|-8-[v0(44)]-4-[v1]-4-[v2]-8-[v3(1)]-(-2)-[v4(40)]|
        return CGSize(width: collectionView.frame.width, height: 8 + 44 + 4 + titleH.height + 4 + shortH.height + 8 + 1 + 40)
    }    
    
    @objc(collectionView:didSelectItemAtIndexPath:) func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "newsSegue", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! CurrentNewsViewController
        let index = sender as! Int
        controller.newsViewDisplay = [newsToDisplay[index]]
    }
}
extension ViewController : ViewBuild  {

    internal func setData(data: [ViewData]) {
        newsToDisplay.append(contentsOf: data as! [NewsViewData])
        collectionView.isHidden = false
        collectionView.reloadData()
    }
    
    internal func setEmptyData() {
        collectionView.isHidden = true
    }
    internal func startLoading() {
        // Show your loader
        print("Show your loader")
        activityIndicator.startAnimating()
    }
    
    internal func finishLoading() {
        // Dismiss your loader
        activityIndicator.stopAnimating()
    }
}


