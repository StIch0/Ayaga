//
//  Extensions.swift
//  gameofchats
//
//  Created by Brian Voong on 7/5/16.
//  Copyright © 2016 letsbuildthatapp. All rights reserved.
//

import UIKit
import IQMediaPickerController

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
    
    func generateThumbImage(url : URL) -> UIImage?{        
//        let asset = AVAsset(url: url)
//        let assetImgGenerate : AVAssetImageGenerator = AVAssetImageGenerator(asset: asset)
//        assetImgGenerate.appliesPreferredTrackTransform = true
//        let time = CMTimeMake(1, 30)
//        let img = try? assetImgGenerate.copyCGImage(at: time, actualTime: nil)
//        
//        guard let cgImage = img else { return nil }
//        
//        let frameImg    = UIImage(cgImage: cgImage)
//        return frameImg
        
        return UIImage()
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

extension UIViewController {
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false            
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
