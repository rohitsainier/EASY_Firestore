//
//  Utility.swift
//  EASY
//
//  Created by Rohit Saini on 13/01/19.
//  Copyright © 2019 Rohit Saini. All rights reserved.
//

import Foundation
import Toaster


//MARK:- getCurrentTimeStampValue
func getCurrentTimeStampValue() -> String
{
    return String(format: "%0.0f", Date().timeIntervalSince1970*1000)
}
//MARK:- showLoader
func showLoader()
{
    AppDelegate().sharedDelegate().showLoader()
}
//MARK:- removeLoader
func removeLoader()
{
    AppDelegate().sharedDelegate().removeLoader()
}

//MARK:- Toast
func displayToast(_ message:String)
{
    let toast = Toast(text: NSLocalizedString(message, comment: ""))
    toast.show()
}

func showAlertwithTitle(title:String , desc:String , vc:UIViewController)  {
    let alert = UIAlertController(title: title, message: desc, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
    vc.present(alert, animated: true, completion: nil)
}

//Image Compression to 10th
func compressImage(image: UIImage) -> Data {
    // Reducing file size to a 10th
    
    var actualHeight : CGFloat = image.size.height
    var actualWidth : CGFloat = image.size.width
    let maxHeight : CGFloat = 1920.0
    let maxWidth : CGFloat = 1080.0
    var imgRatio : CGFloat = actualWidth/actualHeight
    let maxRatio : CGFloat = maxWidth/maxHeight
    var compressionQuality : CGFloat = 0.5
    
    if (actualHeight > maxHeight || actualWidth > maxWidth) {
        
        if (imgRatio < maxRatio) {
            
            //adjust width according to maxHeight
            imgRatio = maxHeight / actualHeight;
            actualWidth = imgRatio * actualWidth;
            actualHeight = maxHeight;
        } else if (imgRatio > maxRatio) {
            
            //adjust height according to maxWidth
            imgRatio = maxWidth / actualWidth;
            actualHeight = imgRatio * actualHeight;
            actualWidth = maxWidth;
            
        } else {
            
            actualHeight = maxHeight
            actualWidth = maxWidth
            compressionQuality = 1
        }
    }
    
    let rect = CGRect(x: 0.0, y: 0.0, width:actualWidth, height:actualHeight)
    UIGraphicsBeginImageContext(rect.size)
    image.draw(in: rect)
    let img = UIGraphicsGetImageFromCurrentImageContext()
    let imageData = img!.jpegData(compressionQuality: compressionQuality)
    UIGraphicsEndImageContext();
    
    return imageData!
}





