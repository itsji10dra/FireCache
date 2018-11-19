//
//  Post.swift
//  FireCache_Example
//
//  Created by Jitendra Gandhi on 19/11/18.
//  Copyright © 2018 itsji10dra.com. All rights reserved.
//

import Foundation

struct Post: Decodable {
    
    struct PostImage: Decodable {
        let regular: URL
    }

    let id: String
    
    let color: String
    
    let likes: Int
    
    let likedByUser: Bool
    
    let user: User
    
    let images: PostImage
    
    enum CodingKeys: String, CodingKey {
        case id
        case color
        case likes
        case likedByUser = "liked_by_user"
        case user
        case images = "urls"
    }
}
