//
//  CreatePost.swift
//  EASY
//
//  Created by Rohit Saini on 01/10/19.
//  Copyright © 2019 Rohit Saini. All rights reserved.
//

import UIKit

class CreatePost: UIViewController {

    @IBOutlet weak var galleryTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var cameraBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var cameraTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var galleryBtn: UIButton!
    @IBOutlet weak var camerabtn: UIButton!
    @IBOutlet weak var profilePic: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        customization()

        // Do any additional setup after loading the view.
    }
    
    private func customization(){
        profilePic.layer.cornerRadius = profilePic.frame.height / 2
        profilePic.layer.masksToBounds = true
        profilePic.layer.borderWidth = 1
        profilePic.layer.borderColor = UIColor.white.cgColor
        camerabtn.alpha = 0
        galleryBtn.alpha = 0
    }
    
    @IBAction func clickAddBtn(_ sender: UIButton) {
        if sender.currentTitle == "✛"{
            sender.setTitle("✘", for: UIControl.State.normal)
            UIView.animate(withDuration: 0.1, animations: {
                self.camerabtn.alpha = 1
                self.cameraTrailingConstraint.constant = 60
                self.cameraBottomConstraint.constant = 40
               
            }) { (success) in
                if success{
                    UIView.animate(withDuration: 0.1) {
                        self.galleryBtn.alpha = 1
                        self.galleryTrailingConstraint.constant = 50
                        
                    }
                }
            }
        }
        else{
            sender.setTitle("✛", for: UIControl.State.normal)
            UIView.animate(withDuration: 0, animations: {
                self.galleryBtn.alpha = 0
                self.cameraTrailingConstraint.constant = 20
                self.cameraBottomConstraint.constant = -50
            }) { (success) in
                if success{
                    UIView.animate(withDuration: 0) {
                        self.camerabtn.alpha = 0
                        self.galleryTrailingConstraint.constant = -50
                    }
                }
            }
        }
        
    }
    
    
    @IBAction func clickPostBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func clickCrossBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)

    }
    
    
    @IBAction func clickCameraBtn(_ sender: UIButton) {
    }
    
    
    @IBAction func clickGalleryBtn(_ sender: UIButton) {
    }
    
    
    
    @IBAction func clickCategoryBtn(_ sender: UIButton) {
    }
    
    
    deinit{
       print("Create Post Controller Deinit from memory")
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
