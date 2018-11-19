//
//  Cacheable.swift
//  FireCache
//
//  Created by Jitendra Gandhi on 19/11/18.
//

import Foundation

public protocol Cacheable {
    
    associatedtype Object
    
    static func convertFromData(_ data: Data) -> Object?
}


extension UIImage: Cacheable {
    
    public typealias Object = UIImage
    
    public static func convertFromData(_ data: Data) -> UIImage? {
        return UIImage(data: data)
    }
}
