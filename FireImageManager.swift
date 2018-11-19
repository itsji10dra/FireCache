//
//  FireImageManager.swift
//  FireCache
//
//  Created by Jitendra Gandhi on 19/11/18.
//

public class FireImageManager {
    
    //Shared Image Manager used for downloading images.
    public static let shared: FireManager<UIImage> = {
        return FireManager<UIImage>()
    }()
}
