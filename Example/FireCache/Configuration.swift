//
//  Configuration.swift
//  FireCache_Example
//
//  Created by Jitendra Gandhi on 19/11/18.
//  Copyright © 2018 itsji10dra.com. All rights reserved.
//

import FireCache

struct Configuration {
    
    // Mark: - App Configuration

    static let url = "https://pastebin.com/"
    
    static let pageSize = 15     //Adding it, just for demonstrating pagination.

    // Mark: - Initializer
    
    private init() { }      //Private, init not allowed
    
    // Mark: - Methods
    
    static func checkConfiguration() {
        if url.isEmpty {
            fatalError("Invalid configuration found.")
        }
    }
}

extension Configuration {
    
    // Mark: - Fire Configuration

    static func loadFireConfiguration() {
        FireConfiguration.showLogs = false
        FireConfiguration.requestTimeoutSeconds = 15
        FireConfiguration.maximumSimultaneousDownloads = 20
        FireConfiguration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    }
}
