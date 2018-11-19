//
//  FireImageManager.swift
//  FireCache
//
//  Created by Jitendra Gandhi on 19/11/18.
//

import UIKit

public final class FireImageManager {
    
    //Shared Image Manager used for downloading images.
    public static let shared: FireManager<UIImage> = {
        return FireManager<UIImage>()
    }()
}

public final class FireJSONManager {
    
    //Shared JSON Manager used for downloading Json data.
    public static let shared: FireManager<JSON> = {
        return FireManager<JSON>()
    }()
}
