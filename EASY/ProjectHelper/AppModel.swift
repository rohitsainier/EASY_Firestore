//
//  AppModel.swift
//  ADEQ
//
//  Created by Rohit Saini on 21/02/19.
//  Copyright © 2019 Rohit Saini. All rights reserved.
//

import UIKit

protocol DocumentSerializable {
    init?(dictionary:[String: Any])
}

class AppModel: NSObject {
    static let shared = AppModel()
    var loggedInUser: FirebaseUser!
}

struct FirebaseUser: Codable{
    let id: String
    let name: String
    let email: String
    let profilePicLink: String
    let phoneNumber: String
    
    
    enum CodingKeys: String, CodingKey {
        case id,name, email, profilePicLink, phoneNumber
    }
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id) ?? ""
        name = try values.decodeIfPresent(String.self, forKey: .name) ?? ""
        email = try values.decodeIfPresent(String.self, forKey: .email) ?? ""
        profilePicLink = try values.decodeIfPresent(String.self, forKey: .profilePicLink) ?? ""
        phoneNumber = try values.decodeIfPresent(String.self, forKey: .phoneNumber) ?? ""
    }
}


struct FirebasePost{
    let userId: String
    let postId: String
    let username: String
    let categoryId: String
    let categoryName: String
    let postText: String
    let mediaType: String
    let postUrl:String
    let creatorProfilePic:String
    
    var dictionary: [String: Any]{
        return[
            "userId":userId,
            "postId":postId,
            "username":username,
            "categoryId":categoryId,
            "categoryName":categoryName,
            "postText":postText,
            "mediaType":mediaType,
            "postUrl":postUrl,
            "creatorProfilePic":creatorProfilePic
        ]
    }
}

extension FirebasePost: DocumentSerializable{
    init?(dictionary: [String : Any]) {
       guard let userId = dictionary["userId"] as? String,
             let postId = dictionary["postId"] as? String,
             let username = dictionary["username"] as? String,
             let categoryId = dictionary["categoryId"] as? String,
             let categoryName = dictionary["categoryName"] as? String,
             let postText = dictionary["postText"] as? String,
             let mediaType = dictionary["mediaType"] as? String,
             let creatorProfilePic = dictionary["creatorProfilePic"] as? String,
             let postUrl = dictionary["postUrl"] as? String else{return nil}
        self.init(userId: userId,postId: postId,username:username,categoryId:categoryId,categoryName:categoryName,postText:postText,mediaType:mediaType,postUrl:postUrl,creatorProfilePic:creatorProfilePic)
    }
}

