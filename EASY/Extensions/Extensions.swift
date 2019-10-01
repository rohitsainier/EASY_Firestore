//
//  Extensions.swift
//  EASY
//
//  Created by Rohit Saini on 13/01/19.
//  Copyright © 2019 Rohit Saini. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage


enum MessageType {
    case photo
    case text
    case location
}

enum MessageOwner {
    case sender
    case receiver
}
//MARK:
//MARK:- NSMutableAttributedString Extension
extension NSMutableAttributedString {
    func setColorForText(textToFind: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textToFind, options: .caseInsensitive)
        if range != nil {
            self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }
    }
    
}


//MARK:- Color function
func colorFromHex(hex : String) -> UIColor
{
    return colorWithHexString(hex, alpha: 1.0)
}

func colorFromHex(hex : String, alpha:CGFloat) -> UIColor
{
    return colorWithHexString(hex, alpha: alpha)
}

func colorWithHexString(_ stringToConvert:String, alpha:CGFloat) -> UIColor {
    
    var cString:String = stringToConvert.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: alpha
    )
}


//MARK:- UITextField Extension
extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}


extension UIImageView
{
    func circleCorner(){
        self.layer.cornerRadius = self.layer.frame.size.height / 2
        self.layer.masksToBounds = true
    }
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFill) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
    func downloadCachedImage(placeholder: String,urlString: String){
        self.sainiShowLoader(loaderColor: #colorLiteral(red: 0.06274509804, green: 0.1058823529, blue: 0.2235294118, alpha: 1))
        let options: SDWebImageOptions = [.scaleDownLargeImages, .continueInBackground, .avoidAutoSetImage]
        let placeholder = UIImage(named: placeholder)
        self.sd_setImage(with: URL(string: urlString), placeholderImage: placeholder, options: options) { (image, _, cacheType, _) in
            self.sainiRemoveLoader()
            guard image != nil else {
                self.sainiRemoveLoader()
                return
            }
            guard cacheType != .memory, cacheType != .disk else {
                self.image = image
                self.sainiRemoveLoader()
                return
            }
            UIView.transition(with: self, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.sainiRemoveLoader()
                self.image = image
                return
            }, completion: nil)
        }
    }
    
}



extension UIViewController {
    
    static var top: UIViewController? {
        get {
            return topViewController()
        }
    }
    
    static var root: UIViewController? {
        get {
            return UIApplication.shared.delegate?.window??.rootViewController
        }
    }
    
    static func topViewController(from viewController: UIViewController? = UIViewController.root) -> UIViewController? {
        if let tabBarViewController = viewController as? UITabBarController {
            return topViewController(from: tabBarViewController.selectedViewController)
        } else if let navigationController = viewController as? UINavigationController {
            return topViewController(from: navigationController.visibleViewController)
        } else if let presentedViewController = viewController?.presentedViewController {
            return topViewController(from: presentedViewController)
        } else {
            return viewController
        }
    }
    
}
extension UIView{
//MARK:- sainiShowLoader
  func sainiShowLoader(loaderColor: UIColor, backgroundColor: UIColor = UIColor.clear) {
      let backgroundView = UIView()
      backgroundView.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
      backgroundView.backgroundColor = backgroundColor
      backgroundView.tag = 475647
      let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
      activityIndicator.center = backgroundView.center
      activityIndicator.hidesWhenStopped = true
    if #available(iOS 13.0, *) {
        activityIndicator.style = .large
    } else {
        // Fallback on earlier versions
        activityIndicator.style = .white
    }
      activityIndicator.color = loaderColor
      activityIndicator.startAnimating()
      //self.isUserInteractionEnabled = false
      backgroundView.addSubview(activityIndicator)
      self.addSubview(backgroundView)
  }
  
  //MARK:- sainiRemoveLoader
  func sainiRemoveLoader() {
      if let background = viewWithTag(475647){
          background.removeFromSuperview()
      }
      //self.isUserInteractionEnabled = true
  }
}

