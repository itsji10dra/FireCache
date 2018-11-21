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
    
    private lazy var lastAccessed: [String: Date] = [:]

    private var expiryCheckTimer: Timer!

    public var expiryCheckTimeInterval: TimeInterval = 30

    public var cacheLifeSpan: TimeInterval = 60

    // MARK: - Initializer
    
    public init() {
        
        let bundleId =  Bundle.main.bundleIdentifier ?? ""
        let cacheName = bundleId + ".\(T.self)"
        memoryCache.name = cacheName
        memoryCache.totalCostLimit = FireConfiguration.maximumMemoryCost
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(clearMemoryCache),
                                               name: UIApplication.didReceiveMemoryWarningNotification,
                                               object: nil)

        expiryCheckTimer = Timer.scheduledTimer(withTimeInterval: expiryCheckTimeInterval,
                                                repeats: true,
                                                block: { [weak self] _ in
                                                    self?.clearExpiredCache()
        })
    }
    
    // MARK: - DeInitializer
    
    deinit {
        expiryCheckTimer.invalidate()
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Public Methods
    
    public func store(_ object: T,
                      forKey key: String,
                      completionHandler: (() -> Void)? = nil) {
        memoryCache.setObject(object as AnyObject, forKey: key as NSString)
        lastAccessed[key] = Date()
        completionHandler?()
    }
    
    public func remove(forKey key: String,
                       completionHandler: (() -> Void)? = nil) {
        memoryCache.removeObject(forKey: key as NSString)
        completionHandler?()
    }
    
    public func retrieve(forKey key: String) -> T? {
        lastAccessed[key] = Date()
        return memoryCache.object(forKey: key as NSString) as? T
    }
    
    public func clearExpiredCache() {
        lastAccessed.forEach { (key, access) in
            if Date().timeIntervalSince(access) > cacheLifeSpan {
                remove(forKey: key)
            }
        }
    }
    
    @objc
    public func clearMemoryCache() {
        memoryCache.removeAllObjects()
    }
}
