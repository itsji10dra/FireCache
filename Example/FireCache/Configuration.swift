//
//  Configuration.swift
//  FireCache_Example
//
//  Created by Jitendra Gandhi on 19/11/18.
//  Copyright © 2018 itsji10dra.com. All rights reserved.
//

struct Configuration {
    
    // Mark: - Configuration

    static let url  = "https://pastebin.com/"
    
    static let pageSize  = "15"

    // Mark: - Initializer
    
    private init() { }      //Private, init not allowed
    
    // Mark: - Methods
    
    static func checkConfiguration() {
        if url.isEmpty {
            fatalError("Invalid configuration found.")
        }
    }
}
