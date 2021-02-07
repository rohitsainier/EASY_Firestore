//
//  Group.swift
//  EASY
//
//  Created by Rohit Saini on 01/02/19.
//  Copyright © 2019 Rohit Saini. All rights reserved.
//

import Foundation
import UIKit
import Firebase


//=======================
//MARK:- GROUP
//=======================
class Group {
    //MARK: Properties
    let name: String?
    var picture: UIImage?
    
    //MARK: Inits
    init(name: String,picture: UIImage) {
        self.name = name
        self.picture = picture
    }
    
    
    //============================
    //MARK:- Create Group
    //============================
    class func CreateGroup(name: String,picture: UIImage,completion: @escaping () -> Swift.Void){
        // [START setup]
        let settings = FirestoreSettings()
        settings.areTimestampsInSnapshotsEnabled = true
        Firestore.firestore().settings = settings
        // [END setup]
        showLoader()
        db = Firestore.firestore()
        let storageRef = Storage.storage().reference().child("GroupPicturs").child("\(Date().timeIntervalSinceNow).jpg")
        let imageData = picture.jpegData(compressionQuality: 0.5)// UIImageJPEGRepresentation(profilePic, 0.1)//swift 3 version
        storageRef.putData(imageData!, metadata: nil, completion: { (metadata, err) in
            if err == nil {
                storageRef.downloadURL(completion: { (url, error) in
                    if error == nil{
                        guard let path = url?.absoluteString else{
                            return
                        }
                        let values: [String: Any] = ["name": name,"groupPicLink": path]
                        let info : [String: Any] = ["info":values]
                        var ref: DocumentReference? = nil
                        
                        ref = db.collection("GROUP").document()
                        ref?.setData(info)
                        { error in
                            if let err = error {
                                print("Error updating document: \(err)")
                                removeLoader()
                                
                                
                            } else {
                                removeLoader()
                                
                                print("Document successfully updated")
                            }
                            
                            
                        }
                    }
                })
            }
        })
        
    }
    
    
    
    //============================
    //MARK:- Download Users
    //============================
    
    class func GroupList(completion: @escaping (Group) -> Swift.Void) {
        // [START setup]
        let settings = FirestoreSettings()
        settings.areTimestampsInSnapshotsEnabled = true
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        db.collection("GROUP")
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        
                        let data = document.data()
                        
                        guard let info = data["info"] as? [String: Any] else{
                            return
                        }
                        
                        let name = info["name"]!
                        
                        let link = URL.init(string: info["groupPicLink"]! as! String)
                        URLSession.shared.dataTask(with: link!, completionHandler: { (data, response, error) in
                            if error == nil {
                                let groupPic = UIImage.init(data: data!)
                                let group = Group.init(name: name as! String, picture: groupPic ?? UIImage(named: "user_avatar")!)
                                completion(group)
                            }
                        }).resume()
                        
                    }
                }
        }
    }
}
