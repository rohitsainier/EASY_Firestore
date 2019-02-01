//
//  Utility.swift
//  EASY
//
//  Created by Rohit Saini on 13/01/19.
//  Copyright © 2019 Rohit Saini. All rights reserved.
//

import Foundation
import Toaster

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




