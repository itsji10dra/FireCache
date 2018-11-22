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

    var downloader: FireDownloader<UIImage>!

    override func setUp() {
        super.setUp()
        downloader = .init()
    }

    override func tearDown() {
        downloader = nil
        super.tearDown()
    }

    func testCachePolicy() {
        downloader.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        XCTAssertEqual(downloader.cachePolicy, .reloadIgnoringLocalAndRemoteCacheData)
    }
    
    func testRequestTimeout() {
        downloader.requestTimeout = 20
        XCTAssertEqual(downloader.requestTimeout, 20)
    }

    func testHTTPMaximumConnectionsPerHost() {
        downloader.httpMaximumConnectionsPerHost = 10
        XCTAssertEqual(downloader.httpMaximumConnectionsPerHost, 10)
    }

    func testDownloadAnImage() {
        let expectation = self.expectation(description: "wait for downloading image")
        
        let url = URL(string: "https://avatars0.githubusercontent.com/u/13048696?s=460&v=4")!
        
        _ = downloader.downloadObject(with: url) { (image, error) in
            expectation.fulfill()
            XCTAssertNotNil(image)
            XCTAssertNil(error)
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testDownloadAnImageWithError() {
        let expectation = self.expectation(description: "wait for throwing error")
        
        let url = URL(string: "https://abc.com")!
        
        _ = downloader.downloadObject(with: url) { (image, error) in
            expectation.fulfill()
            XCTAssertNotNil(error)
            XCTAssertNil(image)
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testDownloadAString() {
        let expectation = self.expectation(description: "wait for downloading string")
        
        let url = URL(string: "https://pastebin.com/raw/B75vJCLX")!
        
        _ = downloader.downloadObject(with: url) { (image, error) in
            expectation.fulfill()
            XCTAssertNotNil(error)
            XCTAssertNil(image)
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

}
