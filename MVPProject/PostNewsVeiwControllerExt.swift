//
//  PostNewsVeiwControllerExt.swift
//  MVPProject
//
//  Created by Dugar Badagarov on 07/04/2018.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation

extension PostNewsViewController
{
    func setView()
    {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)  
        
        scrollView.bringSubview(toFront: contentView)
        
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = true
        
        titleTextView .backgroundColor = .red
        shortTextView .backgroundColor = .gray
        fullTextView  .backgroundColor = .blue
        collectionView.backgroundColor = .green
        
        view.addConstraintsWithForamt(format: "H:|[v0]|", views: scrollView)
        view.addConstraintsWithForamt(format: "V:|[v0]|", views: scrollView)
        scrollView.addConstraintsWithForamt(format: "H:|[v0]|", views: contentView)
        scrollView.addConstraintsWithForamt(format: "V:|[v0]|", views: contentView)
        
        contentViewHeightAnchor = contentView.heightAnchor.constraint(equalToConstant: 1000)
        
        
                contentView.addSubview(titleTextView )
                contentView.addSubview(shortTextView )
                contentView.addSubview(fullTextView  )
                contentView.addSubview(collectionView)  
        
        
        titleTextViewHeightAnchor  = titleTextView .heightAnchor.constraint(equalToConstant: 30) 
        shortTextViewHeightAnchor  = shortTextView .heightAnchor.constraint(equalToConstant: 30) 
        fullTextViewHeightAnchor   = fullTextView  .heightAnchor.constraint(equalToConstant: 30)
        collectionView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        titleTextViewHeightAnchor .isActive = true
        shortTextViewHeightAnchor .isActive = true
        fullTextViewHeightAnchor  .isActive = true
        
        
        titleTextView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        titleTextView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        titleTextView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
//        titleTextView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
    }
}
