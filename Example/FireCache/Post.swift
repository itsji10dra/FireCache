//
//  Post.swift
//  FireCache_Example
//
//  Created by Jitendra Gandhi on 19/11/18.
//  Copyright © 2018 itsji10dra.com. All rights reserved.
//

import Foundation

struct Post: Decodable {
    
    enum PostImage: String, Decodable {
        case raw, full, regular, small, thumb
    }

    let id: Int32
    
    let color: String
    
    let likes: Int
    
    let likedByUser: Bool
    
    let images: [PostImage:URL]
    
    enum CodingKeys: String, CodingKey {
        case id
        case color
        case likes
        case likedByUser = "liked_by_user"
        case images = "urls"
    }
}
