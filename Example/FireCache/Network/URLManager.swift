//
//  URLManager.swift
//  FireCache_Example
//
//  Created by Jitendra Gandhi on 19/11/18.
//  Copyright © 2018 itsji10dra.com. All rights reserved.
//

import Foundation

struct URLManager {
    
    // MARK: - Public Methods
    
    public static func getURLForEndpoint(endpoint: EndPoint, page: UInt? = nil) -> URL? {
        
        let url = Configuration.url + endpoint.rawValue
        
        guard var urlComponents = URLComponents(string: url) else { return nil }
        
        //Append any query parameters like page number etc.
        let pagingQueryItems = getPagingQueryItemsWithPage(page)

        urlComponents.queryItems = pagingQueryItems
        
        return urlComponents.url
    }
    
    // MARK: - Private Methods
    
    private static func getPagingQueryItemsWithPage(_ pageNumber: UInt?) -> [URLQueryItem] { 
        
        guard let pageNumber = pageNumber else { return [] }
        
        let parameters = ["page"    : "\(pageNumber)",
                         "pageSize": "\(Configuration.pageSize)"]
        
        let queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
        
        return queryItems
    }
}
