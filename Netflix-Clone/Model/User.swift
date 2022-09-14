//
//  ChatUser.swift
//  Netflix-Clone
//
//  Created by Huy Bui Thanh on 29/08/2022.
//

import Foundation

// MARK: User
struct User: Decodable{
    let uid, email, profileImageUrl: String
    
    init(data: [String: Any]) {
        self.uid = data["uid"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.profileImageUrl = data["profileImageUrl"] as? String ?? ""
    }
}
