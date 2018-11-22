//
//  FireImageManager.swift
//  FireCache
//
//  Created by Jitendra Gandhi on 19/11/18.
//

import UIKit

public final class FireImageManager {
    
    //Shared Image Manager used for caching images.
    public static let shared: FireManager<UIImage> = {
        return FireManager<UIImage>()
    }()
}

public final class FireJSONManager {
    
    //Shared JSON Manager used for caching Json.
    public static let shared: FireManager<JSON> = {
        return FireManager<JSON>()
    }()
}

public final class FireStringManager {
    
    //Shared String Manager used for caching String data.
    public static let shared: FireManager<String> = {
        return FireManager<String>()
    }()
}
