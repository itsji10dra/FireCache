//
//  User.swift
//  FireCache_Example
//
//  Created by Jitendra Gandhi on 19/11/18.
//  Copyright © 2018 itsji10dra.com. All rights reserved.
//

import Foundation

struct User: Decodable {
    
    enum ProfileImage: String, Decodable {
        case small, medium, large
    }

    let id: String
    
    let username: String
    
    let name: String
    
    let profileImages: [ProfileImage:URL]
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case name
        case profileImages = "profile_image"
    }
}
