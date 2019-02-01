//
//  LoginVC.swift
//  EASY
//
//  Created by Rohit Saini on 13/01/19.
//  Copyright © 2019 Rohit Saini. All rights reserved.
//


import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var forgotBtn: UIButton!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var loginBtnLbl: UIButton!
    @IBOutlet weak var signUpLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customization()
        animationSetup()
        
        // Do any additional setup after loading the view.
    }
    
    
    //MARK:- animationSetup
    func animationSetup(){
        UIView.animate(withDuration: 0.5, animations: {
            self.emailTxt.alpha = 1
        }) { (true) in
            UIView.animate(withDuration: 0.5, animations: {
                self.passwordTxt.alpha = 1
            }, completion: { (true) in
                UIView.animate(withDuration: 0.5, animations: {
                    self.forgotBtn.alpha = 1
                }, completion: { (true) in
                    UIView.animate(withDuration: 0.5, animations: {
                        self.loginBtnLbl.alpha = 1
                    }, completion: { (true) in
                        UIView.animate(withDuration: 0.5, animations: {
                            self.signUpLbl.alpha = 1
                        })
                    })
                })
            })
        }
    }
    
    //MARK:- customization
    func customization(){
        emailTxt.alpha = 0
        passwordTxt.alpha = 0
        forgotBtn.alpha = 0
        loginBtnLbl.alpha = 0
        signUpLbl.alpha = 0
        signUpCustomization()
        loginBtnCustomization()
        addGestureToSignUpLbl()
    }
    
    //MARK:- METHODS
    //MARK:- SignUp Label Customization
    func signUpCustomization(){
        let signUpStr : NSMutableAttributedString = NSMutableAttributedString(string: "Don't have an account? Sign-up")
        signUpStr.setColorForText(textToFind: "Sign-up", withColor: UIColor.orange)
        signUpLbl.attributedText = signUpStr
    }
    
    //MARK:- Login Button Customization
    func loginBtnCustomization(){
        loginBtnLbl.layer.cornerRadius = loginBtnLbl.frame.height / 2
        loginBtnLbl.layer.masksToBounds = true
    }
    
    //MARK:- Adding Gesture to signup Label
    func addGestureToSignUpLbl(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(navigateToRegister))
        signUpLbl.isUserInteractionEnabled = true
        signUpLbl.addGestureRecognizer(gesture)
        
    }
    
    //MARK:- navigateToRegister
    @objc func navigateToRegister(){
        let vc : Register = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "Register") as! Register
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //MARK:- Login
    @IBAction func clickLoginBtn(_ sender: UIButton) {
        login()
    }
    //MARK:- Forgot Password
    @IBAction func clickForgotBtn(_ sender: UIButton) {
        
    }
    
    //MARK:- Login
    func login(){
        User.loginUser(email: emailTxt.text!, password: passwordTxt.text!, loginHandler: {(Loginhandler) in
            if Loginhandler == nil{
                print("Logged in")
                AppDelegate().sharedDelegate().navigateToDashboard()


            }else{
                showAlertwithTitle(title: "Error", desc: Loginhandler!, vc: self)
            }
        })
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
