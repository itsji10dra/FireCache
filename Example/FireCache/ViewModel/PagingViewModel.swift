//
//  PagingViewModel.swift
//  FireCache_Example
//
//  Created by Jitendra Gandhi on 19/11/18.
//  Copyright © 2018 itsji10dra.com. All rights reserved.
//

import Foundation

///
/// T: Expected array model from server
/// E: Desired array model object
///

class PagingViewModel<T, E> where T:Decodable {
    
    typealias PagingDataResult = ((_ data: [E]?, _ error: Error?, _ page: UInt) -> Void)
    
    // MARK: - Private Properties
    
    private lazy var receivedDataSource: [T] = []
    
    private lazy var dataSource: [E] = []
    
    private var dataTask: URLSessionDataTask?
    
    private lazy var networkManager = NetworkManager()
    
    private var failedTaskCount: Int = 0
    
    private var totalRequestMade: Int {
        return dataTask?.taskIdentifier ?? 0
    }
    
    // MARK: - Public Properties
    
    private let transform: (([T]) -> [E])
    
    private let endPoint: EndPoint
        
    // MARK: - Initializer
    
    init(endPoint: EndPoint, transform block: @escaping (([T]) -> [E])) {
        self.endPoint = endPoint
        self.transform = block
    }
    
    // MARK: - De-Initializer
    
    deinit {
        dataTask?.cancel()
    }
    
    // MARK: - Public Methods
    
    @discardableResult
    public func loadMoreData(handler: @escaping PagingDataResult) -> (isLoading: Bool, page: Int) {
        
        let nextPage = 0
        
        guard dataTask?.state != .running else { return (true, nextPage) } //Do not load, if last data task is already in progress.

//        let totalSuccessfullRequest = totalRequestMade - failedTaskCount
//
//        guard totalSuccessfullRequest == Int(nextPage) &&   //Checking right track.
//            (nextPage == 0 ||       //Just load, coz it's first page.
//                nextPage < pageInfo.totalPages) else { return (false, nextPage) }   //Load, only if next page is available.
        
        loadData(page: UInt(nextPage), completionHandler: handler)
        
        return (true, nextPage)
    }
    
    public func dataSource(at index: Int) -> T? {
        return index < receivedDataSource.count ? receivedDataSource[index] : nil
    }
    
    public func clearDataSource() {
        receivedDataSource.removeAll()
        dataSource.removeAll()
    }
    
    // MARK: - Private Methods
    
    private func loadData(page number: UInt = 0, completionHandler: @escaping PagingDataResult) {
        
        print("Loading Page:", number, " ↔️ Endpoint:", endPoint.rawValue)
        
        guard let url = URLManager.getURLForEndpoint(endpoint: endPoint, page: nil) else { return }     //Passing page as `nil` for `pastebin.com`
        
        dataTask = networkManager.dataTaskFromURL(url,
                                                  completion: { [weak self] (result: Result<[T]>) in
                                                    
            switch result {
            case .success(let response):
                print(" • Page:", number, " success")
                
                guard let data = self?.transform(response) else { return completionHandler([], nil, number) }
                
                self?.receivedDataSource.append(contentsOf: response)
                
                self?.dataSource.append(contentsOf: data)
                
                completionHandler(self?.dataSource, nil, UInt(number))
                
            case .failure(let error):
                print(" • Page:", number, " failed. Reason: ", error.localizedDescription)
                self?.failedTaskCount += 1
                completionHandler(nil, error, number)
            }
            
            print("--------------------------------------------------------------------------------------")
        })
        
        dataTask?.resume()
    }
}
