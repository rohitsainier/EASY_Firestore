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
    
    @IBOutlet weak var live_Or_Not: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        live_Or_Not.layer.cornerRadius = live_Or_Not.frame.height / 2
        live_Or_Not.layer.masksToBounds = true
        
        // [START setup]
        let settings = FirestoreSettings()
        settings.areTimestampsInSnapshotsEnabled = true
        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        updateGameStatus()
    }
    
    //MARK:- updateGameStatus
    private func updateGameStatus(){
        var ref: DocumentReference? = nil
        ref = db.collection("GAME").document("LIVEFEED")
        ref?.addSnapshotListener({ (snapshot, Err) in
            guard let document = snapshot else {
                print("Error fetching document: \(Err!)")
                return
            }
            guard let data = document.data() else {
                print("Document data was empty.")
                return
            }
            print("Current data: \(data)")
            if data["live"] as? Bool == true{
                self.live_Or_Not.backgroundColor = UIColor.red
            }
            else{
                self.live_Or_Not.backgroundColor = UIColor.lightGray
            }
        })
        
    }
    
   
    @IBAction func goLiveBtnClicked(_ sender: UIButton) {
        goLive()
    }
    
    @IBAction func goOfflineBtnClicked(_ sender: UIButton) {
        goOffline()
    }
    
    //MARK:- goLive
    private func goLive(){
        var ref: DocumentReference? = nil
        ref = db.collection("GAME").document("LIVEFEED")
        ref?.setData(["live" : true])
        { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                
                print("Document successfully updated")
            }
        }
    }
    
    //MARK:- goOffline
    private func goOffline(){
        var ref: DocumentReference? = nil
        ref = db.collection("GAME").document("LIVEFEED")
        ref?.setData(["live" : false])
        { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
            }
        }
    }

    
}

