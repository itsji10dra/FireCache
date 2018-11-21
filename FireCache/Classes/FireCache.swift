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

    public var cacheLifeSpan: TimeInterval = 60

    public var expiryCheckTimeInterval: TimeInterval = 30 {
        didSet {
            resetTimer()
        }
    }
    
    public var maximumSize: Int = FireConfiguration.defaultMaximumMemoryCost {
        didSet {
            self.memoryCache.totalCostLimit = maximumSize
        }
    }

    // MARK: - Initializer
    
    public init() {
        
        let bundleId =  Bundle.main.bundleIdentifier ?? ""
        let cacheName = bundleId + ".\(T.self)"
        memoryCache.name = cacheName
        memoryCache.totalCostLimit = maximumSize
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(clearMemoryCache),
                                               name: UIApplication.didReceiveMemoryWarningNotification,
                                               object: nil)
        
        initiateTimer()
    }
    
    // MARK: - DeInitializer
    
    deinit {
        expiryCheckTimer.invalidate()
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Private Methods

    private func initiateTimer() {
        expiryCheckTimer = Timer.scheduledTimer(withTimeInterval: expiryCheckTimeInterval,
                                                repeats: true,
                                                block: { [weak self] _ in
                                                    self?.clearExpiredCache()
        })
    }
    
    private func resetTimer() {
        expiryCheckTimer.invalidate()
        initiateTimer()
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
        lastAccessed.removeValue(forKey: key)
        completionHandler?()
    }
    
    public func retrieve(forKey key: String) -> T? {
        guard let object = memoryCache.object(forKey: key as NSString) as? T else { return nil }
        lastAccessed[key] = Date()
        return object
    }
    
    public func contains(forKey key: String) -> Bool {
        return memoryCache.object(forKey: key as NSString) != nil
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
