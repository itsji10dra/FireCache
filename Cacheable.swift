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
    
    case Dictionary([String:AnyObject])
    case Array([AnyObject])
    
    public static func convertFromData(_ data: Data) -> JSON? {
        do {
            let object : Any = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
            switch (object) {
            case let dictionary as [String:AnyObject]:
                return JSON.Dictionary(dictionary)
            case let array as [AnyObject]:
                return JSON.Array(array)
            default:
                return nil
            }
        } catch {
            print("Invalid JSON data")
            return nil
        }
    }
    
    public var array : [AnyObject]! {
        switch (self) {
        case .Dictionary(_):
            return nil
        case .Array(let array):
            return array
        }
    }
    
    public var dictionary : [String:AnyObject]! {
        switch (self) {
        case .Dictionary(let dictionary):
            return dictionary
        case .Array(_):
            return nil
        }
    }
}
