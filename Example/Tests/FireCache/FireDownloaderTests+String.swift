//
//  FireDownloaderTests+String.swift
//  FireCache_Tests
//
//  Created by Jitendra Gandhi on 23/11/18.
//  Copyright © 2018 itsji10dra.com. All rights reserved.
//

import XCTest
import FireCache

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
                
        _ = stringDownloader.downloadObject(with: errorURL) { (string, error) in
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
        
        _ = stringDownloader.downloadObject(with: jsonURL) { (json, error) in
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
        
        _ = stringDownloader.downloadObject(with: imageURL) { (image, error) in
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
