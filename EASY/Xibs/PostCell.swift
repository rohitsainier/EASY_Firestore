//
//  PostCell.swift
//  EASY
//
//  Created by Rohit Saini on 02/10/19.
//  Copyright © 2019 Rohit Saini. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var postContentLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var userBtn: UIButton!
    @IBOutlet weak var cardView: UIView!
    
    @IBOutlet weak var postImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        customization()
        // Initialization code
    }
    
    private func customization(){
        cardView.layer.cornerRadius =  16
        cardView.layer.masksToBounds = true
        postImageView.layer.cornerRadius =  16
        postImageView.layer.masksToBounds = true
        userBtn.layer.cornerRadius =  userBtn.frame.height / 2
        userBtn.layer.masksToBounds = true
        dateLbl.sainiRotateByAngle(angle: -90)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
