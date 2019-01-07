//
//  ViewController.swift
//  EASY
//
//  Created by Rohit Saini on 06/01/19.
//  Copyright © 2019 Rohit Saini. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    var db: Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // [START setup]
        let settings = FirestoreSettings()
        settings.areTimestampsInSnapshotsEnabled = true
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        addDataTOFireStore()//adding Data to Cloud Firestore
        
    }
    
    private func addDataTOFireStore(){
        var ref: DocumentReference? = nil
        ref = db.collection("users").addDocument(data: [
            "first": "Ada",
            "last": "Lovelace",
            "born": 1815
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }


}

