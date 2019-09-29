//
//  MyChatCell.swift
//  EASY
//
//  Created by Rohit Saini on 15/01/19.
//  Copyright © 2019 Rohit Saini. All rights reserved.
//

import UIKit

class MyChatCell: UITableViewCell {

    @IBOutlet weak var chatUserName: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        ImageView.roundCorners([.topLeft, .bottomLeft], radius: 10)
        // Configure the view for the selected state
    }
    
}
