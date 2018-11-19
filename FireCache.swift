//
//  ImageCache.swift
//  FireCache
//
//  Created by Jitendra Gandhi on 16/11/2018.
//

import UIKit
import Foundation

public class FireCache<T: Cacheable> {
    
    // MARK: - Data
    
    private let memoryCache = NSCache<NSString, AnyObject>()
    
    var maxMemoryCost: UInt = 0 {
        didSet {
            self.memoryCache.totalCostLimit = Int(maxMemoryCost)
        }
    }
    
    // MARK: - Initializer
    
    public init() {
        
        let bundleId =  Bundle.main.bundleIdentifier ?? ""
        let cacheName = bundleId + ".\(T.self)"
        memoryCache.name = cacheName
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(clearMemoryCache),
                                               name: UIApplication.didReceiveMemoryWarningNotification,
                                               object: nil)
    }
    
    // MARK: - DeInitializer
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Public Methods
    
    public func store(_ object: T,
                      forKey key: String,
                      completionHandler: (() -> Void)? = nil) {
        
        memoryCache.setObject(object as AnyObject, forKey: key as NSString)
        completionHandler?()
    }
    
    public func removeImage(forKey key: String,
                            completionHandler: (() -> Void)? = nil) {
        
        memoryCache.removeObject(forKey: key as NSString)
        completionHandler?()
    }
    
    public func retrieve(forKey key: String) -> T? {
        return memoryCache.object(forKey: key as NSString) as? T
    }
    
    @objc
    public func clearMemoryCache() {
        memoryCache.removeAllObjects()
    }
}
