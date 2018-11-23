//
//  FireError.swift
//  FireCache
//
//  Created by Jitendra Gandhi on 22/11/18.
//

public enum FireError: Error {
    
    case invalidResponse
    
    var localizedDescription: String {
        switch self {
        case .invalidResponse:
            return "Invalid data received. Unable to transform to cacheable object."
        }
    }
}
