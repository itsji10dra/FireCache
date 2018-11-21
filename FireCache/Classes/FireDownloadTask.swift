//
//  FireDownloadTask.swift
//  FireCache
//
//  Created by Jitendra Gandhi on 20/11/18.
//

import Foundation

public struct FireDownloadTask<T: Cacheable> {
    
    // MARK: - Data

    internal let dataTask: URLSessionDataTask

    public private(set) weak var downloader: FireDownloader<T>?
    
    internal var handlerIndex: Int
    
    // MARK: - Public Properties

    public var url: URL? {
        return dataTask.originalRequest?.url
    }
    
    public var priority: Float {
        get {
            return dataTask.priority
        }
        set {
            dataTask.priority = newValue
        }
    }

    // MARK: - Public Methods

    public func cancel() {
        downloader?.cancel(self)
    }
}
