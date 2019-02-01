//
//  Register.swift
//  EASY
//
//  Created by Rohit Saini on 13/01/19.
//  Copyright © 2019 Rohit Saini. All rights reserved.
//


import UIKit

class Register: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {
    
    @IBOutlet weak var loginLbl: UILabel!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var mobileTxt: UITextField!
    fileprivate var currentVC: UIViewController!
    var position = ["latitude": 30,"longitude":70]
    override func viewDidLoad() {
        super.viewDidLoad()
        customization()
        animationSetup()
        // Do any additional setup after loading the view.
    }
    
  
    
    //MARK:- METHODS
    //MARK:- customization
    func customization(){
        nameTxt.alpha = 0
        emailTxt.alpha = 0
        passwordTxt.alpha = 0
        mobileTxt.alpha = 0
        registerBtn.alpha = 0
        loginLbl.alpha = 0
        profilePic.circleCorner()
        RegisterBtnCustomization()
        loginLblCustomization()
        addGestureToLoginLbl()
        profileTapGesture()
    }
    
    
    //MARK:- animationSetup
    func animationSetup(){
        UIView.animate(withDuration: 0.5, animations: {
            self.nameTxt.alpha = 1
        }) { (true) in
            UIView.animate(withDuration: 0.5, animations: {
            self.emailTxt.alpha = 1
            }, completion: { (true) in
                UIView.animate(withDuration: 0.5, animations: {
                    self.passwordTxt.alpha = 1
                }, completion: { (true) in
                    UIView.animate(withDuration: 0.5, animations: {
                        self.mobileTxt.alpha = 1
                    }, completion: { (true) in
                        UIView.animate(withDuration: 0.5, animations: {
                            self.registerBtn.alpha = 1
                        }, completion: { (true) in
                            UIView.animate(withDuration: 0.5, animations: {
                                self.loginLbl.alpha = 1
                            })
                        })
                    })
                })
            })
        }
    }
    
    //MARK:- Register Button Customization
    func RegisterBtnCustomization(){
        registerBtn.layer.cornerRadius = registerBtn.frame.height / 2
        registerBtn.layer.masksToBounds = true
    }
    
    //MARK:- SignUp Label Customization
    func loginLblCustomization(){
        let loginStr : NSMutableAttributedString = NSMutableAttributedString(string: "Already have an account? Login")
        loginStr.setColorForText(textToFind: "Login", withColor: UIColor.orange)
        loginLbl.attributedText = loginStr
    }
    
    
    //MARK:- Adding Gesture to signup Label
    func addGestureToLoginLbl(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(navigateToLogin))
        loginLbl.isUserInteractionEnabled = true
        loginLbl.addGestureRecognizer(gesture)
        
    }
    
    //MARK:- navigateToRegister
    @objc func navigateToLogin(){
        let vc : LoginVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //MARK:-
    //MARK:- IMAGE PICKER METHODS
    
    func profileTapGesture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        profilePic.isUserInteractionEnabled = true
        profilePic.addGestureRecognizer(tap)
        
    }//Tap on Profile image
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        uploadImage()
    }//Show action Sheet
    
    
    // MARK: - Upload Image
    @objc func uploadImage()
    {
        let actionSheet: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            print("Cancel")
        }
        actionSheet.addAction(cancelButton)
        
        let cameraButton = UIAlertAction(title: "Take Photo", style: .default)
        { _ in
            print("Camera")
            self.onCaptureImageThroughCamera()
        }
        
        
        actionSheet.addAction(cameraButton)
        
        
        
        let galleryButton = UIAlertAction(title: "Choose Existing Photo", style: .default)
        { _ in
            print("Gallery")
            self.onCaptureImageThroughGallery()
        }
        actionSheet.addAction(galleryButton)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @objc open func onCaptureImageThroughCamera()
    {
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            displayToast("Your device has no camera")
            
        }
        else {
            let imgPicker = UIImagePickerController()
            imgPicker.delegate = self
            imgPicker.sourceType = .camera
            imgPicker.allowsEditing = true
            UIViewController.top?.present(imgPicker, animated: true, completion: {() -> Void in
            })
        }
    }
    
    @objc open func onCaptureImageThroughGallery()
    {
        self.dismiss(animated: true, completion: nil)
        DispatchQueue.main.async {
            let imgPicker = UIImagePickerController()
            imgPicker.delegate = self
            imgPicker.sourceType = .photoLibrary
            imgPicker.allowsEditing = true
            UIViewController.top?.present(imgPicker, animated: true, completion: {() -> Void in
            })
        }
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: {() -> Void in
        })
        
        let selectedImage: UIImage? = (info[UIImagePickerController.InfoKey.editedImage] as! UIImage)
        if selectedImage == nil {
            return
        }
        
        self.profilePic.image = selectedImage
    }
    
    
    
    @IBAction func clickRegisterBtn(_ sender: UIButton) {
        register()
    }
    
    //MARK:- Register
    func register(){
        User.registerUser(withName: nameTxt.text!, email: emailTxt.text!, password: passwordTxt.text!, phoneNumber: "+91" + mobileTxt.text!, profilePic: profilePic.image ?? UIImage(), location: position, loginHandler: {(Loginhandler) in
            if Loginhandler == nil{
                let Login = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                let alert = UIAlertController(title: "Verification", message: "A verification mail has been sent to your registered mail id please verify the email.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (result) in
                    self.navigationController?.pushViewController(Login, animated: true)

                }))

                self.present(alert, animated: true, completion: nil)

            }else{
                showAlertwithTitle(title: "Error", desc: Loginhandler!, vc: self)
            }

        })
    }//Register
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
