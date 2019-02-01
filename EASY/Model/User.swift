//
//  User.swift
//  EASY
//
//  Created by Rohit Saini on 14/01/19.
//  Copyright © 2019 Rohit Saini. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
//import FirebaseStorage
import CoreLocation

typealias Loginhandler = (_ msg:String?) -> Void //closure
var db: Firestore!

//=======================
//MARK:- USER
//=======================
class User: NSObject {
    
    //MARK: Properties
    let name: String
    let email: String
    let id: String
    var profilePic: UIImage
    var latitude: Any
    var longitude: Any
    
    //MARK: Inits
    init(name: String, email: String, id: String, profilePic: UIImage,latitude: Any,longitude: Any) {
        self.name = name
        self.email = email
        self.id = id
        self.profilePic = profilePic
        self.longitude = longitude
        self.latitude = latitude
    }
    
    
    struct loginErrorCode {
        static let INVALID_EMAIL = "Invalid Email"
        static let UNVERIFIED_PHONENUMBER = "Mobile number is not Verified"
        static let WRONG_PASSWORD = "Wrong Password"
        static let PROBLEM_CONNECTING = "Problem Connecting to Databases "
        static let USER_NOT_FOUND = "User Not Found"
        static let EMAIL_ALREADY_USED = "Email Already used Try Another One"
        static let WEAK_PASSWORD = "Password should be alteast 6 characters long"
        static let SOMETHING_WENT_WRONG = "Something went wrong try Again"
        static let INVALID_CUSTOM_TOKEN = "Validation error with the custom token."
        static let CUSTOM_TOKEN_MISMATCH = "Service account and the API key belong to different projects."
        static let INVALID_CREDENTIAL = "Supplied credential is invalid. This could happen if it has expired or it is malformed."
        static let USER_DISABLE = "User's account is disabled."
        static let OPERATION_NOT_ALLOWED = "Email and password accounts are not enabled. Enable them in the Auth section of the Firebase console."
        static let TOO_MANY_REQUESTS = "Request has been blocked after an abnormal number of requests have been made from the caller device to the Firebase Authentication servers. Retry again after some time."
        static let ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL = "This account is already present with different credential"
        static let REQUIRES_RECENT_LOGIN = "Updating a user’s email is a security sensitive operation that requires a recent login from the user. This error indicates the user has not signed in recently enough. To resolve, reauthenticate the user by invoking reauthenticateWithCredential:completion: on FIRUser."
        static let PROVIDER_ALREADY_LINKED  = "Attempt to link a provider of a type already linked to this account."
        static let NO_SUCH_PROVIDER = "Attempt to unlink a provider that is not linked to the account."
        static let INVALID_USER_TOKEN = "The signed-in user's refresh token, that holds session information, is invalid. You must prompt the user to sign in again on this device."
        static let NETWORK_ERROR = "Network error occurred during the operation"
        static let USER_TOKEN_EXPIRED = "The current user’s token has expired, for example, the user may have changed account password on another device. You must prompt the user to sign in again on this device."
        static let INVALID_API_KEY = "Application has been configured with an invalid API key."
        static let USER_MISMATCH = "An attempt was made to reauthenticate with a user which is not the current user."
        static let CREDENTIAL_ALREADY_IN_USE = "An attempt to link with a credential that has already been linked with a different Firebase account."
        static let APP_NOT_AUTHORIZED = "App is not authorized to use Firebase Authentication with the provided API Key. go to the Google API Console and check under the credentials tab that the API key you are using has your application’s bundle ID whitelisted."
        static let EXPIRED_ACTION_CODE = "Action code is Expired"
        static let INVALID_ACTION_CODE = "Action code is Invalid"
        static let INVALID_MESSAGE_PAYLOAD = "Message payload is not valid"
        static let INVALID_SENDER = "Sender is not valid"
        static let INVALID_RECIPIENT_EMAIL = "Recipient mail is not valid"
        static let KEYCHAIN_ERROR = "Error in keychain"
        static let INTERNAL_ERROR = "Some internal Error"
        
    }//errorCodes
    
    //=============================
    //MARK:- handleErrors
    //=============================
    class func handleErrors(err: NSError ,loginHandler:Loginhandler){
        
        if let errCode = AuthErrorCode(rawValue: err.code){
            
            switch errCode{
            case .userNotFound:
                loginHandler(loginErrorCode.USER_NOT_FOUND)
                break
            case .invalidEmail:
                loginHandler(loginErrorCode.INVALID_EMAIL)
                break
            case .invalidCustomToken:
                loginHandler(loginErrorCode.INVALID_CUSTOM_TOKEN)
                break
            case .customTokenMismatch:
                loginHandler(loginErrorCode.CUSTOM_TOKEN_MISMATCH)
                break
            case .invalidCredential:
                loginHandler(loginErrorCode.INVALID_CREDENTIAL)
                break
            case .userDisabled:
                loginHandler(loginErrorCode.USER_DISABLE)
                break
            case .operationNotAllowed:
                loginHandler(loginErrorCode.OPERATION_NOT_ALLOWED)
                break
            case .emailAlreadyInUse:
                loginHandler(loginErrorCode.EMAIL_ALREADY_USED)
                break
            case .wrongPassword:
                loginHandler(loginErrorCode.WRONG_PASSWORD)
                break
            case .tooManyRequests:
                loginHandler(loginErrorCode.TOO_MANY_REQUESTS)
                break
            case .accountExistsWithDifferentCredential:
                loginHandler(loginErrorCode.ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL)
                break
            case .requiresRecentLogin:
                loginHandler(loginErrorCode.REQUIRES_RECENT_LOGIN)
                break
            case .providerAlreadyLinked:
                loginHandler(loginErrorCode.PROVIDER_ALREADY_LINKED)
                break
            case .noSuchProvider:
                loginHandler(loginErrorCode.NO_SUCH_PROVIDER)
                break
            case .invalidUserToken:
                loginHandler(loginErrorCode.INVALID_USER_TOKEN)
                break
            case .networkError:
                loginHandler(loginErrorCode.NETWORK_ERROR)
                break
            case .userTokenExpired:
                loginHandler(loginErrorCode.USER_TOKEN_EXPIRED)
                break
            case .invalidAPIKey:
                loginHandler(loginErrorCode.INVALID_API_KEY)
                break
            case .userMismatch:
                loginHandler(loginErrorCode.USER_MISMATCH)
                break
            case .credentialAlreadyInUse:
                loginHandler(loginErrorCode.CREDENTIAL_ALREADY_IN_USE)
                break
            case .weakPassword:
                loginHandler(loginErrorCode.WEAK_PASSWORD)
                break
            case .appNotAuthorized:
                loginHandler(loginErrorCode.APP_NOT_AUTHORIZED)
                break
            case .expiredActionCode:
                loginHandler(loginErrorCode.EXPIRED_ACTION_CODE)
                break
            case .invalidActionCode:
                loginHandler(loginErrorCode.INVALID_ACTION_CODE)
                break
            case .invalidMessagePayload:
                loginHandler(loginErrorCode.INVALID_MESSAGE_PAYLOAD)
                break
            case .invalidSender:
                loginHandler(loginErrorCode.INVALID_SENDER)
                break
            case .invalidRecipientEmail:
                loginHandler(loginErrorCode.INVALID_RECIPIENT_EMAIL)
                break
            case .keychainError:
                loginHandler(loginErrorCode.KEYCHAIN_ERROR)
                break
            case .internalError:
                loginHandler(loginErrorCode.INTERNAL_ERROR)
                break
            default:
                loginHandler(loginErrorCode.SOMETHING_WENT_WRONG)
                break
            }
            
        }
    }
    //END error handler
    
    
    //====================================
    //MARK:- registerUser
    //====================================
    class func registerUser(withName:String,email:String,password:String,phoneNumber: String ,profilePic:UIImage,location: Dictionary<String, Any>,loginHandler: Loginhandler?){
        // [START setup]
        let settings = FirestoreSettings()
        settings.areTimestampsInSnapshotsEnabled = true
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        showLoader()
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error == nil{
                
                user?.user.sendEmailVerification(completion: { (error) in
                    if error == nil{
                        let storageRef = Storage.storage().reference().child("usersProfilePics").child("\((user?.user.uid)!).jpg")
                        let imageData = profilePic.jpegData(compressionQuality: 0.5)// UIImageJPEGRepresentation(profilePic, 0.1)//swift 3 version
                        storageRef.putData(imageData!, metadata: nil, completion: { (metadata, err) in
                            if err == nil {
                                storageRef.downloadURL(completion: { (url, error) in
                                    if error == nil{
                                        guard let path = url?.absoluteString else{
                                            return
                                        }
                                        let values: [String: Any] = ["name": withName, "email": email, "profilePicLink": path,"phoneNumber":phoneNumber,"location":location]
                                        let credentials : [String: Any] = ["credentials":values]
                                        var ref: DocumentReference? = nil
                                        
                                        ref = db.collection("USER").document((user?.user.uid)!)
                                        ref?.setData(credentials)
                                        { error in
                                            if let err = error {
                                                print("Error updating document: \(err)")
                                                removeLoader()
                                                self.handleErrors(err: error! as NSError, loginHandler: loginHandler!)
                                                
                                            } else {
                                                removeLoader()
                                                loginHandler!(nil)
                                                print("Document successfully updated")
                                            }
                                            
                                            
                                        }
                                    }else{
                                        removeLoader()
                                        self.handleErrors(err: error! as NSError, loginHandler: loginHandler!)
                                    }
                                })
                                
                            }
                        })
                    }
                    else{
                        removeLoader()
                        
                        self.handleErrors(err: error! as NSError, loginHandler: loginHandler!)
                    }
                })
                
            }
            else{
                removeLoader()
                
                self.handleErrors(err: error! as NSError, loginHandler: loginHandler!)
                
            }
            
        }
    }
    //END Register User
    
    
    //==============================
    //MARK:- loginUser
    //==============================
    class func loginUser(email: String, password: String, loginHandler: Loginhandler?) {
        showLoader()
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            UserDefaults.standard.set(user?.user.uid, forKey: "currentUser")
            if error == nil {
                guard let status = Auth.auth().currentUser?.isEmailVerified else{
                    return
                }
                if status == true{
                    removeLoader()
                    loginHandler!(nil)
                }else{
                    removeLoader()
                    loginHandler!("Email is not verified")
                }
                
                
            } else {
                removeLoader()
                self.handleErrors(err: error! as NSError, loginHandler: loginHandler!)
            }
        }
    }
    //END Login User
    
    //============================
    //MARK:- Download Users
    //============================
    
    class func downloadAllUsers(exceptID: String, completion: @escaping (User) -> Swift.Void) {
        // [START setup]
        let settings = FirestoreSettings()
        settings.areTimestampsInSnapshotsEnabled = true
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        db.collection("USER")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                       
                       let data = document.data()
                       let id = document.documentID
                        guard let credentials = data["credentials"] as? [String: Any] else{
                            return
                        }
                        if id != exceptID {
                            let name = credentials["name"]!
                            let email = credentials["email"]!
                            let location = credentials["location"] as! [String: Any]
                            let latitude = location["latitude"]
                            let longitude = location["longitude"]
                            let link = URL.init(string: credentials["profilePicLink"]! as! String)
                            URLSession.shared.dataTask(with: link!, completionHandler: { (data, response, error) in
                                if error == nil {
                                    let profilePic = UIImage.init(data: data!)
                                    let user = User.init(name: name as! String, email: email as! String, id: id, profilePic: profilePic!, latitude: latitude!, longitude: longitude!)
                                    completion(user)
                                }
                            }).resume()
                        }
                    }
                }
            }
}//Download all users
    
    
}
//END USER
