//
//  FireError.swift
//  FireCache
//
//  Created by Jitendra Gandhi on 22/11/18.
//

public enum FireError: Error {
    
    case invalidData
    
    var localizedDescription: String {
        switch self {
        case .invalidData:
            return "Invalid data received. Unable to transform cacheable object."
        }
    }
}
