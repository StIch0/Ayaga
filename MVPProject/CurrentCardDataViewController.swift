//
//  CurrentCardDataViewController.swift
//  MVPProject
//
//  Created by Pavel Burdukovskii on 29/01/18.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import UIKit

class CurrentCardDataViewController: UIViewController {
    var currentDataCardViewData = [CurrentCardViewData]()
    
    let scrollView = UIScrollView()
    let titleView = UITextView()
    let textView = UITextView()
    let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    
    var images = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("currentDataCardViewData",currentDataCardViewData)
        images = currentDataCardViewData[0].images
        
        view.addSubview(scrollView)
        view.addConstraintsWithForamt(format: "H:|[v0]|", views: scrollView)
        view.addConstraintsWithForamt(format: "V:|[v0]|", views: scrollView)
        
        titleView.text = currentDataCardViewData[0].title
        textView.text = currentDataCardViewData[0].textCard
        
        titleView.font = UIFont.boldSystemFont(ofSize: 15)
        textView.font = UIFont.systemFont(ofSize: 13)
        
        let titleH = NSString(string: titleView.text).boundingRect(with: CGSize(width: view.frame.width, height: 5000), options: NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin), attributes: [NSFontAttributeName:titleView.font!], context: nil).height + 20
        
        let textH = NSString(string: textView.text).boundingRect(with: CGSize(width: view.frame.width, height: 5000), options: NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin), attributes: [NSFontAttributeName:textView.font!], context: nil).height + 20
        
        scrollView.alwaysBounceVertical = true
        
        scrollView.addSubview(titleView)
        scrollView.addSubview(textView)
        scrollView.addSubview(collectionView)        
        
        titleView.backgroundColor = .clear
        textView.backgroundColor = .clear
        collectionView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        titleView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8).isActive = true
        titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleView.widthAnchor.constraint(equalToConstant: view.frame.width - 16).isActive = true
        titleView.heightAnchor.constraint(equalToConstant: titleH).isActive = true
        
        textView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 8).isActive = true
        textView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textView.widthAnchor.constraint(equalTo: titleView.widthAnchor).isActive = true
        textView.heightAnchor.constraint(equalToConstant: textH).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 8).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -8).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 400).isActive = true
                        
        setCollectionView()
    }        
    
    func setCollectionView()
    {        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(imgCell.self, forCellWithReuseIdentifier: "imgCell")
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width, height: 400)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        
        collectionView.collectionViewLayout = layout
        
        collectionView.isPagingEnabled = true
        collectionView.reloadData()
    }
}

extension CurrentCardDataViewController : UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imgCell", for: indexPath) as! imgCell
        
        cell.img.loadImageUsingCacheWithUrlString(APICallManager.instanse.API_BASE_URL + images[indexPath.row], nil, UIActivityIndicatorView())
        
        return cell
    }
}
