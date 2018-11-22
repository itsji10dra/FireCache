//
//  FireDownloader.swift
//  FireCache
//
//  Created by Jitendra Gandhi on 16/11/2018.
//

import UIKit
import Foundation

public class FireDownloader<T: Cacheable>: NSObject, URLSessionDataDelegate {
    
    // MARK: - Alias
    
    public typealias DownloadHandler = ((_ object: T?, _ error: Error?) -> Void)
    
    // MARK: - Data

    class ObjectFetchLoad {
        var handlers = [DownloadHandler?]()
        var responseData = NSMutableData()
        var downloadTaskCount = 0
        var downloadTask: FireDownloadTask<T>?
    }
    
    private var session: URLSession!
    
    private var fetchLoads: [URL:ObjectFetchLoad] = [:]
    
    public var cachePolicy: URLRequest.CachePolicy = FireConfiguration.requestCachePolicy
    
    public var requestTimeout: TimeInterval = FireConfiguration.requestTimeoutSeconds

    public var httpMaximumConnectionsPerHost: Int = FireConfiguration.httpMaximumConnectionsPerHost {
        didSet {
            session.configuration.httpMaximumConnectionsPerHost = httpMaximumConnectionsPerHost
        }
    }
    
    // MARK: - Initializer
    
    override init() {
        super.init()
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = requestTimeout
        configuration.httpMaximumConnectionsPerHost = httpMaximumConnectionsPerHost
        configuration.requestCachePolicy = cachePolicy

        self.session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }
    
    // MARK: - DeInitializer
    
    deinit {
        session.invalidateAndCancel()
    }
    
    // MARK: - Public Methods
    
    public func downloadObject(with url: URL,
                               completionHandler: DownloadHandler? = nil) -> FireDownloadTask<T>? {
        
        let loadObjectForURL = fetchLoads[url] ?? ObjectFetchLoad()
        
        let index = loadObjectForURL.handlers.count
        
        loadObjectForURL.handlers.append(completionHandler)

        func createNewDownloadTask(from url: URL) -> FireDownloadTask<T> {
            let request = URLRequest(url: url,
                                     cachePolicy: cachePolicy,
                                     timeoutInterval: requestTimeout)
            let dataTask = session.dataTask(with: request)
            let fireDownloadTask = FireDownloadTask<T>(dataTask: dataTask, downloader: self, handlerIndex: index)
            dataTask.resume()
            return fireDownloadTask
        }
        
        if loadObjectForURL.downloadTask == nil {
            let downloadTask = createNewDownloadTask(from: url)
            loadObjectForURL.downloadTask = downloadTask
        } else {
            loadObjectForURL.downloadTask?.handlerIndex = index
        }
        
        loadObjectForURL.downloadTaskCount += 1
        fetchLoads[url] = loadObjectForURL
        
        return loadObjectForURL.downloadTask
    }
    
    public func removeAllLoads() {
        session.invalidateAndCancel()
        fetchLoads.removeAll()
    }
    
    // MARK: - Internal Methods

    internal func cancel(_ task: FireDownloadTask<T>) {
        
        guard let url = task.url,
            let fetchLoad = fetchLoads[url] else { return }

        fetchLoad.downloadTaskCount -= 1
        
        let handler = fetchLoad.handlers.remove(at: task.handlerIndex)
        let error = NSError(domain: "Cancelled", code: NSURLErrorCancelled, userInfo: nil)
        handler?(nil, error as Error)
        
        if fetchLoad.downloadTaskCount == 0 {
            task.dataTask.cancel()
        }
    }

    // MARK: - Private Methods
    
    private func processObject(for url: URL) {
        
        guard let fetchLoad = fetchLoads[url] else { return }
        
        let data = fetchLoad.responseData
        
        let key = url.absoluteString
        
        var objectCache: [String:T] = [:]
        
        for handler in fetchLoad.handlers {
            
            var object: T? = objectCache[key]
            var error: Error? = nil
            
            if object == nil || error == nil {
                do {
                    if let newObject = try T.convertFromData(data as Data) as? T {
                        objectCache[key] = newObject
                        object = newObject
                    }
                } catch let parsingError {
                    error = parsingError
                }
            }
            
            handler?(object, error)
        }
        
        fetchLoads.removeValue(forKey: url)
    }
    
    // MARK: - URLSessionDataDelegate
    
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        
        guard let url = dataTask.originalRequest?.url,
            let fetchLoad = fetchLoads[url] else { return }
        
        fetchLoad.responseData.append(data)
    }
    
    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        
        guard let url = task.originalRequest?.url else { return }
        
        guard error == nil else {           //Server Error, notify everyone.
            let load = fetchLoads.removeValue(forKey: url)
            load?.handlers.forEach({ handler in handler?(nil, error) })
            return
        }
        
        processObject(for: url)             //Download Finish, create object and notify.
    }
}
