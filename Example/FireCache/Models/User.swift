//
//  User.swift
//  FireCache_Example
//
//  Created by Jitendra Gandhi on 19/11/18.
//  Copyright © 2018 itsji10dra.com. All rights reserved.
//

import Foundation

struct User: Decodable {
    
    struct ProfileImage: Decodable {
        let small: URL
        let medium: URL
        let large: URL
    }

    let id: String
    
    let username: String
    
    let name: String
    
    let profileImage: ProfileImage
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case name
        case profileImage = "profile_image"
    }
}
