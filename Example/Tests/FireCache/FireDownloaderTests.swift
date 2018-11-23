//
//  FireDownloaderTests.swift
//  FireCache_Tests
//
//  Created by Jitendra Gandhi on 22/11/18.
//  Copyright © 2018 itsji10dra.com. All rights reserved.
//

import XCTest
import FireCache

class FireDownloaderTests: XCTestCase {

    var imageDownloader: FireDownloader<UIImage>!
    var stringDownloader: FireDownloader<String>!
    var jsonDownloader: FireDownloader<JSON>!

    override func setUp() {
        super.setUp()
        imageDownloader = .init()
        stringDownloader = .init()
        jsonDownloader = .init()
    }

    override func tearDown() {
        imageDownloader = nil
        stringDownloader = nil
        jsonDownloader = nil
        super.tearDown()
    }

    func testCachePolicy() {
        imageDownloader.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        stringDownloader.cachePolicy = .returnCacheDataElseLoad
        jsonDownloader.cachePolicy = .reloadRevalidatingCacheData
        XCTAssertEqual(imageDownloader.cachePolicy, .reloadIgnoringLocalAndRemoteCacheData)
        XCTAssertEqual(stringDownloader.cachePolicy, .returnCacheDataElseLoad)
        XCTAssertEqual(jsonDownloader.cachePolicy, .reloadRevalidatingCacheData)
    }
    
    func testRequestTimeout() {
        imageDownloader.requestTimeout = 20
        stringDownloader.requestTimeout = 25
        jsonDownloader.requestTimeout = 30
        XCTAssertEqual(imageDownloader.requestTimeout, 20)
        XCTAssertEqual(stringDownloader.requestTimeout, 25)
        XCTAssertEqual(jsonDownloader.requestTimeout, 30)
    }

    func testHTTPMaximumConnectionsPerHost() {
        imageDownloader.httpMaximumConnectionsPerHost = 10
        stringDownloader.httpMaximumConnectionsPerHost = 12
        jsonDownloader.httpMaximumConnectionsPerHost = 15
        XCTAssertEqual(imageDownloader.httpMaximumConnectionsPerHost, 10)
        XCTAssertEqual(stringDownloader.httpMaximumConnectionsPerHost, 12)
        XCTAssertEqual(jsonDownloader.httpMaximumConnectionsPerHost, 15)
    }
}

// MARK: UIImage

extension FireDownloaderTests {
    
    func testDownloadImage() {
        let expectation = self.expectation(description: "Wait for downloading image")
        
        let url = URL(string: "https://avatars0.githubusercontent.com/u/13048696?s=460&v=4")!
        
        _ = imageDownloader.downloadObject(with: url) { (image, error) in
            XCTAssertNotNil(image)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("Wait for downloading image - Expectations Timeout errored: \(error)")
            }
        }
    }
    
    func testDownloadImageWithError() {
        let expectation = self.expectation(description: "Wait for throwing error")
        
        let url = URL(string: "https://abc.com")!
        
        _ = imageDownloader.downloadObject(with: url) { (image, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(image)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Wait for throwing error string - Expectations Timeout errored: \(error)")
            }
        }
    }
    
    func testDownloadStringUsingImageDownloader() {
        let expectation = self.expectation(description: "Wait for downloading string")
        
        let url = URL(string: "https://pastebin.com/raw/B75vJCLX")!
        
        _ = imageDownloader.downloadObject(with: url) { (image, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(image)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Wait for downloading string - Expectations Timeout errored: \(error)")
            }
        }
    }
    
    func testDownloadJSONUsingImageDownloader() {
        let expectation = self.expectation(description: "Wait for downloading string")
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1")!

        _ = imageDownloader.downloadObject(with: url) { (json, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(json)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Wait for downloading string - Expectations Timeout errored: \(error)")
            }
        }
    }
}

// MARK: String

extension FireDownloaderTests {
    
    func testDownloadString() {
        let expectation = self.expectation(description: "Wait for downloading string")
        
        let url = URL(string: "https://pastebin.com/raw/B75vJCLX")!
        
        _ = stringDownloader.downloadObject(with: url) { (string, error) in
            XCTAssertNotNil(string)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("Wait for downloading string - Expectations Timeout errored: \(error)")
            }
        }
    }
    
    func testDownloadStringWithError() {
        let expectation = self.expectation(description: "Wait for throwing error")
        
        let url = URL(string: "https://abc.com")!
        
        _ = stringDownloader.downloadObject(with: url) { (string, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(string)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Wait for throwing error string - Expectations Timeout errored: \(error)")
            }
        }
    }
    
    func testDownloadJSONUsingStringDownloader() {
        let expectation = self.expectation(description: "Wait for downloading JSON")
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1")!
        
        _ = stringDownloader.downloadObject(with: url) { (json, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(json)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Wait for downloading JSON - Expectations Timeout errored: \(error)")
            }
        }
    }
    
    func testDownloadImageUsingStringDownloader() {
        let expectation = self.expectation(description: "Wait for downloading JSON")
        
        let url = URL(string: "https://avatars0.githubusercontent.com/u/13048696?s=460&v=4")!

        _ = stringDownloader.downloadObject(with: url) { (image, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(image)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Wait for downloading JSON - Expectations Timeout errored: \(error)")
            }
        }
    }
}

// MARK: JSON

extension FireDownloaderTests {
    
    func testDownloadJSON() {
        let expectation = self.expectation(description: "Wait for downloading JSON")
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1")!

        _ = jsonDownloader.downloadObject(with: url) { (json, error) in
            XCTAssertNotNil(json)
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("Wait for downloading JSON - Expectations Timeout errored: \(error)")
            }
        }
    }
    
    func testDownloadJSONWithError() {
        let expectation = self.expectation(description: "Wait for throwing error")
        
        let url = URL(string: "https://abc.com")!
        
        _ = jsonDownloader.downloadObject(with: url) { (json, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(json)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Wait for throwing error JSON - Expectations Timeout errored: \(error)")
            }
        }
    }
    
    func testDownloadImageUsingJSONDownloader() {
        let expectation = self.expectation(description: "Wait for downloading Image")
        
        let url = URL(string: "https://avatars0.githubusercontent.com/u/13048696?s=460&v=4")!

        _ = jsonDownloader.downloadObject(with: url) { (image, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(image)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Wait for downloading Image - Expectations Timeout errored: \(error)")
            }
        }
    }
    
    func testDownloadStringUsingJSONDownloader() {
        let expectation = self.expectation(description: "Wait for downloading string")
        
        let url = URL(string: "https://pastebin.com/raw/B75vJCLX")!
        
        _ = jsonDownloader.downloadObject(with: url) { (string, error) in
            XCTAssertNotNil(error)
            XCTAssertNil(string)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Wait for downloading string - Expectations Timeout errored: \(error)")
            }
        }
    }
}

