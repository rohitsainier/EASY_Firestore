//
//  CreateGroup.swift
//  EASY
//
//  Created by Rohit Saini on 01/02/19.
//  Copyright © 2019 Rohit Saini. All rights reserved.
//

import UIKit

class CreateGroup: UIViewController {

    
    @IBOutlet weak var groupTxt: TextField!
    @IBOutlet weak var groupImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        customization()
       

        // Do any additional setup after loading the view.
    }
    
    
    private func customization(){
        groupImage.roundCorners([.topLeft, .bottomLeft], radius: 20)
        groupTxt.roundCorners([.topRight, .bottomRight], radius: 20)
        groupTxt.layer.borderColor = colorFromHex(hex: "0072A4").cgColor
        groupTxt.layer.borderWidth = 2
    }
    
    @IBAction func clickBackBtn(_ sender: UIButton) {
        NAVIGATION.BackToPreviousController()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
