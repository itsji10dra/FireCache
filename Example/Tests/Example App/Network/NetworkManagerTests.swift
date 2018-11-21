//
//  NetworkManagerTests.swift
//  FireCache_Tests
//
//  Created by Jitendra Gandhi on 21/11/18.
//  Copyright © 2018 itsji10dra.com. All rights reserved.
//

import XCTest
@testable import FireCache_Example

class NetworkManagerTests: XCTestCase {

    var session: URLSessionMock!
    var manager: NetworkManager!

    override func setUp() {
        session = URLSessionMock()
        manager = NetworkManager(session: session)
    }
    
    func testSuccess() {
        
        let data = getSuccessData()
        session.data = data
        session.error = nil

        let url = URL(fileURLWithPath: "http://mocktest.url")

        var result: Result<[Post]>? = nil
        let task = manager.dataTaskFromURL(url, completion: { result = $0 })
        task.resume()
        XCTAssertNotNil(result)

        switch result {
        case .success(let response)?:
            XCTAssertNotNil(response)
            XCTAssertEqual(response.count, 10)
            XCTAssertEqual(response.first?.id, "4kQA1aQK8-Y")
            XCTAssertEqual(response.last?.id, "sTBdWFQKDHE")

        case .failure(let error)?:
            XCTAssertNil(error)
        
        case .none:
            XCTFail("Unknown Case Occurred")
        }
    }
    
    func testError() {
        session.error = NSError(domain: "Some Error Domain", code: 101) as Error

        let url = URL(fileURLWithPath: "http://mocktest.url")
        
        var result: Result<[Post]>? = nil
        let task = manager.dataTaskFromURL(url, completion: { result = $0 })
        task.resume()
        XCTAssertNotNil(result)
        
        switch result {
        case .success(let response)?:
            XCTAssertNil(response)
            
        case .failure(let error)?:
            XCTAssertNotNil(error)
            XCTAssertEqual((error as NSError).code, 101)
            XCTAssertEqual((error as NSError).domain, "Some Error Domain")

        case .none:
            XCTFail("Unknown Case Occurred")
        }
    }
    
    private func getSuccessData() -> Data {
        
        let testBundle = Bundle(for: type(of: self))
        
        guard let fileURL = testBundle.url(forResource: "Success", withExtension: "json") else {
            fatalError("Unable to load JSON from bundle")
        }
        
        guard let data = try? Data(contentsOf: fileURL) else { fatalError("Data conversion failed.") }
        
        return data
    }
}
