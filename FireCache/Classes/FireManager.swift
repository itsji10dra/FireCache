//
//  FireImageManager.swift
//  FireCache
//
//  Created by Jitendra Gandhi on 16/11/2018.
//

import UIKit
import Foundation

public class FireManager<T: Cacheable> {
    
    // MARK: - Alias

    public typealias FetchHandler = ((_ object: T?, _ url: URL, _ error: Error?) -> Void)

    // MARK: - Data
    
    public let cache: FireCache<T>
    
    public let downloader: FireDownloader<T>
    
    // MARK: - Initializer
    
    public init() {
        self.downloader = FireDownloader<T>()
        self.cache = FireCache<T>()
    }
    
    deinit {
        invalidate()
    }
    
    // MARK: - Public Methods
    
    @discardableResult
    public func fetch(with url: URL,
                      completionHandler: FetchHandler? = nil) -> FireDownloadTask<T>? {
        
        let key = url.absoluteString
        
        if let object = cache.retrieve(forKey: key) {
            FireLog.debug(message: "Returning cached → \(T.self) for key → \(key)")
            completionHandler?(object, url, nil)
            return nil
        }
        
        return downloader.downloadObject(with: url,
                                         completionHandler: { [weak self] (object, error) in
                                            
            if let object = object {
                FireLog.debug(message: "Downloaded & cached → \(T.self) for key → \(key)")
                self?.cache.store(object, forKey: key)
                completionHandler?(object, url, nil)
            } else if let error = error {
                FireLog.debug(message: "Error downloading & caching → \(T.self) for key → \(key)", error: error)
                completionHandler?(nil, url, error)
            }
        })
    }
    
    public func invalidate() {
        downloader.removeAllLoads()
        cache.clearMemoryCache()
    }
}
