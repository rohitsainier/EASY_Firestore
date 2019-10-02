//
//  PostListingVC.swift
//  EASY
//
//  Created by Rohit Saini on 02/10/19.
//  Copyright © 2019 Rohit Saini. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class PostListingVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var postCategory: String = ""
    private var postArr: [FirebasePost] = [FirebasePost]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPosts()
        checkForPostUpdates()
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.register(UINib.init(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "PostCell")

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.tabBarController != nil
        {
            let tabBar : CustomTabBarController = self.tabBarController as! CustomTabBarController
            self.edgesForExtendedLayout = UIRectEdge.bottom
            tabBar.setTabBarHidden(tabBarHidden: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height - 50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostCell else {
            return UITableViewCell()
        }
        if postArr[indexPath.row].mediaType == "IMAGE"{
        cell.postImageView.contentMode = .scaleAspectFill
        cell.usernameLbl.text = postArr[indexPath.row].username
        cell.postContentLbl.text = postArr[indexPath.row].postText
        cell.dateLbl.text = ""
        cell.postImageView.downloadCachedImage(placeholder: "", urlString: postArr[indexPath.row].postUrl)
        let UserImage = UIImageView()
            UserImage.downloadCachedImage(placeholder: "", urlString: postArr[indexPath.row].creatorProfilePic)
        cell.userBtn.setImage(UserImage.image, for: UIControl.State.normal)
        }
        else{
            cell.postImageView.contentMode = .scaleAspectFit
            cell.usernameLbl.text = postArr[indexPath.row].username
            cell.postContentLbl.text = postArr[indexPath.row].postText
            cell.dateLbl.text = ""
            cell.postImageView.image = UIImage(named: "play")
            let UserImage = UIImageView()
                UserImage.downloadCachedImage(placeholder: "", urlString: postArr[indexPath.row].creatorProfilePic)
            cell.userBtn.setImage(UserImage.image, for: UIControl.State.normal)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if postArr[indexPath.row].mediaType == "VIDEO"{
            let videoURL = URL(string: postArr[indexPath.row].postUrl)
        let player = AVPlayer(url: videoURL!)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
        }
    }
    
    @IBAction func clickBackBtn(_ sender: UIButton) {
        NAVIGATION.BackToPreviousController()
    }
    
    
    
    
    //Loading the data for first time
    private func loadPosts(){
        User.showPosts(categoryName: postCategory) { [unowned self](posts) in
            self.postArr = posts
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    private func checkForPostUpdates(){
        User.updatedPosts(categoryName: postCategory) { [unowned self](post) in
            self.postArr.append(post)
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
