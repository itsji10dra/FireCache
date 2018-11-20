//
//  FireConfiguration.swift
//  FireCache
//
//  Created by Jitendra Gandhi on 20/11/18.
//

import Foundation

public class FireConfiguration {
    
    public static var showLogs = false
    
    public static var requestTimeoutSeconds = 20.0
    
    public static var resourceTimeoutSeconds = 20.0

    public static var maximumSimultaneousDownloads = 20
    
    public static var requestCachePolicy = URLRequest.CachePolicy.useProtocolCachePolicy
}
