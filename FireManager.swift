//
//  FireImageManager.swift
//  FireCache
//
//  Created by Jitendra Gandhi on 16/11/2018.
//

import UIKit
import Foundation

public class FireManager<T: Cacheable> {
    
    // MARK: - Data
    
    public var cache: FireCache<T>
    
    public var downloader: FireDownloader<T>
    
    // MARK: - Initializer
    
    public init() {
        self.downloader = FireDownloader<T>()
        self.cache = FireCache<T>()
    }
    
    // MARK: - Public Methods
    
    @discardableResult
    public func fetch(with url: URL,
                      completionHandler: ((T, URL) -> Void)? = nil) -> URLSessionDataTask? {
        
        let key = url.lastPathComponent
        
        if let object = cache.retrieve(forKey: key) {
            completionHandler?(object, url)
            return nil
        }
        
        return downloader.downloadObject(with: url,
                                         completionHandler: { [weak self] (object, _) in
                                            
            if let object = object {
                self?.cache.store(object, forKey: key)
                completionHandler?(object, url)
            }
        })
    }
    
    public func invalidate() {
        downloader.removeAllLoads()
        cache.clearMemoryCache()
    }
}
