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
    
    private lazy var dataSource: [E] = []
    
    private var dataTask: URLSessionDataTask?
    
    private lazy var networkManager = NetworkManager()
    
    private var lastPageLoaded: Int = -1
    
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
        
        //Figure out next page number to be loaded
        let nextPage = lastPageLoaded + 1
        
        //Do not load, if last data task is already in progress.
        guard dataTask?.state != .running else { return (true, nextPage) }

        //Add `if` statement and load, only if next page is available.
        //--
            
        //Load next page
        loadData(page: UInt(nextPage), completionHandler: handler)
        
        return (true, nextPage)
    }
    
    public func clearDataSource() {
        lastPageLoaded = -1
        dataSource.removeAll()
    }
    
    // MARK: - Private Methods
    
    private func loadData(page number: UInt = 0, completionHandler: @escaping PagingDataResult) {
        
        print("Loading Page:", number, " ↔️ Endpoint:", endPoint.rawValue)
        
        #warning("Passing `page` as `nil` for `pastebin.com` -- This will load same page again n again.")
        guard let url = URLManager.getURLForEndpoint(endpoint: endPoint, page: nil) else { return }
        
        dataTask = networkManager.dataTaskFromURL(url,
                                                  completion: { [weak self] (result: Result<[T]>) in
                                                    
            switch result {
            case .success(let response):
                print(" • Page:", number, " success")
                
                guard let data = self?.transform(response) else { return completionHandler([], nil, number) }
                
                self?.lastPageLoaded = Int(number)
                
                self?.dataSource.append(contentsOf: data)
                
                completionHandler(self?.dataSource, nil, UInt(number))
                
            case .failure(let error):
                print(" • Page:", number, " failed. Reason: ", error.localizedDescription)
                completionHandler(nil, error, number)
            }
            
            print("--------------------------------------------------------------------------------------")
        })
        
        dataTask?.resume()
    }
}
