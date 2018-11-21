//
//  Cacheable.swift
//  FireCache
//
//  Created by Jitendra Gandhi on 19/11/18.
//

import Foundation

// MARK: - Cacheable

public protocol Cacheable {
    
    associatedtype Object
    
    static func convertFromData(_ data: Data) -> Object?
}

// MARK: - Cacheable + Extension

extension UIImage: Cacheable {
    
    public typealias Object = UIImage
    
    public static func convertFromData(_ data: Data) -> UIImage? {
        return UIImage(data: data)
    }
}

public enum JSON: Cacheable {
    
    public typealias Object = JSON
    
    case dictionary([String:AnyObject])
    case array([AnyObject])
    
    public static func convertFromData(_ data: Data) -> JSON? {
        do {
            let object = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
            switch (object) {
            case let dictionary as [String:AnyObject]:
                return JSON.dictionary(dictionary)
            case let array as [AnyObject]:
                return JSON.array(array)
            default:
                return nil
            }
        } catch {
            FireLog.error(message: "Invalid JSON data", error: error)
            return nil
        }
    }
    
    public var array: [AnyObject]? {
        switch (self) {
        case .dictionary(_):
            return nil
        case .array(let array):
            return array
        }
    }
    
    public var dictionary: [String:AnyObject]? {
        switch (self) {
        case .dictionary(let dictionary):
            return dictionary
        case .array(_):
            return nil
        }
    }
}
