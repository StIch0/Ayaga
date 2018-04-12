//
//  PostNewsViewController.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 24/01/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import UIKit

class PostNewsViewController: UIViewController {
    
    var presenter =  ResultPresenter(service: ResultServise())
    var viewData = [ResulViewData]()
    var activityIndicator = UIActivityIndicatorView()
        
    var scrollView = UIScrollView()
    var contentView = UIView()
    var titleTextView = UITextView()
    var shortTextView = UITextView()
    var fullTextView = UITextView()
    var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
    
    var contentViewHeightAnchor     = NSLayoutConstraint()
    var titleTextViewHeightAnchor   = NSLayoutConstraint()
    var shortTextViewHeightAnchor   = NSLayoutConstraint()
    var fullTextViewHeightAnchor    = NSLayoutConstraint()    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let reveal : SWRevealViewController? = revealViewController()        
        if reveal != nil {                        
            navigationItem.setLeftBarButtonItems([UIBarButtonItem(image: #imageLiteral(resourceName: "menu"), style: .plain, target: reveal, action: #selector(reveal?.revealToggle(_:)))], animated: true)            
            self.view.addGestureRecognizer((reveal?.panGestureRecognizer())!)
        }
        activityIndicator.hidesWhenStopped = true
//        presenter.atachView(resultView: self as ViewBuild)
//        presenter.getData(APISelected.AddPost.rawValue,
//                          parameters: ["title":"Ba_Dum_Tss_Cat" as AnyObject,
//                                       "short":"Ba_Dum_Tss_Cat SHORT" as AnyObject,
//                                    "text":"Ba_Dum_Tss_CatBa_Dum_Tss_CatBa_Dum_Tss_CatBa_Dum_Tss_CatBa_Dum_Tss_CatBa_Dum_Tss_CatBa_Dum_Tss_CatBa_Dum_Tss_CatBa_Dum_Tss_CatBa_Dum_Tss_CatBa_Dum_Tss_CatBa_Dum_Tss_CatBa_Dum_Tss_CatBa_Dum_Tss_CatBa_Dum_Tss_CatBa_Dum_Tss_CatBa_Dum_Tss_Cat" as AnyObject,
//                                       "date":"2018-01-31 14:59:34" as AnyObject,
//                                       "id":41 as AnyObject],
//                          withName: "images[]", imagesArr: [
//                            UIImage(named: "Ba_Dum_Tss_Cat")!],
//                          videoArr: [],
//                          audioArr: [],
//                          docsArr: [])
        
        setView()
        
    }

}
extension PostNewsViewController : ViewBuild {
    internal func setEmptyData() {
        self.view.isHidden = true
    }

    internal func setData(data: [ViewData]) {
        viewData = data as! [ResulViewData]
        print(viewData.first ?? "Error")
        self.view.isHidden = false

    }

    internal func finishLoading() {
        activityIndicator.stopAnimating()
    }

    internal func startLoading() {
        activityIndicator.startAnimating()
    }


}
