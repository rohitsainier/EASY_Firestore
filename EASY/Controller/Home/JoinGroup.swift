//
//  JoinGroup.swift
//  EASY
//
//  Created by Rohit Saini on 01/02/19.
//  Copyright © 2019 Rohit Saini. All rights reserved.
//

import UIKit

class JoinGroup: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    private var groupList: [Group] = [Group]()
    override func viewDidLoad() {
        super.viewDidLoad()
        getGroupListing()
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.register(UINib.init(nibName: "MyChatCell", bundle: nil), forCellReuseIdentifier: "MyChatCell")
       
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
       return groupList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyChatCell") as? MyChatCell else {
            return UITableViewCell()
        }
        cell.chatUserName.text = groupList[indexPath.row].name
        cell.ImageView.image = groupList[indexPath.row].picture
        return cell
        
    }
    
    @IBAction func clickBackbtn(_ sender: UIButton) {
        NAVIGATION.BackToPreviousController()
    }
    
    
    func getGroupListing(){
        Group.GroupList { (group) in
            self.groupList.append(group)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
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
