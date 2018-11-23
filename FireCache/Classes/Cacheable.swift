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
    
    static func convertFromData(_ data: Data) throws -> Object
}

// MARK: - Cacheable + Extension

extension UIImage: Cacheable {
    
    public typealias Object = UIImage
    
    public static func convertFromData(_ data: Data) throws -> UIImage {
        guard let image = UIImage(data: data) else { throw FireError.invalidData }
        return image
    }
}

extension String: Cacheable {
    
    public typealias Object = String
    
    public static func convertFromData(_ data: Data) throws -> String {
        guard let string = String(data: data, encoding: .utf8) else { throw FireError.invalidData  }
        return string
    }
}

public enum JSON: Cacheable {
    
    public typealias Object = JSON
    
    case dictionary([String:AnyObject])
    case array([AnyObject])
    
    public static func convertFromData(_ data: Data) throws -> JSON {

        let object = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())
        switch object {
        case let dictionary as [String:AnyObject]:
            return JSON.dictionary(dictionary)
        case let array as [AnyObject]:
            return JSON.array(array)
        default:
            throw FireError.invalidData
        }
    }
    
    public var array: [AnyObject]? {
        switch self {
        case .dictionary(_):
            return nil
        case .array(let array):
            return array
        }
    }
    
    public var dictionary: [String:AnyObject]? {
        switch self {
        case .dictionary(let dictionary):
            return dictionary
        case .array(_):
            return nil
        }
    }
}
