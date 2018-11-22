//
//  FireConfiguration.swift
//  FireCache
//
//  Created by Jitendra Gandhi on 20/11/18.
//

import Foundation

public class FireConfiguration {
    
    //Console
    public static var showLogs: Bool = false
    
    //Network
    public static var requestTimeoutSeconds: TimeInterval = 20.0
    
    public static var httpMaximumConnectionsPerHost: Int = 20
    
    public static var requestCachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy
    
    //Memory
    public static var defaultMaximumMemoryCost: Int = 0
}
