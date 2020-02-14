//
//  FireLog.swift
//  FireCache
//
//  Created by Jitendra Gandhi on 20/11/18.
//

import Foundation

public struct FireLog {
    
    // MARK: - Data
    
    private static let Tag = "[FireCache]"
    
    enum Level: String {
        case debug = "[Debug]"
        case error = "[Error]"
    }
    
    // MARK: - Private Static Methods
    
    private static func log(_ level: Level, _ message: @autoclosure () -> String, _ error: Error? = nil) {
        if let error = error {
            print("\(Tag)\(level.rawValue) \(message()) with error \(error.localizedDescription)")
        } else {
            print("\(Tag)\(level.rawValue) \(message())")
        }
        print("--------------------------------------------------------------------------------------")
    }
    
    // MARK: - Internal Static Methods
    
    internal static func debug(message: @autoclosure () -> String, error: Error? = nil) {
        #if DEBUG
            if FireConfiguration.showLogs {
                log(.debug, message(), error)
            }
        #endif
    }
    
    internal static func error(message: @autoclosure () -> String, error: Error? = nil) {
        log(.error, message(), error)
    }
}
