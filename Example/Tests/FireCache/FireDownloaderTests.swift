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
