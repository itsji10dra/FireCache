//
//  FireDownloader.swift
//  FireCache
//
//  Created by Jitendra Gandhi on 16/11/2018.
//

import UIKit
import Foundation

public class FireDownloader<T: Cacheable>: NSObject, URLSessionDataDelegate {
    
    public typealias CompletionHandler = ((_ object: T?, _ error: Error?) -> Void)
    
    class ObjectFetchLoad {
        var handlers = [CompletionHandler?]()
        var responseData = NSMutableData()
        var dataTask: URLSessionDataTask?
    }
    
    // MARK: - Data
    
    private var downloadTimeout: TimeInterval = 15.0
    
    private var session: URLSession!
    
    private var fetchLoads: [URL:ObjectFetchLoad] = [:]
    
    // MARK: - Initializer
    
    override init() {
        super.init()
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = FireConfiguration.requestTimeoutSeconds
        configuration.timeoutIntervalForResource = FireConfiguration.requestTimeoutSeconds
        configuration.httpMaximumConnectionsPerHost = FireConfiguration.maximumSimultaneousDownloads
        configuration.requestCachePolicy = FireConfiguration.requestCachePolicy

        self.session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }
    
    // MARK: - DeInitializer
    
    deinit {
        session.invalidateAndCancel()
    }
    
    // MARK: - Public Methods
    
    public func downloadObject(with url: URL,
                               completionHandler: CompletionHandler? = nil) -> URLSessionDataTask {
        
        func createNewDataTask(from url: URL) -> URLSessionDataTask {
            let request = URLRequest(url: url)
            let dataTask = session.dataTask(with: request)
            return dataTask
        }
        
        let loadObjectForURL = fetchLoads[url] ?? ObjectFetchLoad()
        
        loadObjectForURL.handlers.append(completionHandler)
        
        if loadObjectForURL.dataTask == nil {
            let dataTask = createNewDataTask(from: url)
            dataTask.resume()
            loadObjectForURL.dataTask = dataTask
        }
        
        fetchLoads[url] = loadObjectForURL
        
        return loadObjectForURL.dataTask ?? URLSessionDataTask()
    }
    
    public func removeAllLoads() {
        session.invalidateAndCancel()
        fetchLoads.removeAll()
    }
    
    // MARK: - Private Methods
    
    private func processObject(for url: URL) {
        
        guard let fetchLoad = fetchLoads[url] else { return }
        
        let data = fetchLoad.responseData
        
        let key = url.absoluteString
        
        var objectCache: [String:T] = [:]
        
        for handler in fetchLoad.handlers {
            
            var object: T? = objectCache[key]
            
            if object == nil,
                let newObject = T.convertFromData(data as Data) as? T {
                objectCache[key] = newObject
                object = newObject
            }
            
            handler?(object, nil)
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
        
        guard error == nil else {
            fetchLoads.removeValue(forKey: url)
            return
        }
        
        processObject(for: url)
    }
}
