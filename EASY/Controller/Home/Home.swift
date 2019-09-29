//
//  Home.swift
//  EASY
//
//  Created by Rohit Saini on 15/01/19.
//  Copyright © 2019 Rohit Saini. All rights reserved.
//

import UIKit

class Home: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        return GROUPS_CATEGORIES.GROUP_PHOTOS_PLUS_NAME.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyChatCell") as? MyChatCell else {
            return UITableViewCell()
        }
        
        cell.chatUserName.text = GROUPS_CATEGORIES.GROUP_PHOTOS_PLUS_NAME[indexPath.row]
        cell.ImageView.image = UIImage(named: GROUPS_CATEGORIES.GROUP_PHOTOS_PLUS_NAME[indexPath.row])
        return cell
        
    }
    
  
    
    private func getCategoriesList(){
        
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
