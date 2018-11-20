//
//  FireConfiguration.swift
//  FireCache
//
//  Created by Jitendra Gandhi on 20/11/18.
//

import Foundation

public class FireConfiguration {
    
    public static var requestTimeoutSeconds = 60.0
    
    public static var maximumSimultaneousDownloads = 50
    
    public static var requestCachePolicy = URLRequest.CachePolicy.useProtocolCachePolicy
}
