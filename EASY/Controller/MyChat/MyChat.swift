//
//  MyChat.swift
//  EASY
//
//  Created by Rohit Saini on 15/01/19.
//  Copyright © 2019 Rohit Saini. All rights reserved.
//

import UIKit

class MyChat: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var noDataLbl: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    private var selectedIndex = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        noDataLbl.text = "You have no messages yet."
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.register(UINib.init(nibName: "MyChatCell", bundle: nil), forCellReuseIdentifier: "MyChatCell")
        User.downloadAllUsers(exceptID: "fbsjfjsfhs") { (user) in
            print(user)
        }
        // Do any additional setup after loading the view.
    }
    

    //MARK: TableView DataSource
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyChatCell") as? MyChatCell else {
            return UITableViewCell()
        }
        if selectedIndex == 1 {
            cell.chatUserName.text = "Dummy"
            cell.ImageView.image = UIImage()
            
            return cell
        }
        else{
            cell.chatUserName.text = "DummyReq"
            cell.ImageView.image = UIImage()
            
            return cell
        }
        
    }
    
    
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex
        {
        case 0:
            noDataLbl.text = "You have no messages yet."
            break
           
        case 1:
            noDataLbl.text = "You haven't received any friend request yet."
            break
            
        default:
            break
        }
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
