//
//  Extensions.swift
//  gameofchats
//
//  Created by Brian Voong on 7/5/16.
//  Copyright © 2016 letsbuildthatapp. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    
    func loadImageUsingCacheWithUrlString(_ urlString: String, _ heightAnchor: NSLayoutDimension? = nil, _ spinner: UIActivityIndicatorView) {
        self.image = nil
        
        //check cache for image first
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = cachedImage
            return
        }
        
        //otherwise fire off a new download
        let url = URL(string: urlString)        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            //download hit an error so lets return out
            if let error = error {
                print(error)
                return
            }
            
            DispatchQueue.main.async(execute: {
                
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as NSString)                    
                    spinner.hidesWhenStopped = true
                    spinner.stopAnimating()
                    self.image = downloadedImage                    
                }
            })
            
        }).resume()
    }
    
}

extension UIView
{
    func addConstraintsWithForamt (format: String, views: UIView ...) {
        var viewsDict = [String: UIView]();
        
        for (ind, view) in views.enumerated() {
            let key = "v\(ind)"
            viewsDict[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDict))
    }
}

extension UIColor
{
    static func rgb(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alph: CGFloat = 1) -> UIColor
    {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alph)
    }
}
